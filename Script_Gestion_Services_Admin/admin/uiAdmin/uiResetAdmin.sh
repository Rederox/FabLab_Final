clear			
	
zenity --width=200 --height=100 --info --title="Reset to factory" --text="All settings have been reset to default"
	
rm /home/fablab/serviceManagement/listUsersAdmin.txt	
					
mysql --user=fablab --password=Fablab.123admin fablab << EOF
TRUNCATE TABLE admin;
EOF
