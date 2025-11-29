#!/bin/bash

# OCR 서버 모니터링 스크립트
LOG_FILE="/var/log/plobin-ocr-monitor.log"
CONTAINER_NAME="plobin-ocr-reader-gpu"
SERVICE_URL="http://localhost:40001/health"

# 로그 함수
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | sudo tee -a "$LOG_FILE"
}

# 컨테이너 상태 확인
check_container() {
    if ! docker ps -q -f name=$CONTAINER_NAME | grep -q .; then
        log_message "WARNING: Container $CONTAINER_NAME is not running"
        return 1
    fi
    return 0
}

# 서비스 헬스체크
check_health() {
    if ! curl -s -f "$SERVICE_URL" > /dev/null 2>&1; then
        log_message "ERROR: Health check failed for $SERVICE_URL"
        return 1
    fi
    return 0
}

# 서비스 재시작
restart_service() {
    log_message "Attempting to restart OCR service..."
    cd /home/gupsa/문서/Host/40001/api.ocr.plobin.com
    docker compose down
    sleep 5
    docker compose up -d
    log_message "Service restart initiated"
}

# 메인 체크 로직
main() {
    if ! check_container; then
        restart_service
        sleep 30
    fi

    if ! check_health; then
        log_message "Health check failed, restarting service..."
        restart_service
    else
        log_message "OCR service is healthy"
    fi
}

# 실행
main