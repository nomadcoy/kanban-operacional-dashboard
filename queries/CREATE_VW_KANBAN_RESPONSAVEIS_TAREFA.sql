CREATE OR ALTER VIEW Bronze.VW_KANBAN_TAREFA_RESPONSAVEIS
AS

SELECT

    id_tarefa,
    id_kanban,
    codproj,

    COUNT(DISTINCT id_usuario) AS Qtde_Responsaveis,

    STRING_AGG(Responsavel, ', ') AS Responsaveis,

    STRING_AGG(Email, ', ') AS Emails,

    MAX(Flag_Multiplos_Responsaveis) AS Flag_Multiplos_Responsaveis

FROM Bronze.VW_KANBAN_RESPONSAVEIS

GROUP BY
    id_tarefa,
    id_kanban,
    codproj;