#!/bin/bash

# OCR Reader CPU 서버 시작 스크립트
# 포트: 40001
# 서비스: Plobin OCR Reader (CPU 버전)

echo "=========================================="
echo "Starting Plobin OCR Reader (CPU)"
echo "Port: 40001"
echo "URL: http://192.168.1.159:40001"
echo "External URL: https://ocr-reader.gupsa.net"
echo "=========================================="

# 현재 디렉토리로 이동
cd "$(dirname "$0")"

# 기존 컨테이너 중지 및 제거
echo "Stopping existing containers..."
docker compose down

# 출력 디렉토리 생성
mkdir -p output cache

# Docker Compose로 서비스 시작
echo "Starting OCR Reader service..."
docker compose up -d --build

# 로그 확인
echo ""
echo "Waiting for service to start..."
sleep 5

echo ""
echo "Service status:"
docker compose ps

echo ""
echo "Recent logs:"
docker compose logs --tail=20

echo ""
echo "=========================================="
echo "OCR Reader CPU is starting!"
echo "Access at: http://192.168.1.159:40001"
echo "API Docs: http://192.168.1.159:40001/docs"
echo "=========================================="
echo ""
echo "To view logs: docker compose logs -f"
echo "To stop: docker compose down"
