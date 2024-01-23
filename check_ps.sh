#!/bin/bash
#### Проверка на наличие имеющихся контейнеров хосте




checker="$(docker ps)"
result="$(echo "$checker" | grep -c identidock)"
if [[ $result -gt 0 ]]; then
    docker stop $(docker ps -aq) && docker rm $(docker ps -aq)
else
    echo "$result"

fi
