#!/bin/bash

nome="$1"

if [ -z "$nome" ]; then
  echo "Uso: ./ola.sh Giulio"
   exit 1
fi

echo "Olá, $nome! Hoje é $(date +%d/%m/%Y)"

for i in 1 2 3; do
  echo "Contagem: $i"
done
