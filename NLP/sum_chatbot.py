# pip install PyPDF2==3.0.1

import os
from PyPDF2 import PdfReader
import streamlit as st
from langchain.text_splitter import CharacterTextSplitter
from langchain.embeddings import HuggingFaceEmbeddings
from langchain import FAISS
from langchain.chains.question_answering import load_qa_chain
from langchain.chat_models import ChatOpenAI
from langchain.callbacks import get_openai_callback
# conda deactivate

def process_text(text):
    # 텍스트를 청크로 분할
    text_splitter = CharacterTextSplitter(
        separator = "\n",
        chunk_size = 1000,     # 엔터를 기준으로 데이터 구분, 최대 1000자로 설정
        chunk_overlap = 200,   # 인접된 청크들을 겹치게, 200자정도 겹치게해서 저장
        length_function = len   # 청크의 길이(데이터 쪼갰을때 어케 측정할거냐)
    )
    chunks = text_splitter.split_text(text)   # 데이터 쪼갬

    # 임베딩 처리(벡터 변환)
    embeddings = HuggingFaceEmbeddings(model_name = "sentence-transformers/all-MiniLM-L6-v2")
    documents = FAISS.from_texts(chunks, embeddings)
    return documents

def main():
    st.title("★PDF 요약서비스♥")
    st.divider()   # 전체적인 틀 잡아줌
    try:
        os.environ["OPENAI_API_KEY"] = "sk-proj-08SVrC0gT1Fos5I8h0paT3BlbkFJOgDJT8vI6T0NVaYZOPrV"
    except ValueError as e:
        st.error(str(e))

    pdf = st.file_uploader("PDF파일을 업로드해주세요", type = "pdf")

    if pdf is not None:
        pdf_reader = PdfReader(pdf)
        text = "" # text 변수에 PDF 내용을 저장
        for page in pdf_reader.pages:
            text += page.extract_text()

        documents = process_text(text)
        query = "업로드된 PDF 파일의 내용을 3 ~ 5 문장으로 요약해주세요."
        # LLM 에 PDF 파일 요약 요청
        if query:
            docs = documents.similarity_search(query)
            llm = ChatOpenAI(model = "gpt-3.5-turbo", temperature = 0.1)
            chain = load_qa_chain(llm, chain_type = "stuff") # 질문 넣으면 답변

            with get_openai_callback() as cost:
                response = chain.run(input_documents = docs, question = query)
                print(cost)

            st.subheader("--요약결과--:")
            st.write(response)

if __name__ == "__main__":
    main()
    # streamlit run sum_chatbot.py