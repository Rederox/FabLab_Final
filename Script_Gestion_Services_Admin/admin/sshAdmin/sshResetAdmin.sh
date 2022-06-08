clear			
	echo "Reset to factory !"
	
	rm /home/fablab/serviceManagement/listUsersAdmin.txt	
					
	mysql --user=fablab --password=Fablab.123admin fablab << EOF
	TRUNCATE TABLE admin;
	EOF
