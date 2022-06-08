clear			
	echo "Login Admin"
	echo ""
	echo "Remove an Admin"
	echo ""
	echo "Username: "
	read username
	
	echo "Password: "
	read password
	
	clear
	echo "Admin added !"
	
	cat /home/fablab/serviceManagement/listUsersAdmin.txt | tr "\n" "." | sed -e "s/usr=$username,pwd=$password.//" | sed -e "/^ *$/d" | tr "." "\n" | sed -e "/^ *$/d" >> f3.txt
	
	cat f3.txt > /home/fablab/serviceManagement/listUsersAdmin.txt
	rm f3.txt	
					
	mysql --user=fablab --password=Fablab.123admin fablab<< EOF
	DELETE FROM admin WHERE username='$username';
	EOF
