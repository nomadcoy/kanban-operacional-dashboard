import streamlit as st
from utils.charts import pie_status


def draw_status(df):

    st.plotly_chart(
        pie_status(df),
        use_container_width=True,
        config={"displayModeBar": False}
    )