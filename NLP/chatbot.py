import streamlit as st
from langchain.llms import OpenAI
import os
os.environ["OPENAI_API_KEY"] = "sk-proj-08SVrC0gT1Fos5I8h0paT3BlbkFJOgDJT8vI6T0NVaYZOPrV"

st.set_page_config(page_title = "뭐든지 질문하세요")
st.title("뭐든지 질문하세요~")

def generate_response(input_text):  # llm이 답변 생성
    llm = OpenAI(model_name = "gpt-3.5-turbo-instruct", temperature = 0)
    st.info(llm(input_text))

with st.form("Question"):  # 사용자로부터 입력 받는 방식
    text = st.text_area("질문 입력:", "OpenAI 는 어떤 유형의 텍스트 모델을 제공하나요?")
    submitted = st.form_submit_button("보내기") # 클릭하면 서버로 전송
    generate_response(text)

    # conda activate chatbot_env 
    # streamlit run chatbot.py
    # pip install pydantic==1.10.9