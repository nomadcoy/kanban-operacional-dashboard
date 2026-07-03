CREATE OR ALTER VIEW Bronze.VW_KANBAN_BASE
AS

SELECT

    ------------------------------------------------------------------
    -- Identificação
    ------------------------------------------------------------------

    cr.ID,
    cr.ID_KANBAN,

    CASE
        WHEN cr.ID_KANBAN = 1 THEN 'Implantação'
        WHEN cr.ID_KANBAN = 2 THEN 'Desmobilização'
    END AS Tipo_Kanban,

    cr.CODPROJ,

    dp.Projeto,

    ------------------------------------------------------------------
    -- Tarefa
    ------------------------------------------------------------------

    cr.ID_TAREFA,

    kt.Nome_Tarefa,

    kt.Ordem,

    ------------------------------------------------------------------
    -- Departamento
    ------------------------------------------------------------------

    cr.CODDEP,

    dep.DESCRDEP AS Departamento,

    ------------------------------------------------------------------
    -- Status
    ------------------------------------------------------------------

    cr.ID_RAIA,

    kr.nome_raia AS Status,

    ------------------------------------------------------------------
    -- Datas
    ------------------------------------------------------------------

    cr.CRIACAO,

    cr.DATA_PRAZO,

    cr.DATA_CONCLUSAO,

    cr.ULTIMA_ATUALIZACAO,

    ------------------------------------------------------------------
    -- Comentário
    ------------------------------------------------------------------

    cr.COMENTARIO,

    ------------------------------------------------------------------
    -- Indicadores
    ------------------------------------------------------------------

    CASE

        WHEN cr.DATA_CONCLUSAO IS NOT NULL THEN

            CASE

                WHEN cr.DATA_CONCLUSAO > cr.DATA_PRAZO

                THEN DATEDIFF(DAY,cr.DATA_PRAZO,cr.DATA_CONCLUSAO)

                ELSE 0

            END

        ELSE

            CASE

                WHEN CAST(GETDATE() AS DATE) > cr.DATA_PRAZO

                THEN DATEDIFF(DAY,cr.DATA_PRAZO,CAST(GETDATE() AS DATE))

                ELSE 0

            END

    END AS Dias_Atraso,

    CASE

        WHEN cr.DATA_CONCLUSAO IS NULL

        THEN DATEDIFF(DAY,CAST(GETDATE() AS DATE),cr.DATA_PRAZO)

        ELSE NULL

    END AS Dias_Para_Prazo,

    ------------------------------------------------------------------
    -- Flags
    ------------------------------------------------------------------

    CASE

        WHEN cr.ID_RAIA IN (5,10)

        THEN 1

        ELSE 0

    END AS Flag_Concluida,

    CASE

        WHEN cr.ID_RAIA IN (2,7)

        THEN 1

        ELSE 0

    END AS Flag_Execucao,

    CASE

        WHEN cr.ID_RAIA IN (3,8)

        THEN 1

        ELSE 0

    END AS Flag_Pendente,

    CASE

        WHEN cr.ID_RAIA IN (1,6)

        THEN 1

        ELSE 0

    END AS Flag_A_Fazer,

    CASE

        WHEN cr.DATA_CONCLUSAO IS NULL

             AND CAST(GETDATE() AS DATE) > cr.DATA_PRAZO

        THEN 1

        ELSE 0

    END AS Flag_Em_Atraso,

    CASE

        WHEN cr.DATA_CONCLUSAO IS NOT NULL

             AND cr.DATA_CONCLUSAO <= cr.DATA_PRAZO

        THEN 1

        ELSE 0

    END AS Flag_SLA,

    ------------------------------------------------------------------
    -- Situação consolidada
    ------------------------------------------------------------------

    CASE

        WHEN cr.ID_RAIA IN (5,10)

            THEN 'Concluído'

        WHEN cr.DATA_CONCLUSAO IS NULL
             AND CAST(GETDATE() AS DATE) > cr.DATA_PRAZO

            THEN 'Em atraso'

        WHEN cr.ID_RAIA IN (2,7)

            THEN 'Em execução'

        WHEN cr.ID_RAIA IN (3,8)

            THEN 'Pendente'

        ELSE 'A Fazer'

    END AS Situacao_Real

FROM Bronze.Kanban_CRONOPROJ cr

LEFT JOIN Bronze.Kanban_Tarefas kt

       ON kt.ID = cr.ID_TAREFA

LEFT JOIN Bronze.Kanban_Raias kr

       ON kr.ID = cr.ID_RAIA

LEFT JOIN Bronze.tfpdep dep

       ON dep.CODDEP = cr.CODDEP

LEFT JOIN (

        SELECT

            CASE

                WHEN u.CODPROJ IS NOT NULL

                THEN CONCAT(u.CODPROJ,u.SEQUENCIA)

                ELSE prj.CODPROJ

            END AS CODPROJ,

            CASE

                WHEN u.CODPROJ IS NOT NULL

                THEN UPPER(u.UNIDADE)

                ELSE prj.IDENTIFICACAO

            END AS Projeto

        FROM Bronze.tcsprj prj

        LEFT JOIN Bronze.AD_UNIDADE u

               ON u.CODPROJ = prj.CODPROJ

        WHERE

            (prj.GRAU IS NULL OR prj.GRAU = 3)

            AND prj.CODPROJ <> '0'

) dp

ON dp.CODPROJ = cr.CODPROJ;
