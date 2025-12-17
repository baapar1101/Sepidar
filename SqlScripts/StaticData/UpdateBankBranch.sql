Update R
Set BranchTitle = Rpa.BankBranch.Title
From Rpa.ReceiptCheque R inner join
   Rpa.BankBranch on R.BankBranchRef = Rpa.BankBranch.BankBranchId




