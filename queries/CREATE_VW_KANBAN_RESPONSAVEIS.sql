CREATE OR ALTER VIEW Bronze.VW_KANBAN_RESPONSAVEIS
AS

WITH base AS (
    SELECT
        r.id_tarefa,
        r.id_kanban,
        r.codproj,
        r.id_usuario,
        u.Nome AS Responsavel,
        u.Email,
        u.Tipo AS Tipo_Usuario
    FROM Bronze.Kanban_responsaveis r
    LEFT JOIN Bronze.Kanban_Acessos u
        ON u.Id = r.id_usuario
),

agregado AS (
    SELECT
        id_tarefa,
        id_kanban,
        codproj,

        COUNT(DISTINCT id_usuario) AS Qtde_Responsaveis,

        STRING_AGG(Responsavel, ', ') AS Responsaveis,
        STRING_AGG(Email, ', ') AS Emails

    FROM base
    GROUP BY
        id_tarefa,
        id_kanban,
        codproj
)

SELECT
    a.id_tarefa,
    a.id_kanban,
    a.codproj,
    a.Qtde_Responsaveis,
    a.Responsaveis,
    a.Emails,

    CASE
        WHEN a.Qtde_Responsaveis > 1 THEN 1
        ELSE 0
    END AS Flag_Multiplos_Responsaveis

FROM agregado a;