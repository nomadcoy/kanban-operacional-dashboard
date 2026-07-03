import streamlit as st

def draw_updates(df):
    st.subheader("🕒 Atualizações recentes")

    if "ULTIMA_ATUALIZACAO" in df.columns:
        st.dataframe(df[["Projeto", "ULTIMA_ATUALIZACAO"]].head(10))
    else:
        st.warning("Sem dados de atualização")