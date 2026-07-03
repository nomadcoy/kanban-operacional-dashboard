CREATE OR ALTER VIEW Bronze.VW_KANBAN_RESUMO
AS

SELECT

    b.ID_KANBAN,

    b.Tipo_Kanban,

    b.CODPROJ,

    b.Projeto,

    ---------------------------------------
    -- Quantidades
    ---------------------------------------

    COUNT(*) AS Total_Tarefas,

    SUM(b.Flag_Concluida) AS Tarefas_Concluidas,

    SUM(b.Flag_Execucao) AS Tarefas_Execucao,

    SUM(b.Flag_Pendente) AS Tarefas_Pendentes,

    SUM(b.Flag_A_Fazer) AS Tarefas_A_Fazer,

    SUM(b.Flag_Em_Atraso) AS Tarefas_Atrasadas,

    ---------------------------------------
    -- Percentual de conclusão
    ---------------------------------------

    CAST(
        100.0 * SUM(b.Flag_Concluida)
        / NULLIF(COUNT(*),0)
        AS DECIMAL(5,2)
    ) AS Percentual_Conclusao,

    ---------------------------------------
    -- SLA
    ---------------------------------------

    SUM(b.Flag_SLA) AS Tarefas_Fora_SLA,

    ---------------------------------------
    -- Dias
    ---------------------------------------

    MAX(b.Dias_Atraso) AS Maior_Atraso,

    AVG(
        CASE
            WHEN b.Dias_Atraso IS NOT NULL
            THEN b.Dias_Atraso
        END
    ) AS Media_Atraso,

    ---------------------------------------
    -- Datas
    ---------------------------------------

    MIN(b.CRIACAO) AS Data_Inicio,

    MAX(b.DATA_PRAZO) AS Data_Final_Prevista,

    MAX(b.ULTIMA_ATUALIZACAO) AS Ultima_Atualizacao,

    ---------------------------------------
    -- Situação Geral
    ---------------------------------------

    CASE

        WHEN SUM(b.Flag_Concluida) = COUNT(*)
            THEN 'Concluído'

        WHEN SUM(b.Flag_Execucao) > 0
            THEN 'Em Execução'

        WHEN SUM(b.Flag_Em_Atraso) > 0
            THEN 'Em Atraso'

        WHEN SUM(b.Flag_Pendente) > 0
            THEN 'Pendente'

        ELSE 'A Fazer'

    END AS Situacao_Projeto,

    ---------------------------------------
    -- Exibir no Dashboard
    ---------------------------------------

    CASE

        WHEN SUM(b.Flag_Concluida)=COUNT(*)
            THEN 0

        ELSE 1

    END AS Exibir_Dashboard

FROM Bronze.VW_KANBAN_BASE b

GROUP BY

    b.ID_KANBAN,
    b.Tipo_Kanban,
    b.CODPROJ,
    b.Projeto;