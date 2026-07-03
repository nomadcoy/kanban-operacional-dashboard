SELECT TOP 20 *
FROM Bronze.tcsprj;

SELECT TOP 20 *
FROM Bronze.Kanban_CRONOPROJ;

SELECT *
FROM Bronze.Kanban_Tarefas;

SELECT *
FROM Bronze.Kanban_Raias;

SELECT *
FROM Bronze.Kanban_responsaveis;

SELECT *
FROM Bronze.Kanban_Acessos;

SELECT TOP 5 *
FROM Bronze.tfpdep;

-- VIEW BASE:

SELECT *
FROM Bronze.VW_KANBAN_BASE;

SELECT *
FROM Bronze.VW_FATO_TAREFAS
WHERE Projeto = '01.05.100 - UAT-PORTO ALEGRE RS-18-2025-UNID 1';                                     

-- VIEW RESUMO

SELECT *
FROM Bronze.VW_KANBAN_RESUMO;

--VIEW RESPONSAVEIS

SELECT *
FROM Bronze.VW_KANBAN_RESPONSAVEIS;

--VIEW TAREFA - RSPONSAVEIS
SELECT *
FROM Bronze.VW_KANBAN_TAREFA_RESPONSAVEIS

--VIEW dim_calendario
SELECT *
FROM Bronze.dim_calendario;

--VIEW FATO TAREFAS
SELECT *
FROM Bronze.VW_FATO_TAREFAS

SELECT
    Total_Tarefas,
    Tarefas_Concluidas,
    Tarefas_Execucao,
    Tarefas_Pendentes,
    Tarefas_A_Fazer,
    Tarefas_Atrasadas
FROM Bronze.VW_KANBAN_RESUMO
WHERE CODPROJ = 20416293;

SELECT
    COUNT(*) AS Total,
    SUM(Flag_Concluida) AS Concluidas,
    SUM(Flag_Execucao) AS Execucao,
    SUM(Flag_Pendente) AS Pendentes,
    SUM(Flag_A_Fazer) AS AFazer,
    SUM(Flag_Em_Atraso) AS Atrasadas
FROM Bronze.VW_KANBAN_BASE
WHERE CODPROJ = 20416293;

SELECT TOP 200
    cr.CODPROJ,
    prj.CODPROJ,
    prj.IDENTIFICACAO
FROM Bronze.Kanban_CRONOPROJ cr
LEFT JOIN Bronze.tcsprj prj
    ON cr.CODPROJ = prj.CODPROJ;

    SELECT
    DATA_PRAZO,
    COUNT(*) AS Quantidade
FROM Bronze.Kanban_CRONOPROJ
WHERE YEAR(DATA_PRAZO) < 2000
GROUP BY DATA_PRAZO
ORDER BY DATA_PRAZO;

SELECT
    ID,
    CODPROJ,
    ID_TAREFA,
    DATA_PRAZO
FROM Bronze.Kanban_CRONOPROJ
WHERE YEAR(DATA_PRAZO) < 2000;

-- backup dos registros afetados

SELECT *
INTO Bronze.Kanban_CRONOPROJ_Backup_Datas_20260630
FROM Bronze.Kanban_CRONOPROJ
WHERE YEAR(DATA_PRAZO) < 2000;

-- CORRE합ES ANO 26 -> 2026

UPDATE Bronze.Kanban_CRONOPROJ
SET DATA_PRAZO = DATEFROMPARTS(
        2026,
        MONTH(DATA_PRAZO),
        DAY(DATA_PRAZO)
)
WHERE YEAR(DATA_PRAZO) = 26;

-- CORRE합ES ANO 2025

UPDATE Bronze.Kanban_CRONOPROJ
SET DATA_PRAZO = DATEFROMPARTS(
        2025,
        MONTH(DATA_PRAZO),
        DAY(DATA_PRAZO)
)
WHERE YEAR(DATA_PRAZO) = 25;

-- CORRE합ES DE REGISTROS 202

UPDATE Bronze.Kanban_CRONOPROJ
SET DATA_PRAZO = DATEFROMPARTS(
    2026,
    MONTH(DATA_PRAZO),
    DAY(DATA_PRAZO)
)
WHERE YEAR(DATA_PRAZO) = 202;

-- VALIDA플O DA CORRE플O

SELECT
    ID,
    CODPROJ,
    DATA_PRAZO
FROM Bronze.Kanban_CRONOPROJ
WHERE YEAR(DATA_PRAZO) < 2000;


SELECT *
FROM Bronze.VW_KANBAN_BASE
WHERE CODPROJ IN (
    SELECT CODPROJ
    FROM Bronze.VW_KANBAN_BASE
    GROUP BY CODPROJ
    HAVING SUM(Flag_Concluida) < COUNT(*)
)

SELECT
    TABLE_SCHEMA,
    TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_SCHEMA, TABLE_NAME;

SELECT
    TABLE_NAME,
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
ORDER BY TABLE_NAME, ORDINAL_POSITION;

EXEC sp_help 'Bronze.Kanban_Projetos_Acessos';

SELECT
    fk.name AS ForeignKey,
    tp.name AS TabelaPai,
    cp.name AS ColunaPai,
    tr.name AS TabelaFilha,
    cr.name AS ColunaFilha
FROM sys.foreign_keys fk
JOIN sys.foreign_key_columns fkc
    ON fk.object_id = fkc.constraint_object_id
JOIN sys.tables tp
    ON fkc.referenced_object_id = tp.object_id
JOIN sys.columns cp
    ON cp.object_id = tp.object_id
   AND cp.column_id = fkc.referenced_column_id
JOIN sys.tables tr
    ON fkc.parent_object_id = tr.object_id
JOIN sys.columns cr
    ON cr.object_id = tr.object_id
   AND cr.column_id = fkc.parent_column_id;
