#!/bin/bash

clear

count=0
while ((count!=1))
do
		
	userService=("1.Add an Admin" "2.Remove an Admin" "3.List of Admins" "4.Reset to factory" "Quit")
	serviceAnswer=`zenity --title="Which Service ?" --list --column=Menu "${userService[@]}" --width=200 --height=225`
	case $serviceAnswer in
		
		"1.Add an Admin")
			clear
			sudo /bin/bash /home/fablab/serviceManagement/admin/uiAdmin/uiAddAdmin.sh
			;;
		"2.Remove an Admin")
			clear
			sudo /bin/bash /home/fablab/serviceManagement/admin/uiAdmin/uiRemoveAdmin.sh
			;;
		"3.List of Admins")
			clear
			sudo /bin/bash /home/fablab/serviceManagement/admin/listAdmin.sh
			;;
		"4.Reset to factory")
			clear
			sudo /bin/bash /home/fablab/serviceManagement/admin/uiAdmin/uiResetAdmin.sh
			;;
		*)
			clear
			((count+=1))
			;;
		esac
done
