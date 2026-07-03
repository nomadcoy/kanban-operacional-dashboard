PAGE_TITLE = "Kanban Operacional"

REFRESH_SECONDS = 10

PAGE_ICON = "📺"

LAYOUT = "wide"

INITIAL_SIDEBAR_STATE = "collapsed"

THEME_COLOR = "#0f172a"

LOGO = "assets/logo.png"

QUERY = """
SELECT *
FROM Bronze.VW_FATO_TAREFAS
WHERE Exibir_Dashboard = 1
  AND CODPROJ = ?
ORDER BY Tipo_Kanban, CODPROJ, Ordem
"""

QUERY = """
SELECT *
FROM Bronze.VW_FATO_TAREFAS
WHERE Exibir_Dashboard = 1
  AND CODPROJ = ?
ORDER BY Tipo_Kanban, CODPROJ, Ordem
"""

QUERY_PROJETOS = """
SELECT DISTINCT CODPROJ
FROM Bronze.VW_FATO_TAREFAS
WHERE Exibir_Dashboard = 1
ORDER BY CODPROJ
"""