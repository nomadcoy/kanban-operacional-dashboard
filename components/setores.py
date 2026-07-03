import streamlit as st
from utils.charts import bar_setores_atraso


def draw_setores(df):

    st.plotly_chart(
        bar_setores_atraso(df),
        use_container_width=True,
        config={"displayModeBar": False}
    )