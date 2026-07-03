import streamlit as st


"""def draw_alerta(df):

    st.subheader("🚨 Alertas")

    atraso = int(df["Flag_Em_Atraso"].sum())

    sla = int(df["Flag_SLA"].sum())

    maior = int(df["Dias_Atraso"].fillna(0).max())

    st.error(f"Tarefas atrasadas: {atraso}")

    st.warning(f"SLA vencido: {sla}")

    st.info(f"Maior atraso: {maior} dias")"""

import streamlit as st


def draw_alerta(df):

    status = df["Status"].value_counts()

    total = len(df)
    atrasadas = status.get("Em Atraso", 0)
    percentual = (atrasadas / total) * 100 

    if percentual <= 10:
        cor = "#2E7D32"
        situacao = "CONTROLADO"

    elif percentual <= 20:
        cor = "#F9A825"
        situacao = "ATENÇÃO"

    elif percentual <= 35:
        cor = "#EF6C00"
        situacao = "ALERTA"

    else:
        cor = "#C62828"
        situacao = "CRÍTICO"

    st.markdown(
        f"""
<div style="
background:white;
border-left:8px solid {cor};
border-radius:12px;
padding:22px;
box-shadow:0 2px 10px rgba(0,0,0,.08);
height:300px;
display:flex;
flex-direction:column;
justify-content:center;
">

<div style="font-size:26px;font-weight:700;color:{cor};text-align:center;">
⚠️ ALERTA
</div>

<div style="font-size:30px;font-weight:800;color:#163A70;text-align:center;margin-top:10px;">
{atrasadas}
</div>

<div style="font-size:15px;text-align:center;color:#555;">
tarefas em atraso
</div>

<hr>

<div style="font-size:15px;text-align:center;">
<b>{total}</b> tarefas no total
</div>

<div style="font-size:26px;font-weight:800;color:{cor};text-align:center;margin-top:12px;">
{percentual:.1f}%
</div>

<div style="font-size:15px;font-weight:700;color:{cor};text-align:center;">
{situacao}
</div>

</div>
""",
        unsafe_allow_html=True,
    )