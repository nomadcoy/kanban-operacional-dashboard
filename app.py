import streamlit as st

from pages.dashboard import dashboard

from config import *

from streamlit_autorefresh import st_autorefresh

st_autorefresh(
    interval=60000,
    key="kanban_rotate"
)

st.set_page_config(

    page_title=PAGE_TITLE,

    page_icon=PAGE_ICON,

    layout=LAYOUT,

    initial_sidebar_state=INITIAL_SIDEBAR_STATE

)

st.markdown("""
<style>
.block-container {
    padding-top: 2.5rem !important;
    padding-bottom: 1rem !important;
    max-width: 100% !important;
}

/* evita corte no topo em alguns browsers */
[data-testid="stAppViewContainer"] {
    padding-top: 0rem;
}

/* opcional: remove espaçamento extra do Streamlit */
div[data-testid="stVerticalBlock"] {
    gap: 0.4rem !important;
}

header {
    visibility: hidden;
}
</style>
""", unsafe_allow_html=True)

dashboard()