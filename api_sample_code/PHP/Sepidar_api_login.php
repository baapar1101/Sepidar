<?
	include 'CURL.php';

	/************************************
		Sepidar API Login (PHP)
	************************************/

	// EXAPLE
	$Url = 'http://localhost:7373';
	$Register_Code = '10007bb0';
	$Username = 'test';
	$Password = 'test';

	$Register = Register($Url,$Register_Code);
	if ($Register['status'])
	{
		$Modulus = $Register['Modulus'];
		$Exponent = $Register['Exponent'];

		$Login = Login($Url,$Register_Code,$Username,$Password,$Modulus,$Exponent);

		print_r($Login);

		if ($Login['status'])
		{
			$Token = explode(' || ', $Login['message'])[1];
			$Items = GetItems($Url, $Token);

			print_r($Items);
		}
	}

/***************************FUNCTIONS**********************************/
	// REGISTER IN SEPIDAR
	function Register($Url,$Register_Code)
	{
		$curl = new Curl();

		$IntegrationID = substr($Register_Code, 0,4);
		// REGISTER
		$Key_Maker = Key_Maker($Register_Code);
		$Encrypt = Encrypt($Key_Maker['key'],$Key_Maker['data']);
		$data = json_encode(array(
			"Cypher" => $Encrypt[0],
			"IV" => base64_encode($Encrypt[1]),
			"IntegrationID" => $IntegrationID);
		$result = $curl->post($Url.'/api/Devices/Register/', $data);

		if ($curl->http_status_code == 400 || $curl->error_message != '')
		{
			return array('status' => false, 'message' => $result->Message);
		}
		elseif (($curl->http_status_code == 201 || $curl->http_status_code == 200) && $result->Cypher != '')
		{
			$XML = Decrypt($Key_Maker['key'], $result->Cypher, base64_decode($result->IV));
			$Modulus = get_string_between($XML, 'dulus>', '</Modulus>');
			$Exponent = get_string_between($XML, '<Exponent>', '</Exponent>');
			if ($Modulus != '' && $Exponent != '')
			{
				$Sync_Result = 'دستگاه با نام '.$result->DeviceTitle.' رجیستر شد';
				return array('status' => true, 'message' => $Sync_Result, 'Exponent' => $Exponent, 'Modulus' => $Modulus);
			}
			else
			{
				return array('status' => false, 'message' => 'Exponent and Modulus are empty !');
			}
		}
		elseif ($curl->curl_error_code != '')
		{
			return array('status' => false, 'message' => $curl->curl_error_message);
		}
		else
		{
			return array('status' => false, 'message' => 'خطای ناشناخته !');
		}
	}

	// LOGIN
	function Login($Url,$Register_Code,$Username,$Password,$Modulus,$Exponent)
	{
		$curl = new Curl();
		
		if ($Modulus != '' && $Exponent != '')
		{
			// LOGIN
			$UUID = create_guid();
			$UUID_BA = guid_to_bytes($UUID);
			$RSAEncrypt = RSAEncrypt($UUID_BA,$Modulus,$Exponent);
			$curl->setHeader('GenerationVersion', '101');
			$curl->setHeader('IntegrationID', substr($Register_Code, 0,4));
			$curl->setHeader('ArbitraryCode', $UUID);
			$curl->setHeader('EncArbitraryCode', $RSAEncrypt);
			$body = json_encode(array('UserName' => $Username,'PasswordHash' => md5($Password)));
			$loginRes = $curl->post($Url.'/api/users/login', $body);
			if ($curl->http_status_code == 200 || $curl->http_status_code == 201)
			{
				return array('status' => true, 'message' => $loginRes->Title.' || '.$loginRes->Token);
			}
			elseif ($curl->curl_error_code != '')
			{
				return array('status' => false, 'message' => $curl->curl_error_message);
			}
			else
			{
				return array('status' => false, 'message' => $loginRes->Message);
			}
		}
		else
		{
			return array('status' => false, 'message' => 'Exponent and Modulus are empty !');
		}
	}

	// Get Items
	function GetItems($Url,$Register_Code,$Token)
	{
		$curl = new Curl();
		
		if ($Token != '')
		{
			$UUID = create_guid();
			$UUID_BA = guid_to_bytes($UUID);
			$RSAEncrypt = RSAEncrypt($UUID_BA,$Modulus,$Exponent);
			$curl->setHeader('GenerationVersion', '101');
			$curl->setHeader('Authorization', 'Bearer '.$Token);
			$curl->setHeader('IntegrationID', substr($Register_Code, 0,4));
			$curl->setHeader('ArbitraryCode', $UUID);
			$curl->setHeader('EncArbitraryCode', $RSAEncrypt);
			$result = $curl->get($Url.'/api/items');
			if ($curl->http_status_code == 200 || $curl->http_status_code == 201)
			{
				return array('status' => true, 'message' => 'Succeed', 'data' => result);
			}
			elseif ($curl->curl_error_code != '')
			{
				return array('status' => false, 'message' => $curl->curl_error_message);
			}
			else
			{
				return array('status' => false, 'message' => $loginRes->Message);
			}
		}
		else
		{
			return array('status' => false, 'message' => 'Token is empty !');
		}
	}

	// KEY MAKER
	function Key_Maker($registerCode)
	{
		$key = $registerCode.$registerCode;
		$data = substr($registerCode, 0,4);
		return array('key' => $key, 'data' => $data);
	}

	// ENCRYPT BY RIJNDAEL
	function Encrypt($key, $data)
	{
		if(16 !== strlen($key)) $key = hash('MD5', $key, true);
		$padding = 16 - (strlen($data) % 16);
		$data .= str_repeat(chr($padding), $padding);
		$iv_size = mcrypt_get_iv_size(MCRYPT_RIJNDAEL_128, MCRYPT_MODE_CBC);
		$iv = mcrypt_create_iv($iv_size);
		$encrypt = base64_encode(mcrypt_encrypt(MCRYPT_RIJNDAEL_128, $key, $data, MCRYPT_MODE_CBC, $iv));
		return array($encrypt,$iv);
	}

	// DECRYPT BY RIJNDAEL
	function Decrypt($key, $data, $iv)
	{
		$data = base64_decode($data);
		if(16 !== strlen($key)) $key = hash('MD5', $key, true);
		$data = mcrypt_decrypt(MCRYPT_RIJNDAEL_128, $key, $data, MCRYPT_MODE_CBC, $iv);
		$padding = ord($data[strlen($data) - 1]);
		$result = substr($data, 0, -$padding);
		return $result;
	}

	// ENCRYPT BY RSA
	function RSAEncrypt($UUID_BA,$Modulus,$Exponent)
	{
		$publicKey = '<RSAKeyValue><Modulus>'.$Modulus.'</Modulus><Exponent>'.$Exponent.'</Exponent></RSAKeyValue>';
		$xml = new DOMDocument();
		$xml->loadXML($publicKey);
		$Modulus = base64_decode($xml->getElementsByTagName('Modulus')->item(0)->nodeValue);
		$Exponent = base64_decode($xml->getElementsByTagName('Exponent')->item(0)->nodeValue);

		$modulus = new Math_BigInteger($Modulus, 256);
		$exponent = new Math_BigInteger($Exponent, 256);
		$key = array('modulus' => $modulus, 'publicExponent' => $exponent);

		$rsa = new Crypt_RSA();
		$rsa->loadkey($key, CRYPT_RSA_PUBLIC_FORMAT_RAW);
		$rsa->setEncryptionMode(CRYPT_RSA_ENCRYPTION_PKCS1);

		$packed = "";
		foreach ($UUID_BA as $value)
		{
			$packed .= chr($value);
		}
		$res = $rsa->encrypt($packed);

		return base64_encode ($res);
	}

	// CONVERT GUID STRING TO BYTE ARRAY
	function guid_to_bytes($guid)
	{
		$guid_byte_order = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15];
		$guid = preg_replace("/[^a-zA-Z0-9]+/", "", $guid);
		$result = [];
		for($i=0;$i<16;$i++)
		$result[] = hexdec(substr($guid, 2 * $guid_byte_order[$i], 2));
		return $result;
	}

	// CONVERT BYTE ARRAY TO GUID STRING
	function bytes_to_guid($bytes) 
	{
		$guid_byte_order = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15];
		$result = "";
		for($i=0;$i<16;$i++)
		$result = sprintf($result."%02x", $bytes[$guid_byte_order[$i]]);
		return $result;
	}

	// RETURN TEXT SECTION
	function get_string_between($string, $start, $end)
	{
		$string = ' ' . $string;
		$ini = strpos($string, $start);
		if ($ini == 0) $result = '';
		$ini += strlen($start);
		$len = strpos($string, $end, $ini) - $ini;
		return substr($string, $ini, $len);
	}

?>