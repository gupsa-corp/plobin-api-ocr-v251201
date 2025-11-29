FROM pytorch/pytorch:2.1.0-cuda11.8-cudnn8-runtime

# 시스템 의존성 설치 (OCR 및 이미지 처리용)
RUN apt-get update && apt-get install -y \
    libgl1 \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libgomp1 \
    fonts-nanum \
    && rm -rf /var/lib/apt/lists/*

# 작업 디렉토리 설정
WORKDIR /app

# Python 의존성 복사 및 설치
COPY FastApi/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 애플리케이션 코드 복사
COPY FastApi/ .

# 폰트 복사
COPY fonts/ /fonts/

# 출력 디렉토리 생성
RUN mkdir -p /app/output /app/cache

# 포트 노출
EXPOSE 40001

# 서버 실행
CMD ["uvicorn", "api_server:app", "--host", "0.0.0.0", "--port", "40001"]
