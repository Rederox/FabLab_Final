clear			
	echo "Login Admin"
	echo ""
	
	echo "Add an Admin"
	echo ""
	
	echo "Username: "
	read username
	
	echo "Password: "
	read password
	
	cat /home/fablab/serviceManagement/blank/blankListUsers4.txt | sed -e s/USERNAME/$username/ | sed -e s/PASSWORD/$password/ | sed -e "/^ *$/d" >> /home/fablab/serviceManagement/listUsersAdmin.txt	
						
	mysql --user=fablab --password=Fablab.123admin fablab << EOF
	INSERT INTO admin (\`username\`, \`password\`) VALUES ("$username", "$password");
	EOF
