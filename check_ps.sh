#!/bin/bash

set -e 

#### Проверка на наличие имеющихся контейнеров хосте




checker="$(docker ps) | grep -c identidock"
if [[ $checker -gt 0  ]]; then
    docker compose stop && docker compose rm
fi
