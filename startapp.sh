#!/usr/bin/env bash

#Version v2.0

if [ "$1" == "-h" ]; then # CALL THE HELP TO EXPLAIN HOW TO USE THE SCRIPT
    echo "This script will create an app inside the apps folder"
    echo "To use type the following line:"
    echo "bash start-app.sh app_name project_folder"
    echo "Replace app_name with the actual name for your app"
    echo "Replace project_folder with the actual name for your project folder path if the script is out else put ."

elif [ "$1" != "" ]; then # CHECK IF YOU ADD THE APP NAME
    if [ -d $2 ]; then # CHECK IF THE PROJECT FOLDER IS ADDED
        cd $2 # CHANGE THE DIRECTORY TO THE PROJECT FOLDER
    fi
    if [ ! -d "apps" ]; then # CHECK IF THE APPS FOLDER EXISTS
        mkdir apps
        touch apps/__init__.py
    fi
    mkdir apps/$1 # CREATE THE APP_NAME FOLDER
    python3 manage.py startapp $1 apps/$1 # CREATE THE APP
    sed -i "s/name = '$1'$/name = \"apps.$1\"/" ./apps/$1/apps.py
    sed -i "s/\"django.contrib.staticfiles\",$/\"django.contrib.staticfiles\",\n    \"apps.$1\",#AUTOGENERATED WITH STARTAPP/" ./$2/settings.py
    sed -i "s/'django.contrib.staticfiles',$/'django.contrib.staticfiles',\n    \"apps.$1\",#AUTOGENERATED WITH STARTAPP/" ./$2/settings.py
    
else
    echo "USE THE PARAMETER -h TO DISPLAY HELP"
    
fi