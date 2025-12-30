WITH CustomerOrders AS(
	SELECT
		c.CustomerKey,
		MIN(f.OrderDate) AS FirstOrderDate,
		COUNT(DISTINCT f.SalesOrderNumber) AS OrderCount,
		SUM(f.SalesAmount) AS TotalSales
	FROM [AdventureWorksDW2025].[dbo].[DimCustomer] c
	LEFT JOIN [AdventureWorksDW2025].[dbo].[FactInternetSales] f
		ON c.CustomerKey = f.CustomerKey
	GROUP BY c.CustomerKey
),

ThresholdCalc AS (
    SELECT 
    PERCENTILE_CONT(0.75) 
        WITHIN GROUP (ORDER BY TotalSales)
        OVER () AS SalesP75
	FROM CustomerOrders

),

SalesThreshold AS(
	SELECT DISTINCT SalesP75 FROM ThresholdCalc
),

FinalFunnel AS(
	SELECT
		co.*,
		CASE
			WHEN co.OrderCount = 1 
				THEN 'Stage 1 - First Purchase'
            WHEN co.OrderCount = 2 
                THEN 'Stage 2 - Repeat Purchase'
            WHEN co.OrderCount BETWEEN 3 AND 4
                THEN 'Stage 3 - High Value Customer'
            WHEN co.OrderCount > 4
                THEN 'Stage 4 - Loyal Customer'
        END AS FunnelStage
	FROM CustomerOrders co
	CROSS JOIN SalesThreshold st
)

--SELECT
--    FunnelStage,
--    COUNT(DISTINCT CustomerKey) AS CustomerCount
--FROM FinalFunnel
--GROUP BY FunnelStage
--ORDER BY CustomerCount DESC;

SELECT * FROM FinalFunnel