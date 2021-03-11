if yad --title="Minecraft Importer" --text="Welcome to the Minecraft Importer! To continue, click OK. Otherwise, click Cancel." --width=300 --height=150
then
	if archive=$(zenity --file-selection --title="Archive Selection")
	then
		basename=$(basename -a $archive)
		yad --list --title="Minecraft Archive Guide" --text="Here is a list of archive types to help you." --column="Minecraft Archive" --column="Archive Extension" World .mcworld Addon .mcaddon "Resource/Behavior Pack" .mcpack --no-buttons &
		yad --title="Archive Type" --text="What type of archive are you importing?" --button="World":0 --button="Addon":1 --button="Resource Pack":2 --button="Behavior Pack":3 --width=300 --height=150
		if [ $? -eq 0 ]
		then
			cd $HOME/.local/share/mcpelauncher/games/com.mojang/minecraftWorlds
			mkdir "$basename"
			unzip "$archive" -d "$basename"
			zenity --info --icon-name=emblem-default --title="World Imported" --text="Successfully imported $basename." --width=300
		else
			if [ $? -eq 1 ]
			then
				zenity --info --title="Import Addon" --text="To import an addon, you'll need to extract the packs from it to import here."
			else
				if [ $? -eq 2 ]
				then
					cd $HOME/.local/share/mcpelauncher/games/com.mojang/resource_packs
					mkdir "$basename"
					unzip "$archive" -d "$basename"
					zenity --info --icon-name=emblem-default --title="Pack Imported" --text="Successfully imported $basename." --width=300
				else
					if [ $? -eq 3 ]
					then
						cd $HOME/.local/share/mcpelauncher/games/com.mojang/behavior_packs
						mkdir "$basename"
						unzip "$archive" -d "$basename"
						zenity --info --icon-name=emblem-default --title="Pack Imported" --text="Successfully imported $basename." --width=300
					fi
				fi
			fi
		fi
		zenity --info --title="Important" --text="Restart Minecraft for the imported files to be applied to the game." --width=300
	fi
fi
