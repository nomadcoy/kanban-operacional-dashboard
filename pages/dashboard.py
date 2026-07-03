from db import run_query

from config import QUERY

import streamlit as st

from utils.rotate import projeto_atual
from config import QUERY

from components.header import draw_header

from components.cards import draw_cards

from components.status import draw_status

from components.alerta import draw_alerta

from components.setores import draw_setores

from components.footer import draw_footer

from streamlit_autorefresh import st_autorefresh

st_autorefresh(interval=60 * 1000, key="refresh")


def dashboard():

    codproj = projeto_atual()

    df = run_query(QUERY, params=[codproj])

    draw_header(df)

    draw_cards(df)

    st.divider()

    # 🔥 LINHA PRINCIPAL (PAINEL EXECUTIVO)
    col1, col2, col3 = st.columns([1.6, 0.7, 1.6])

    with col1:
        draw_status(df)

    with col2:
        draw_alerta(df)

    with col3:
        draw_setores(df)

    draw_footer(df)

    