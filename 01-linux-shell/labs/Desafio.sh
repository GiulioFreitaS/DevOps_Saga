#!/bin/bash

arquivo="$1"

if 
    [ -f "$arquivo" ]; then
     echo "Esse arquivo existe"
     cp $arquivo backup.bak
else
     echo "Não existe essa bomba"
fi
