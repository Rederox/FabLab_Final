clear
	
username=$(zenity --width=200 --height=200 --title="Remove an Admin" --entry --text="Username: ")
password=$(zenity --width=200 --height=200 --title="Remove an Admin" --entry --text="Password: ")
	
zenity --width=200 --height=100 --info --title="Remove an Admin" --text="Admin Removed !"
	
	
cat /home/fablab/serviceManagement/listUsersAdmin.txt | tr "\n" "." | sed -e "s/usr=$username,pwd=$password.//" | sed -e "/^ *$/d" | tr "." "\n" | sed -e "/^ *$/d" >> f3.txt
	
cat f3.txt > /home/fablab/serviceManagement/listUsersAdmin.txt
rm f3.txt	
					
mysql --user=fablab --password=Fablab.123admin fablab<< EOF
DELETE FROM admin WHERE username='$username';
EOF
