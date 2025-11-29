# Plobin OCR API Service

OCR (Optical Character Recognition) API 서비스입니다.

## 📋 필수 다운로드 항목

### 1. Docker 이미지 파일들
다음 파일들을 `ocr-image/` 디렉토리에 배치하세요:
```
ocr-image/
├── ocr-gpu.tar     # GPU용 OCR Docker 이미지 (용량: ~2-3GB)
└── ocr-cpu.tar     # CPU용 OCR Docker 이미지 (용량: ~1-2GB)
```

### 2. Python 가상환경 설정
```bash
cd api.ocr.plobin.com/FastApi/
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

### 3. 필수 라이브러리들 (자동 설치됨)
- PyTorch + CUDA 지원
- OpenCV
- FastAPI
- 기타 OCR 관련 패키지들

## 🚀 실행 방법

### Docker 이미지 로드
```bash
# GPU 버전
docker load < ocr-image/ocr-gpu.tar

# CPU 버전
docker load < ocr-image/ocr-cpu.tar
```

### 서비스 시작
```bash
# 포트 40001에서 실행
python3 -m http.server 40001 --bind 0.0.0.0
```

## 📁 디렉토리 구조

```
.
├── api.ocr.plobin.com/     # 메인 OCR API 코드
├── ocr-image/              # Docker 이미지 파일들 (gitignore됨)
├── test-ocr-files/         # 테스트용 파일들
└── README.md
```

## ⚠️ 주의사항

- `ocr-image/` 폴더의 Docker tar 파일들은 용량이 커서 Git에 포함되지 않습니다
- `venv/` 가상환경은 로컬에서 직접 생성해야 합니다
- CUDA 라이브러리들은 `pip install` 시 자동으로 다운로드됩니다

## 🌐 접근 URL

- HTTP: http://192.168.1.245:40001
- 도메인: http://api.ocr.plobin.com:40001