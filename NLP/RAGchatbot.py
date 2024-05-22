import streamlit as st
from PyPDF2 import PdfReader
from langchain.embeddings import OpenAIEmbeddings, SentenceTransformerEmbeddings
from langchain.chat_models import ChatOpenAI
from langchain.chains import ConversationalRetrievalChain, RetrievalQA
from langchain.memory import ConversationBufferWindowMemory
from langchain.vectorstores import FAISS
from langchain.document_loaders import PyPDFLoader 
from langchain.text_splitter import RecursiveCharacterTextSplitter

import os
os.environ["OPENAI_API_KEY"] = "sk-proj-08SVrC0gT1Fos5I8h0paT3BlbkFJOgDJT8vI6T0NVaYZOPrV"

# PDF 문서에서 텍스트 추출
def get_pdf_text(pdf_docs):
    text = ''
    for pdf in pdf_docs:
        pdf_reader = PdfReader(pdf)
        for page in pdf_reader.pages:
            text += page.extract_text()
    return text

# 지정된 조건에 따라 주어진 텍스트를 더 작은 덩어리로 분할
def get_text_chunks(text):
    text_splitter = RecursiveCharacterTextSplitter(
        separators= '\n',
        chunk_size = 1000,
        chunk_overlap = 200,
        length_function = len
    )
    chunks = text_splitter.split_text(text)
    return chunks

# 주어진 텍스트 청크에 대해 임베딩을 생성하고 파이스를 사용하여 벡터 저장소를 생성
def get_vectorstore(text_chujnks):
    embeddings = SentenceTransformerEmbeddings(model_name = 'all-MiniLM-L6-v2')
    vectoresotre = FAISS.from_texts(texts = text_chujnks, embedding = embeddings)
    return vectoresotre

# 주어진 벡터 저장소로 대화 체인을 초기화
def get_conversation_chain(vectorstore):
    # ConversationBufferWindowMemory 에 이전 대화 저장
    memory = ConversationBufferWindowMemory(memory_key= 'chat_history', return_messages= True)

    # ConversationalRetrievalChain을 통해 랭체인 챗봇에 쿼리 전송 
    conversation_chain = ConversationalRetrievalChain.from_llm(
        llm = ChatOpenAI(temperature = 0, model_name = 'gpt-3.5-turbo'),
        retriever = vectorstore.as_retriever(),
        get_chat_history= lambda h: h, # h에 히스토리 저장 
        memory = memory
    )
    return conversation_chain

user_uploads = st.file_uploader('파일을 업로드해주세요', accept_multiple_files= True)

if user_uploads is not None:
    if st.button('Upload'):
        with st.spinner('처리 중..'):
            # PDF 텍스트 가져오기
            raw_text = get_pdf_text(user_uploads)

            # 텍스트에서 청크 검색
            text_chunks = get_text_chunks(raw_text)

            # PDF 텍스트 저장을 위해 파이스 벡터 저장소 만들기 
            vectorstore = get_vectorstore(text_chunks)
            
            # 대화 체인 만들기
            st.session_state.conversation = get_conversation_chain(vectorstore)

# : 왈라스 연산자, user에 할당하면서 조건문을 만드는것 
if user_query := st.chat_input('질문을 입력해주세요~'):
    # 대화 체인을 사용하여 사용자의 메시지를 처리
    if 'conversation' in st.session_state:
        result = st.session_state.conversation({
            'question' : user_query,
            'chat_history' : st.session_state.get('chat_history', [])
        })
        response = result['answer']
    else:
        response = '먼저 문서를 업로드해주세요'

    with st.chat_message('assistant'):
        st.write(response)

# streamlit run RAGchat.py