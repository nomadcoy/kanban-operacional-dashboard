import streamlit as st
from datetime import datetime


def draw_header(df):

    projeto = df.iloc[0]["Projeto"]
    tipo = df.iloc[0]["Tipo_Kanban"]
    percentual = float(df.iloc[0]["Percentual_Conclusao"])

    ultima = df["ULTIMA_ATUALIZACAO"].max()
    if hasattr(ultima, "to_pydatetime"):
        ultima = ultima.to_pydatetime()

    agora = datetime.now()

    # ================= HEADER PRINCIPAL =================
    col1, col2, col3 = st.columns([1.7, 7, 1.7])

    with col1:
        st.image("assets/logo.png", width=150)

    # ---------- TÍTULO CENTRAL ----------
    with col2:
        st.markdown(
            f"""
            <div style="text-align:center; line-height:;">
                <div style="font-size:32px; font-weight:800;">
                    KANBAN OPERACIONAL
                </div>
                <div style="font-size:18px; font-weight:600; color:#153A73; margin-top:2px;">
                    {tipo}
                </div>
                <div style="font-size:22px; font-weight:700; margin-top:2px;">
                    {projeto}
                </div>
            </div>
            """,
            unsafe_allow_html=True
        )

    # ---------- DATA / HORA ----------
    with col3:
        st.image("assets/logo2.png", width=100)
    st.divider()

    # ================= PROGRESS (DENTRO DO HEADER VISUALMENTE) =================
    col_a, col_b, col_c = st.columns([1.2, 6, 1.8])

    with col_a:
        st.empty()

    with col_b:
        st.markdown(f"""
        <div style="background:#e0e0e0; border-radius:10px; height:18px; overflow:hidden;">
            <div style="
                width:{percentual}%;
                background:#2E7D32;
                height:18px;
                border-radius:10px;
                transition: width 0.5s ease;
            ">
            </div>
        </div>
        """, unsafe_allow_html=True)

    with col_c:
        st.markdown(
            f"""
            <div style="text-align:right; line-height:1.1;">
                <div style="font-size:19px; font-weight:700;height: 18px;border-radius: 10px; display: flex; align-items: center; justify-content: center;">
                    {percentual:.0f}% concluído
                </div>
            </div>
            """,
            unsafe_allow_html=True
        )

    st.markdown("<div style='height:45px;'></div>", unsafe_allow_html=True)