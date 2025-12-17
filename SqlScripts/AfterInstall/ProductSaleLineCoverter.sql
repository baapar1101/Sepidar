-- ItemStateEnum -- 
-- { 
--     1 = ContainsAll 
--     2 = ContainsSome, 
--     3 = None, 
-- }  

IF EXISTS (
    SELECT 1 
    FROM DST.ProductSaleLine 
    WHERE ProductsState IS NULL OR ServicesState IS NULL
)
BEGIN
    -------------------------- No Products, No Services -------------------------
    UPDATE DST.ProductSaleLine
    SET ProductsState = 1, ServicesState = 1
    WHERE NOT EXISTS (
        SELECT 1  
        FROM DST.ProductSaleLineItem  
        WHERE ProductSaleLineRef = ProductSaleLineId
    );

    -------------------------- Contains Products, Contains Services -------------------------
    UPDATE DST.ProductSaleLine
    SET ProductsState = 2, ServicesState = 2
    WHERE EXISTS (
        SELECT 1  
        FROM DST.ProductSaleLineItem PSLI  
        JOIN INV.Item I ON I.ItemID = PSLI.ItemRef  
        WHERE PSLI.ProductSaleLineRef = ProductSaleLineId 
          AND I.[Type] = 2  
    )
    AND EXISTS (
        SELECT 1  
        FROM DST.ProductSaleLineItem PSLI  
        JOIN INV.Item I ON I.ItemID = PSLI.ItemRef  
        WHERE PSLI.ProductSaleLineRef = ProductSaleLineId 
          AND I.[Type] = 1  
    );

    -------------------------- Contains Products, No Services -------------------------
    UPDATE DST.ProductSaleLine
    SET ProductsState = 2, ServicesState = 1
    WHERE EXISTS (
        SELECT 1  
        FROM DST.ProductSaleLineItem PSLI  
        JOIN INV.Item I ON I.ItemID = PSLI.ItemRef  
        WHERE PSLI.ProductSaleLineRef = ProductSaleLineId 
          AND I.[Type] = 1  
    )
    AND NOT EXISTS (
        SELECT 1  
        FROM DST.ProductSaleLineItem PSLI  
        JOIN INV.Item I ON I.ItemID = PSLI.ItemRef  
        WHERE PSLI.ProductSaleLineRef = ProductSaleLineId 
          AND I.[Type] = 2  
    );

    -------------------------- No Products, Contains Services -------------------------
    UPDATE DST.ProductSaleLine
    SET ProductsState = 3, ServicesState = 2
    WHERE NOT EXISTS (
        SELECT 1  
        FROM DST.ProductSaleLineItem PSLI  
        JOIN INV.Item I ON I.ItemID = PSLI.ItemRef  
        WHERE PSLI.ProductSaleLineRef = ProductSaleLineId 
          AND I.[Type] = 1  
    )
    AND EXISTS (
        SELECT 1  
        FROM DST.ProductSaleLineItem PSLI  
        JOIN INV.Item I ON I.ItemID = PSLI.ItemRef  
        WHERE PSLI.ProductSaleLineRef = ProductSaleLineId 
          AND I.[Type] = 2  
    );
END;
