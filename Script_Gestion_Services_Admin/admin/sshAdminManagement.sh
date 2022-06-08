#!/bin/bash

clear

count=0
while ((count!=1))
do
	echo "Admin"
	echo ""
	echo "1.Add an Admin"
	echo "2.Remove an Admin"
	echo "3.List of Admins"
	echo "4.Reset to factory"
	echo "Press any key to quit"
	read serviceAnswer
	case $serviceAnswer in		
		
		1)
			clear
			sudo /bin/bash /home/fablab/serviceManagement/admin/sshAdmin/sshAddAdmin.sh
			echo ""
			;;
		2)
			clear
			sudo /bin/bash /home/fablab/serviceManagement/admin/sshAdmin/sshRemoveAdmin.sh
			echo ""
			;;
		3)
			clear
			sudo /bin/bash /home/fablab/serviceManagement/admin/listAdmin.sh
			echo ""
			;;
		4)
			clear
			sudo /bin/bash /home/fablab/serviceManagement/admin/sshAdmin/sshResetAdmin.sh
			echo ""
			;;
		*)
			clear
			((count+=1))
			;;
		esac
done
