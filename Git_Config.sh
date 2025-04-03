#!/bin/bash

#Agrega tu usuario y correo a Git
echo "Ingresa tu usuario de GitHub"
read Usuario
echo "Ingresa tu correo de Github"
read Gmail

#Comando para agregar la entrada 
git config --global user.name "$Usuario"
git config --global user.email "$Gmail"

#Clonar repositorio
echo "¿Quiere clonar un repositorio? (S/N)"
read Respuesta

#Condicional para clonar repositorio
if [[ "$Respuesta" == "S" || "$Respuesta" == "s" ]];then
	echo "Ingresa la url en SSH del repositorio"
	read Repositorio
	git clone "$Repositorio"
fi

#Generar tu clave SSH
echo "Para crear una clave SSH, escribe tu correo vinculado con GitHub"
read GmailGithub
ssh-keygen -t ed25519 -C "$GmailGithub"

#Activa el Agente SSH
echo "Vamos a ejecutarlo! "
eval "$(ssh-agent -s)"
echo "Funcionó?(S/N)"
read RespuestaSSH

if [[ "$RespuestaSSH" == "N" || "$RespuestaSSH" == "n" ]];then
	echo "Vamos a intentar con este:"
	exec ssh-agent bash
	echo "Listo"
else 
	echo "Excelente!"
fi

#Agrega claves al Agente SSH
ssh-add ~/.ssh/id_ed25519

#Mostrar clave publica
echo "Tu clave publica es:"
echo "======================================================="
echo "======================================================="

cat ~/.ssh/id_ed25519.pub

echo "======================================================="
echo "======================================================="

