-- DIM CALENDÁRIO

IF OBJECT_ID('Bronze.dim_calendario', 'U') IS NOT NULL
    DROP TABLE Bronze.dim_calendario;
GO

WITH datas AS (
    SELECT CAST('2020-01-01' AS DATE) AS Data
    UNION ALL
    SELECT DATEADD(DAY, 1, Data)
    FROM datas
    WHERE Data < '2035-12-31'
)
SELECT
    Data,
    YEAR(Data) AS Ano,
    MONTH(Data) AS Mes,
    DATENAME(MONTH, Data) AS Nome_Mes,
    DAY(Data) AS Dia,
    DATEPART(WEEKDAY, Data) AS Dia_Semana,
    DATENAME(WEEKDAY, Data) AS Nome_Dia_Semana,
    CASE WHEN DATEPART(WEEKDAY, Data) IN (1,7) THEN 0 ELSE 1 END AS Dia_Util,
    DATEFROMPARTS(YEAR(Data), MONTH(Data), 1) AS Inicio_Mes,
    EOMONTH(Data) AS Fim_Mes
INTO Bronze.dim_calendario
FROM datas
OPTION (MAXRECURSION 0);