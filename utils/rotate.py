from datetime import datetime
from db import run_query   # ajuste para o seu projeto
from config import QUERY_PROJETOS

def projeto_atual():
    projetos = run_query(QUERY_PROJETOS)["CODPROJ"].tolist()

    if not projetos:
        return None

    indice = int(datetime.now().timestamp() // 60) % len(projetos)

    return projetos[indice]