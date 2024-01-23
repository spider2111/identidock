#!/bin/bash

# Установите адрес вашего веб-приложения
WEB_APP_URL="http://$1"

# Установите количество запросов, которые вы хотите выполнить
NUM_REQUESTS=10

# Функция для измерения RTT
measure_rtt() {
    local url=$1
    local num_requests=$2

    for ((i=1; i<=$num_requests; i++)); do
        start_time=$(date +%s.%N)
        response=$(curl -s -o /dev/null -w "%{http_code}" "$url")
        end_time=$(date +%s.%N)

        if [ $response -eq 200 ]; then
            rtt=$(echo "scale=6; $end_time - $start_time" | bc)
            echo "Request $i: RTT $rtt seconds"
        else
            echo "Request $i: Failed (HTTP code $response)"
        fi
    done
}

measure_rtt "$WEB_APP_URL" $NUM_REQUESTS
echo "$WEB_APP_URL $NUM_REQUESTS"