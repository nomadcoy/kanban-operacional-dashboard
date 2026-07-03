SELECT
    cr.ID,
    cr.ID_KANBAN,
    CASE
        WHEN cr.ID_KANBAN = 1 THEN 'Implantação'
        WHEN cr.ID_KANBAN = 2 THEN 'Desmobilização'
    END AS Tipo_Kanban,

    cr.CODPROJ,

    cr.ID_TAREFA,

    cr.CODDEP,

    cr.ID_RAIA,

    cr.CRIACAO,

    cr.DATA_PRAZO,

    cr.DATA_CONCLUSAO,

    cr.ULTIMA_ATUALIZACAO,

    cr.COMENTARIO

FROM Bronze.Kanban_CRONOPROJ cr;