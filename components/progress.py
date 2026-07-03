import streamlit as st


def draw_progress(df):

    percentual = float(df.iloc[0]["Percentual_Conclusao"])

    st.markdown("### Progresso do Projeto")

    st.progress(percentual/100)

    st.markdown(
        f"<h2 style='text-align:center;color:#2E7D32'>{percentual:.1f}%</h2>",
        unsafe_allow_html=True
    )