#!/bin/bash

comando_backup="cp -v -r --backup /home/isaac /backups"
arquivo="/backups/"
diretorio="isaac"
arq_criptografado="backup_dir_home_isaac.tar.gz.gpg"
delarq="$arquivo"/"$arq_criptografado"

# Inicio

clear
echo "=============================================="
echo "########## SCRIPT DE BACKUP LOCAL ##########" 
echo "=============================================="

# Validação super usuario

echo "Por favor, ao utilizar esse script faça login como root"

echo "Você está logado como root?"
echo " "
echo "1) sim"
echo " "
echo "2) não"
echo " "
read -p "Opção: " perm

case $perm in

        1)
                echo " " 
                echo "continuando..."
                ;;
        2)
                echo " "
                echo "Por favor, faça login como root"
                exit 0
                ;;
esac
sleep 3

echo "Verificando se já existe um backup existente" 
sleep 1
if [ -e "$delarq" ]; then
        echo "===================================="
        echo "Atenção, Backup existente encontrado"
        echo "===================================="
        echo " "
        echo $delarq
        echo "===================================="
        echo "Deseja apagar o arquivo existente?"
        echo "1) sim"
        echo "2) não"
        read -p "Opção: " exist

        case $exist in
                1)
                        sleep 1
                        echo "Apagando backup existente"
                        rm -rfv $delarq
                        ;;
                2)
                        sleep 1
                        echo "Cancelando operação"
                        exit 0

        esac
else
        echo "nenhum backup foi encontrado"
        echo "A operação irá continuar" 
fi

sleep 4
echo " "
echo "Para prosseguir, escolha uma opção abaixo: " 
echo " "
echo "1) Fazer backup do diretório Home"
echo " " 
echo "2) Sair" 
echo " "
read -p "Opção: " opcao
sleep 2
case $opcao in

        1)
                echo "Iniciando Backup do Diretório Home"
                echo "Executando o comando de Backup $comando_backup"
                $comando_backup
                ;;
        2)
                echo "Saindo"
                sleep 2
                exit 0
esac

# Criptografar o diretório salvo na pasta de backup
clear
sleep 5
echo "================================="
echo "O backup está sendo criptografado"
echo "================================="
echo " "

sleep 5

export GPG_TTY=$(tty)
echo " "
tar -czvf - -C "$arquivo" "$diretorio" | gpg --symmetric --cipher-algo AES256 --pinentry-mode loopback -o /backups/backup_dir_home_isaac.tar.gz.gpg


echo "O backup foi criptografado" 
echo "O backup criptografado foi salvo no diretório raiz na pasta /backups" 
echo " "
clear
sleep 5
echo "============================================="
echo "Apagando diretório que não está criptografado"
echo "============================================="
sleep 5
del="rm -vrf /backups/isaac"
$del

echo "O script foi executado com sucesso"  


