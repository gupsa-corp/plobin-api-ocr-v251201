# OCR Docker 이미지 백업

## 파일 정보

### 1. ocr-gpu.tar (12GB)
- **이미지명**: apiocrplobincom-ocr-reader-gpu:latest
- **기반**: PyTorch 2.1.0 + CUDA 11.8 + cuDNN 8
- **용도**: GPU 가속 OCR 처리
- **VRAM 사용량**: 약 5-9GB (24GB 중)
- **압축 전 크기**: 36.3GB
- **압축 후 크기**: 12GB

**주요 포함 내용:**
- PyTorch 2.9.0 (CUDA 지원)
- NVIDIA CUDA 라이브러리 (4.36GB)
- Surya OCR 모델
- FastAPI 웹 서버
- Python 3.10 + 필요한 모든 의존성

### 2. ocr-cpu.tar (8.3GB)
- **이미지명**: apiocrplobincom-ocr-reader-cpu:latest
- **기반**: Python 3.12-slim
- **용도**: CPU 기반 OCR 처리
- **압축 전 크기**: 25.1GB
- **압축 후 크기**: 8.3GB

**주요 포함 내용:**
- PyTorch 2.1.0 (CPU 버전)
- Surya OCR 모델
- FastAPI 웹 서버
- Python 3.12 + 필요한 모든 의존성

## 이미지 불러오기

### GPU 버전
```bash
docker load < ocr-gpu.tar
docker images | grep ocr-reader-gpu
```

### CPU 버전
```bash
docker load < ocr-cpu.tar
docker images | grep ocr-reader-cpu
```

## 컨테이너 실행

### GPU 버전 실행
```bash
cd /home/gupsa/문서/Host/40001/api.ocr.plobin.com
docker compose up -d
```

**필수 조건:**
- NVIDIA GPU 드라이버 설치
- nvidia-container-toolkit 설치
- Docker에 NVIDIA 런타임 설정

### CPU 버전 실행
docker-compose.yml에서 서비스명을 ocr-reader-cpu로 변경하고:
```bash
docker run -d \
  -p 40001:40001 \
  -v $(pwd)/FastApi:/app \
  -v $(pwd)/fonts:/fonts \
  -v $(pwd)/output:/app/output \
  -v $(pwd)/cache:/app/cache \
  apiocrplobincom-ocr-reader-cpu
```

## 성능 비교

| 항목 | GPU 버전 | CPU 버전 |
|------|---------|---------|
| 이미지 크기 | 36.3GB | 25.1GB |
| tar 크기 | 12GB | 8.3GB |
| 처리 속도 | 빠름 | 느림 |
| VRAM 사용 | 5-9GB | - |
| RAM 사용 | 2-4GB | 4-8GB |

## 빌드 소스

빌드 소스 위치: `/home/gupsa/문서/Host/40001/api.ocr.plobin.com/`

### 재빌드 방법
```bash
cd /home/gupsa/문서/Host/40001/api.ocr.plobin.com

# GPU 버전
docker compose build

# CPU 버전 (Dockerfile 수정 필요)
# FROM pytorch/pytorch:2.1.0-cuda11.8-cudnn8-runtime
# → FROM python:3.12-slim 으로 변경
```

## 서비스 정보

- **포트**: 40001
- **API 엔드포인트**: https://api.ocr.plobin.com
- **SSL**: Let's Encrypt (Traefik 자동 발급)
- **프록시**: Traefik v3.1

## 백업 날짜
생성일: 2025-11-11

## 주의사항
1. GPU 버전은 nvidia-container-toolkit 설치 필요
2. 이미지 파일은 용량이 크므로 이동 시 시간 소요
3. 다른 서버로 옮길 때는 tar 파일만 복사하면 됨
4. 실행 전 Traefik 네트워크 생성 필요: `docker network create traefik`
