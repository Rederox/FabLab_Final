clear			

username=$(zenity --width=200 --height=200 --title="Add an Admin" --entry --text="Username: ")
password=$(zenity --width=200 --height=200 --title="Add an Admin" --entry --text="Password: ")
	
zenity --width=200 --height=100 --info --title="Add an Admin" --text="Admin Added !"

cat /home/fablab/serviceManagement/blank/blankListUsers4.txt | sed -e s/USERNAME/$username/ | sed -e s/PASSWORD/$password/ | sed -e "/^ *$/d" >> /home/fablab/serviceManagement/listUsersAdmin.txt	
	
					
mysql --user=fablab --password=Fablab.123admin fablab << EOF
INSERT INTO admin (\`username\`, \`password\`) VALUES ("$username", "$password");
EOF
