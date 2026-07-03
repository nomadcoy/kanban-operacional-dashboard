import streamlit as st
from datetime import datetime


def draw_footer(df):

    ultima = df["ULTIMA_ATUALIZACAO"].max()

    st.markdown("---")

    c1, c2 = st.columns(2)

    c1.caption(f"Atualizado em: {ultima}")

    c2.caption(
        datetime.now().strftime("%d/%m/%Y %H:%M")
    )