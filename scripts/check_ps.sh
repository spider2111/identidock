#!/bin/bash

set -e 

#### Проверка на наличие имеющихся контейнеров хосте


#checker=$(docker ps)
output="output.txt"
#string=$(cat "$output" | grep -c identidock)


touch output.txt
checker=$(docker ps)
echo "$checker" > "$output"
string=$(cat "$output" | grep -c identidock)
if [[ $string -gt 0  ]]; then
    docker stop $(docker ps -aq)
    docker rm $(docker ps -aq)
    rm -rf $output
fi
