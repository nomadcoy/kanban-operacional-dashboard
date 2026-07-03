import streamlit as st

def draw_responsaveis(df):
    st.subheader("👥 Responsáveis")

    if "Responsaveis" in df.columns:
        top = df["Responsaveis"].value_counts().head(5)
        st.bar_chart(top)
    else:
        st.warning("Coluna Responsaveis não encontrada")