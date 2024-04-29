select * from [PRODUCTION DATA]

-- total manufactured QTY
SELECT SUM(Manufactured_Qty) AS Total_Manufacturing_Quantity
FROM [PRODUCTION DATA];

-- Percentage of Manufactured QTY over total WO Qty
SELECT 
    (CONVERT(decimal, SUM([Manufactured_Qty])) / NULLIF(CONVERT(decimal, SUM(WO_Qty)), 0)) * 100 AS ManufacturingPercentage
FROM 
    [PRODUCTION DATA];



-- total Rejected QTY
   SELECT SUM(Rejected_Qty) AS Total_Rejected_Quantity
FROM  [PRODUCTION DATA];

-- Percentage of rejected QTY over total Produced QTY
SELECT 
    (CONVERT(decimal, SUM(Rejected_Qty)) / NULLIF(CONVERT(decimal, SUM(Produced_Qty)), 0)) * 100 AS RejectedPercentage
FROM 
    [PRODUCTION DATA];



	-- total Produced QTY
	SELECT SUM(Produced_Qty) AS TotalProducedQuantity
FROM [PRODUCTION DATA];


-- Wastage Percentage
SELECT 
    (CONVERT(decimal, SUM([Rejected_Qty])) / NULLIF(CONVERT(decimal, SUM([Produced_Qty])), 0)) * 100 AS WastagePercentage
FROM 
    [PRODUCTION DATA];

	
	-- total WO QTY
	SELECT SUM(WO_Qty) AS TotalWOQuantity
FROM [PRODUCTION DATA];

-- Employee wise rejected QTY
SELECT Emp_Name, SUM(Rejected_Qty) AS TotalRejectedQuantity
FROM [PRODUCTION DATA]
GROUP BY Emp_Name;


-- Machine wise Rejected Qty
SELECT Machine_Code, SUM(Rejected_Qty) AS TotalRejectedQuantity
FROM [PRODUCTION DATA]
GROUP BY Machine_Code;


-- department wise manufactured vs rejected quantity
SELECT 
    Department_Name, 
    SUM(Produced_Qty) AS TotalProducedQuantity,
    SUM(Rejected_Qty) AS TotalRejectedQuantity
FROM 
   [PRODUCTION DATA]
GROUP BY 
     Department_Name;


	 
-- month wise Production trend
SELECT 
    FORMAT([Doc_Date], 'yyyy-MM') AS Month,
    SUM([Produced_Qty]) AS TotalProducedQuantity
FROM 
    [PRODUCTION DATA]
GROUP BY 
    FORMAT([Doc_Date], 'yyyy-MM')
ORDER BY 
    FORMAT([Doc_Date], 'yyyy-MM');



	-- operation wise manufactured vs rejected qty
	SELECT 
    Operation_Name, 
    SUM(Produced_Qty) AS TotalProducedQuantity,
    SUM(Rejected_Qty) AS TotalRejectedQuantity
FROM 
    [PRODUCTION DATA]
GROUP BY 
    Operation_Name;



	-- WO QTy wise Delivery Period
	SELECT 
    CAST(SUM(CASE WHEN [Delivery_Period] = 'Early' THEN 1 ELSE 0 END) AS decimal) / COUNT(*) * 100 AS EarlyPercentage,
    CAST(SUM(CASE WHEN [Delivery_Period] = 'Late' THEN 1 ELSE 0 END) AS decimal) / COUNT(*) * 100 AS LatePercentage,
    CAST(SUM(CASE WHEN [Delivery_Period] = 'On Time' THEN 1 ELSE 0 END) AS decimal) / COUNT(*) * 100 AS OnTimePercentage,
    CAST(SUM(CASE WHEN [Delivery_Period] = 'Under Production' THEN 1 ELSE 0 END) AS decimal) / COUNT(*) * 100 AS UnderProductionPercentage
FROM 
    [PRODUCTION DATA];

