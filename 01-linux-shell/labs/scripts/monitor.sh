
#!/bin/bash

if [ -z "$1" ]; then
   echo "escreve certo cabeçudo"
fi

if ps -W | grep -i "$1" | grep -v grep > /dev/null; then
echo "$1 esta rodando"

else

  echo "$1 não esta rodando"

fi

