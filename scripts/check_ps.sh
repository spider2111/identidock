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
echo "$string" 
if [[ $string -gt 1  ]]; then
    docker stop $(docker ps -aq)
    docker rm $(docker ps -aq)
    ansible-playbook run_docker_compose_playbook.yml --extra-vars "ansible_sudo_pass=stk12345"
else
    ansible-playbook run_docker_compose_playbook.yml --extra-vars "ansible_sudo_pass=stk12345"
fi
