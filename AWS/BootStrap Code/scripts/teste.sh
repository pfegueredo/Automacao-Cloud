#!/bin/bash
if groupadd --system prometheus
  useradd -s /bin/false -r -g prometheus prometheus; then
  echo "Usuario criado com sucesso"
else
  echo "Usuario ja existe"
fi
