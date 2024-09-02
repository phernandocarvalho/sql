DELIMITER //

CREATE PROCEDURE GenerateDailySalesReport()
BEGIN
    DECLARE currentDate DATE;
    SET currentDate = CURDATE();
    
    SELECT 
        DATE(purchase_date) AS Date,
        product_id,
        COUNT(*) AS QuantitySold
    FROM 
        sales
    WHERE 
        DATE(purchase_date) = currentDate
    GROUP BY 
        product_id
    ORDER BY 
        product_id;
END //

DELIMITER ;
