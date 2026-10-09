#!/bin/bash

# Guarda os PIDs de todos os sleeps numa variável
pids=$(ps | grep sleep | grep -v grep | awk '{print $1}')

if [ -z "$pids" ]; then
  echo "Nenhum sleep rodando."
  exit 0
fi

echo "Sleeps encontrados (PIDs):"
echo "$pids"

read -p "Encerrar todos os sleeps? (s/n) " resp

if [ "$resp" = "s" ]; then
  for pid in $pids; do
    kill "$pid"
  done
  echo "Todos encerrados."
else
  echo "Nada foi encerrado."
fi


