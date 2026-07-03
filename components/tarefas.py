import streamlit as st


def draw_tarefas(df):

    st.subheader("📋 Tarefas")

    tarefas = df[
        df["Flag_Concluida"] == 0
    ].copy()

    tarefas = tarefas.sort_values("Ordem")

    st.dataframe(

        tarefas[
            [

                "Cor_Status",

                "Ordem",

                "Nome_Tarefa",

                "Responsaveis",

                "Departamento",

                "DATA_PRAZO",

                "Dias_Atraso"

            ]
        ],

        use_container_width=True,

        hide_index=True

    )