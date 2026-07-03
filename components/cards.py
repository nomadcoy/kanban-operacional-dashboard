import streamlit as st


def draw_cards(df):

    status = df["Status"].value_counts()

    total = len(df)

    concluidas = status.get("Concluído", 0)
    execucao = status.get("Em execução", 0)
    pendentes = status.get("Pendente", 0)
    afazer = status.get("A Fazer", 0)
    atrasadas = status.get("Em Atraso", 0)

    c1, c2, c3, c4, c5, c6 = st.columns(6)

    c1.metric("Total", total)

    c2.metric("Concluídas", concluidas)

    c3.metric("Execução", execucao)

    c4.metric("Pendentes", pendentes)

    c5.metric("A Fazer", afazer)

    c6.metric("Atrasadas", atrasadas)