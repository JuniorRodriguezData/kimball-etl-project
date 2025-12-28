 use demo_kimball
 Select * from[dbo].[Dim_Cliente]			   
 select * from [dbo].[Fact_Ventas]
 -----------------------------------\USE demo_kimball;
GO

-- 1. Total de ingresos por mes
SELECT 									 
    MONTH(fecha) as Mes, 
    SUM(cantidad * precio_unitario) as IngresosTotales
FROM Fact_Ventas
GROUP BY MONTH(fecha)
ORDER BY Mes;

-- 2. Top 5 clientes que más han gastado
SELECT TOP 5 
    c.nombre, 
    SUM(v.cantidad * v.precio_unitario) as TotalGasto
FROM Fact_Ventas v
JOIN Dim_Cliente c ON v.id_cliente = c.id_cliente
GROUP BY c.nombre
ORDER BY TotalGasto DESC;

-- 3. Resumen general del Data Warehouse
SELECT 
    (SELECT COUNT(*) FROM Dim_Cliente) as Total_Clientes,
    (SELECT COUNT(*) FROM Fact_Ventas) as Total_Ventas,
    SUM(cantidad * precio_unitario) as Gran_Total_Vendido
FROM Fact_Ventas;