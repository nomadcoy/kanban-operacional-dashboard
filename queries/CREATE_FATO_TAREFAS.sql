CREATE OR ALTER VIEW Bronze.VW_FATO_TAREFAS
AS

SELECT

    --========================================================
    -- IDENTIFICAÇÃO
    --========================================================

    B.ID,
    B.ID_KANBAN,
    B.Tipo_Kanban,

    B.CODPROJ,
    B.Projeto,

    B.ID_TAREFA,
    B.Nome_Tarefa,
    B.Ordem,

    --========================================================
    -- ORGANIZAÇÃO
    --========================================================

    B.CODDEP,
    B.Departamento,

    --========================================================
    -- DATAS
    --========================================================

    B.CRIACAO,
    B.DATA_PRAZO,
    B.DATA_CONCLUSAO,
    B.ULTIMA_ATUALIZACAO,

    --========================================================
    -- SITUAÇÃO
    --========================================================

    B.Status,
    B.Situacao_Real,

    B.Dias_Atraso,
    B.Dias_Para_Prazo,

    --========================================================
    -- FLAGS
    --========================================================

    B.Flag_Concluida,
    B.Flag_Execucao,
    B.Flag_Pendente,
    B.Flag_A_Fazer,
    B.Flag_Em_Atraso,
    B.Flag_SLA,

    --========================================================
    -- RESPONSÁVEIS
    --========================================================

    ISNULL(R.Qtde_Responsaveis,0)             AS Qtde_Responsaveis,
    R.Responsaveis,
    R.Emails,
    ISNULL(R.Flag_Multiplos_Responsaveis,0)   AS Flag_Multiplos_Responsaveis,

    --========================================================
    -- RESUMO DO PROJETO
    --========================================================

    K.Total_Tarefas,
    K.Tarefas_Concluidas,
    K.Tarefas_Execucao,
    K.Tarefas_Pendentes,
    K.Tarefas_A_Fazer,
    K.Tarefas_Atrasadas,

    K.Percentual_Conclusao,

    K.Situacao_Projeto,

    K.Exibir_Dashboard,

    --========================================================
    -- COLUNAS CALCULADAS
    --========================================================

    DATEDIFF(DAY,B.CRIACAO,GETDATE()) AS Dias_Em_Execucao,

    CASE

        WHEN B.Flag_Concluida = 1 THEN 'Concluída'

        WHEN B.Dias_Atraso > 0
            THEN CONCAT(B.Dias_Atraso,' dia(s) em atraso')

        WHEN B.Dias_Para_Prazo >= 0
            THEN CONCAT(B.Dias_Para_Prazo,' dia(s) restantes')

        ELSE 'Sem prazo'

    END AS Situacao_Prazo,

    CASE

        WHEN B.Flag_Em_Atraso=1 THEN 'ATRASADO'
        WHEN B.Flag_Execucao=1 THEN 'EXECUCAO'
        WHEN B.Flag_Pendente=1 THEN 'PENDENTE'
        WHEN B.Flag_A_Fazer=1 THEN 'A_FAZER'
        WHEN B.Flag_Concluida=1 THEN 'CONCLUIDO'

        ELSE 'OUTROS'

    END AS Cor_Status,

    CASE

        WHEN B.Flag_Em_Atraso=1 THEN 1
        WHEN B.Flag_Execucao=1 THEN 2
        WHEN B.Flag_Pendente=1 THEN 3
        WHEN B.Flag_A_Fazer=1 THEN 4
        WHEN B.Flag_Concluida=1 THEN 5

        ELSE 99

    END AS Ordem_Exibicao,

    CASE
        WHEN B.DATA_PRAZO < GETDATE()
             AND B.Flag_Concluida = 0
        THEN 1
        ELSE 0
    END AS Flag_Vencida,

    CASE
        WHEN B.Dias_Para_Prazo BETWEEN 0 AND 7
             AND B.Flag_Concluida = 0
        THEN 1
        ELSE 0
    END AS Flag_Vence_Esta_Semana,

    CASE

        WHEN B.Flag_Em_Atraso = 1 THEN 'Crítica'

        WHEN B.Dias_Para_Prazo BETWEEN 0 AND 7
             AND B.Flag_Concluida = 0 THEN 'Vence em breve'
        WHEN B.Flag_Execucao = 1 THEN 'Em execução'

        WHEN B.Flag_Pendente = 1 THEN 'Pendente'

        WHEN B.Flag_A_Fazer = 1 THEN 'A Fazer'

        ELSE 'Concluída'

    END AS Prioridade

FROM Bronze.VW_KANBAN_BASE B

LEFT JOIN Bronze.VW_KANBAN_RESPONSAVEIS R

       ON B.ID_TAREFA = R.ID_TAREFA
      AND B.CODPROJ   = R.CODPROJ
      AND B.ID_KANBAN = R.ID_KANBAN

LEFT JOIN Bronze.VW_KANBAN_RESUMO K

       ON B.CODPROJ   = K.CODPROJ
      AND B.ID_KANBAN = K.ID_KANBAN;