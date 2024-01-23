#!/bin/bash

# Настройки теста

url="http://$1"
concurrency=255
time=20S
siege -c $concurrency -t $time $url
