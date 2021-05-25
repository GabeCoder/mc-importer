#!/bin/bash

cd "$HOME"/mc-importer
if archive=$(zenity --file-selection --title="Select Package")
then
	basename=$(basename -a "$archive")
	yad --window-icon=package --image=icon.png --title="Package Type" --text="What package are you importing?" --button="World":10 --button="World Template":20 --button="Resource Pack":30 --button="Behavior Pack":40 --width=300 --height=100
	answer=$?
	name=$(zenity --entry --title="Package Name" --text="What do you want to name the contents folder?" --entry-text="$basename")
	if [ $answer == 10 ]
	then
		cd "$HOME"/.local/share/mcpelauncher/games/com.mojang/minecraftWorlds
		mkdir "$name"
		unzip "$archive" -d "$name"
		zenity --info --icon-name=emblem-default --title="World Imported" --text="Successfully imported $basename." --width=300
	elif [ $answer == 20 ]
	then
		cd "$HOME"/.local/share/mcpelauncher/games/com.mojang/world_templates
		mkdir "$name"
		unzip "$archive" -d "$name"
		zenity --info --icon-name=emblem-default --title="World Template Imported" --text="Successfully imported $basename." --width=300
	elif [ $answer == 30 ]
	then
		cd "$HOME"/.local/share/mcpelauncher/games/com.mojang/resource_packs
		mkdir "$name"
		unzip "$archive" -d "$name"
		zenity --info --icon-name=emblem-default --title="Resource Pack Imported" --text="Successfully imported $basename." --width=300
	elif [ $answer == 40 ]
	then
		cd "$HOME"/.local/share/mcpelauncher/games/com.mojang/behavior_packs
		mkdir "$name"
		unzip "$archive" -d "$name"
		zenity --info --icon-name=emblem-default --title="Behavior Pack Imported" --text="Successfully imported $basename." --width=300
	fi
	zenity --info --title="Restart" --text="Restart Minecraft to complete the import." --width=300
fi
