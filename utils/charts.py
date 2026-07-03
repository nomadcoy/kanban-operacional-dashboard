import plotly.graph_objects as go


def pie_status(df):

    status = df["Status"].value_counts()

    labels = [
        "Concluídas",
        "Em Execução",
        "Pendente",
        "A Fazer",
        "Em Atraso"

    ]

    values = [
        status.get("Concluído", 0),
        status.get("Em execução", 0),
        status.get("Pendente", 0),
        status.get("A Fazer", 0),
        status.get("Em Atraso", 0)
    ]

    colors = [
        "#2E7D32",
        "#1976D2",
        "#F9A825",
        "#8E24AA",
        "#D32F2F"   
    ]

    fig = go.Figure(
        go.Pie(
            labels=labels,
            values=values,
            hole=0.60,
            sort=False,
            marker=dict(
                colors=colors,
                line=dict(color="white", width=2)
            ),
            textinfo="percent+label"
        )
    )

    fig.update_layout(
        title="Status das Tarefas",
        height=300,
        margin=dict(l=10, r=10, t=30, b=20),
    )

    return fig

import plotly.express as px

"""def bar_setores_atraso(df):

    projeto = df.iloc[0]["Projeto"]
    df_proj = df[df["Projeto"] == projeto]

    # só atrasadas (fonte confiável)
    df_atraso = df_proj[df_proj["Status"] == "Em Atraso"]

    setores = (
        df_atraso.groupby("Departamento")
        .agg(
            Qtd_Atrasos=("ID_TAREFA", "count"),
            Total_Dias=("Dias_Atraso", "sum"),
            Media_Dias=("Dias_Atraso", "mean")
        )
        .reset_index()
        .sort_values("Qtd_Atrasos", ascending=True)
    )

    fig = px.bar(
        setores,
        x="Qtd_Atrasos",
        y="Departamento",
        orientation="h",
        text="Qtd_Atrasos"
    )

    fig.update_layout(
        title="<b>Setores com mais atrasos</b>",
        height=420,
        margin=dict(l=10, r=10, t=50, b=10),
        paper_bgcolor="white",
        plot_bgcolor="white",
        xaxis_title="Quantidade de tarefas em atraso",
        yaxis_title=""
    )

    fig.update_traces(
        textposition="outside"
    )

    return fig"""

def bar_setores_atraso(df):

    projeto = df.iloc[0]["Projeto"]
    df_proj = df[df["Projeto"] == projeto]

    df_atraso = df_proj[df_proj["Status"] == "Em Atraso"]
    setores = (
        df_atraso.groupby("Departamento")
        .agg(
            Qtd_Atrasos=("ID_TAREFA", "count"),
            Media_Dias=("Dias_Atraso", "mean")
        )
        .reset_index()
        .sort_values("Qtd_Atrasos", ascending=True)
    )

    # 🔥 garante segurança caso não tenha dados
    if setores.empty:
        return px.bar(title="Sem atrasos no projeto 🎉")

    max_val = setores["Qtd_Atrasos"].max()

    def cor(valor):
        if valor == max_val:
            return "#D32F2F"   # vermelho (crítico)
        elif valor >= max_val * 0.6:
            return "#EF6C00"   # laranja forte
        elif valor >= max_val * 0.3:
            return "#F9A825"   # amarelo
        else:
            return "#FB8C00"   # laranja leve

    setores["Cor"] = setores["Qtd_Atrasos"].apply(cor)

    fig = px.bar(
        setores,
        x="Qtd_Atrasos",
        y="Departamento",
        orientation="h",
        text="Qtd_Atrasos"
    )

    fig.update_traces(
        marker_color=setores["Cor"],   # ✅ AQUI está a correção real
        textposition="outside",
        marker_line_width=0
    )

    fig.update_layout(
        title="<b>🚨 Atrasos por Departamento</b>",
        height=300,
        margin=dict(l=10, r=10, t=20, b=10),
        paper_bgcolor="white",
        plot_bgcolor="white",
        yaxis_title="",
        showlegend=False
    )

    return fig