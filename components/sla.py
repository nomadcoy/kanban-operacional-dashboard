import streamlit as st
from utils.charts import pie_sla

def draw_sla(df):
    st.plotly_chart(pie_sla(df), use_container_width=True)