if yad --window-icon="$HOME"/mc-importer/icon.png --title="Minecraft Importer" --text="Welcome to the Minecraft Importer! To continue, click OK. Otherwise, click Cancel." --width=300 --height=150
then
	if archive=$(zenity --file-selection --title="Archive Selection")
	then
		basename=$(basename -a $archive)
		yad --list --window-icon=package --title="Minecraft Archive Guide" --text="Here is a list of archive types to help you." --column="Minecraft Archive" --column="Archive Extension" World .mcworld Addon .mcaddon "Resource/Behavior Pack" .mcpack --no-buttons &
		yad --window-icon=package --title="Archive Type" --text="What type of archive are you importing?" --button="World":10 --button="Addon":20 --button="Resource Pack":30 --button="Behavior Pack":40 --width=300 --height=150
		answer=$?
		name=$(zenity --entry --title="Name Archive" --text="What do you want to name the folder of the archive?" --entry-text="$basename")
		if [ $answer -eq 10 ]
		then
			cd "$HOME"/.local/share/mcpelauncher/games/com.mojang/minecraftWorlds
			mkdir "$name"
			unzip "$archive" -d "$name"
			zenity --info --icon-name=emblem-default --title="World Imported" --text="Successfully imported $basename." --width=300
		else
			if [ $answer -eq 20 ]
			then
				zenity --info --title="Import Addon" --text="To import an addon, you'll need to extract the packs from it to import here."
			else
				if [ $answer -eq 30 ]
				then
					cd "$HOME"/.local/share/mcpelauncher/games/com.mojang/resource_packs
					mkdir "$name"
					unzip "$archive" -d "$name"
					zenity --info --icon-name=emblem-default --title="Pack Imported" --text="Successfully imported $basename." --width=300
				else
					if [ $answer -eq 40 ]
					then
						cd "$HOME"/.local/share/mcpelauncher/games/com.mojang/behavior_packs
						mkdir "$name"
						unzip "$archive" -d "$name"
						zenity --info --icon-name=emblem-default --title="Pack Imported" --text="Successfully imported $basename." --width=300
					fi
				fi
			fi
		fi
		zenity --info --title="Important" --text="Restart Minecraft for the imported files to be applied to the game." --width=300
	fi
fi
