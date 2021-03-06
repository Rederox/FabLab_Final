#!/bin/bash

clear

count=0
while ((count!=1))
do
	echo
	echo "------------------"
	echo ""
	echo "Select a service"
	echo ""
	echo "1.Asterisk"
	echo "2.DHCP"
	echo "3.TFTP"
	echo "4.Apache2"
	echo "5.MySQL"
	echo "6.Admin"
	echo "7.Config a File in XML"
	echo "8.Select all Services"
	echo "9.Reset to Factory"
	echo "10.Fix"
	echo "Press any key to quit"
	read serviceAnswer
	case $serviceAnswer in
				
		1)
					
			clear
			echo "Asterisk"
			echo ""
			echo "1.Start"
			echo "2.Restart"
			echo "3.Stop"
			echo "4.Status"
			echo "5.Add a User"
			echo "6.Remove a User"
			echo "7.List of Users"
			echo "Press any key to go back"
			read serviceAnswer2
			
			case $serviceAnswer2 in
					
				1)
					clear
					echo "Asterisk Started !"
					echo ""
					sudo /etc/init.d/asterisk start
					;;
				2)
					clear
					echo "Asterisk Restarted !"
					echo ""
					sudo /etc/init.d/asterisk restart
					;;
				3)
					clear
					echo "Asterisk Stopped !"
					echo ""
					sudo /etc/init.d/asterisk stop
					;;
				4)
					clear
					echo "Status of Asterisk !"
					echo ""
					sudo /etc/init.d/asterisk status
					;;
				5)
					clear
					echo "Add a Asterisk user: "
					echo ""
					echo "Number: "
					read number
					cat /home/fablab/serviceManagement/listUsersAsterisk.txt | tr "=" "\n" | tr "," "\n" >> test.txt
					#cat /home/fablab/serviceManagement/listUsersXML.txt | tr "=" "\n" | tr "," "\n" >> test.txt
					if grep -qx $number test.txt
					then
						clear
						echo "User already exist !"
						echo ""
						rm test.txt
					else
						echo "Name: "
						read name
						echo "Secret: "
						read secret

						cat /home/fablab/serviceManagement/blank/blankListUsers.txt | sed -e s/NAME/$name/ | sed -e s/NUMBER/$number/ | sed -e s/SECRET/$secret/ >> /home/fablab/serviceManagement/listUsersAsterisk.txt
								
						cat /home/fablab/serviceManagement/blank/blankExtensions1.txt | sed -e s/NUMBER/$number/ | sed -e s/NUMBER2/$number/ | sed -e s/NUMBER3/$number/ >> /home/fablab/serviceManagement/extensions1.txt 
						
						cat /home/fablab/serviceManagement/blank/blankExtensions2.txt | sed -e s/NUMBER4/$number/ | sed -e s/NUMBER5/$number/ >> /home/fablab/serviceManagement/extensions2.txt
						
						rm /home/fablab/serviceManagement/extensions.txt
						
						cat /home/fablab/serviceManagement/extensions1.txt >> /home/fablab/serviceManagement/extensions3.txt
						cat /home/fablab/serviceManagement/extensions2.txt >> /home/fablab/serviceManagement/extensions3.txt
						cat /home/fablab/serviceManagement/extensions3.txt > /etc/asterisk/extensions.conf
						echo "exten => _[04-9*#],1,Goto(serveurvocal,s,1)" >> /etc/asterisk/extensions.conf
						echo "exten => t,1,Goto(serveurvocal,s,3)" >> /etc/asterisk/extensions.conf
						
						rm /home/fablab/serviceManagement/extensions3.txt
								
						cat /home/fablab/serviceManagement/blank/blankVoicemail.txt | sed -e s/NUMBER/$number/ | sed -e s/NAME/$name/ | sed -e s/NAME2/$name/ | sed -e s/SECRET/$secret/ >> /etc/asterisk/voicemail.conf
						
						echo " " >> /etc/asterisk/users.conf	
						cat /home/fablab/serviceManagement/blank/blankUsers.txt | sed -e s/NUMBER/$number/ | sed -e s/NAME/$name/ | sed -e s/SECRET/$secret/ >> /etc/asterisk/users.conf
						
						rm test.txt
						
						sudo /etc/init.d/asterisk restart
						
						echo ""
						echo "Asterisk User Added!"
					fi
					;;
							
				6)
					clear
					echo "Remove a Asterisk user: "
					echo ""
					echo "Name: "
					read name
					echo "Number: "
					read number
					echo "Secret: "
					read secret
					
					#cat /etc/asterisk/users.conf | tr "\n" "." | tr "[" "*" | tr "]" "," | sed -e "s/*"$number",.type=friend.host=dynamic.dtmfmode=rfc2833.fullname="$name".username="$number".secret="$secret".disallow=all.allow=ulaw.nat=never.hassip=yes.hasiax=no.callwaiting=yes.transfer=yes.canpark=yes.hasvoicemail=yes.qualify=yes.context=fablab.//" | sed -e "/^ *$/d" | tr "." "\n" | tr "*" "[" | tr "," "]" | sed -e "/^ *$/d" >> f1.txt
					
					#cat /etc/asterisk/users.conf | tr "\n" "." | tr "[" "~" | tr "]" "," | sed -e "s/.~"$number",.type=friend.host=dynamic.dtmfmode=rfc2833.fullname="$name".username="$number".secret="$secret".disallow=all.allow=ulaw.nat=never.hassip=yes.hasiax=no.callwaiting=yes.transfer=yes.canpark=yes.hasvoicemail=yes.qualify=yes.context=fablab.//" | tr "." "\n" | tr "~" "[" | tr "," "]" >> f1.txt
					
					cat /etc/asterisk/users.conf | tr "\n" "#" | tr "[" "~" | tr "]" "," | sed -e "s/#~"$number",#type=friend#host=dynamic#dtmfmode=rfc2833#fullname="$name"#username="$number"#secret="$secret"#disallow=all#allow=ulaw#nat=never#hassip=yes#hasiax=no#callwaiting=yes#transfer=yes#canpark=yes#hasvoicemail=yes#qualify=yes#context=fablab#//" | tr "#" "\n" | tr "~" "[" | tr "," "]" >> f1.txt
					
					cat f1.txt > /etc/asterisk/users.conf
					rm f1.txt
							
					rm /etc/asterisk/extensions.conf
					
					cat /home/fablab/serviceManagement/extensions1.txt | tr "\n" "." | tr " " ":" | tr "/" "-" | sed -e "s/exten:=>:"$number",1,Answer.exten:=>:"$number",2,Dial(SIP-"$number",10).exten:=>:"$number",3,Voicemail("$number"@fablab).exten:=>:"$number",4,Hangup.//" | tr "." "\n" | tr ":" " " | tr "-" "/" | sed -e "/^ *$/d" >> f2.txt
					cat f2.txt > /home/fablab/serviceManagement/extensions1.txt
					rm f2.txt
					
					cat /home/fablab/serviceManagement/extensions2.txt | tr "\n" "." | tr " " ":" | tr "/" "-" | sed -e "s/exten:=>:"$number",1,Dial(SIP-$number).//" | tr "." "\n" | tr ":" " " | tr "-" "/" | sed -e "/^ *$/d" >> f8.txt
					cat f8.txt > /home/fablab/serviceManagement/extensions2.txt
					rm f8.txt
					
					cat /home/fablab/serviceManagement/extensions1.txt >> /etc/asterisk/extensions.conf
					cat /home/fablab/serviceManagement/extensions2.txt >> /etc/asterisk/extensions.conf
					echo "exten => _[04-9*#],1,Goto(serveurvocal,s,1)" >> /etc/asterisk/extensions.conf
					echo "exten => t,1,Goto(serveurvocal,s,3)" >> /etc/asterisk/extensions.conf
							
					cat /home/fablab/serviceManagement/listUsersAsterisk.txt | tr "\n" "." | sed -e "s/user="$name",secret="$secret",domain=fablab,number="$number".//" | sed -e "/^ *$/d" | tr "." "\n" | sed -e "/^ *$/d" >> f3.txt
					cat f3.txt > /home/fablab/serviceManagement/listUsersAsterisk.txt
					rm f3.txt
							
					cat /etc/asterisk/voicemail.conf | tr " " "&" | tr "\n" ":" | sed -e "s/"$number"&=>&"$secret","$name","$name"@fablab.//" | tr "&" " " | tr ":" "\n" | sed -e "/^ *$/d" >> f4.txt
					cat f4.txt > /etc/asterisk/voicemail.conf
					rm f4.txt
					echo ""		
					sudo /etc/init.d/asterisk restart
					echo "Asterisk User Removed !"
					;;
							
				7)
					clear
					echo "List of Asterisk Users: "
					echo ""
					cat /home/fablab/serviceManagement/listUsersAsterisk.txt
					;;	
				*)
					clear
					;;
					esac
					;;
				
				
		2)
					
			clear
			echo "DHCP"
			echo ""
			echo "1.Start"
			echo "2.Restart"
			echo "3.Stop"
			echo "4.Status"
			echo "5.Add a User"
			echo "6.Remove a User"
			echo "7.List of Users"
			echo "Press any key to go back"
			read serviceAnswer3
			
			case $serviceAnswer3 in
					
				1)
					clear
					echo "DHCP Started !"
					echo ""
					sudo /etc/init.d/isc-dhcp-server start
					sudo ifconfig enp2s0 192.168.3.83
					sudo /etc/init.d/isc-dhcp-server restart
					;;
				2)
					clear
					echo "DHCP Restarted !"
					echo ""
					sudo /etc/init.d/isc-dhcp-server restart
					;;
				3)
					clear
					echo "DHCP Stopped !"
					echo ""
					sudo /etc/init.d/isc-dhcp-server stop
					sudo ifconfig enp2s0 0.0.0.0
					;;
				4)
					clear
					echo "Status of DHCP !"
					echo ""
					sudo /etc/init.d/isc-dhcp-server status
					;;
				5)						
					clear
					echo "Add a DHCP user: "
					echo ""
					echo "@IP: "
					read ip
					echo "@MAC: (AA:BB:CC:DD:EE:FF)" 
					read mac

					cat /home/fablab/serviceManagement/listUsersDhcp.txt | tr "=" "\n" | tr "," "\n" >> test.txt
							
					if grep -qx $ip test.txt || grep -qx $mac test.txt 
					then
						echo "User already exist !"
					else
						echo "User: "
						read user
						
						echo "" >> /etc/dhcp/dhcpd.conf
						
						cat /home/fablab/serviceManagement/blank/blankDHCP.txt | sed -e s/USER/$user/ | sed -e s/MAC/$mac/ | sed -e s/IP/$ip/ >> /etc/dhcp/dhcpd.conf
						
						cat /home/fablab/serviceManagement/blank/blankListUsers2.txt | sed -e s/USER/$user/ | sed -e s/MAC/$mac/ | sed -e s/IP/$ip/ >> /home/fablab/serviceManagement/listUsersDhcp.txt
						rm test.txt
						sudo /etc/init.d/isc-dhcp-server restart
						echo ""
						echo "DHCP User Added !"
					fi
		
					;;
				6)
					clear
					echo "Remove a DHCP user: "
					echo ""
					echo "Current @IP: "	
					read currentIp
					echo "Current @MAC: (AA-BB-CC-DD-EE-FF)"
					read currentMac
					echo "Current User: "
					read currentUser
								
					#cat /etc/dhcp/dhcpd.conf | tr " " ":" | tr "\n" "+" | sed "s/host:$currentUser:{+hardware:ethernet:"$currentMac";+fixed-address:"$currentIp";+}+//" | tr ":" " " | tr "+" "\n" | sed -e "/^ *$/d" >> f5.txt
					
					cat /etc/dhcp/dhcpd.conf | tr " " "&" | tr "\n" "+" | sed "s/+host&$currentUser&{+hardware&ethernet&"$currentMac";+fixed-address&"$currentIp";+}+//" | tr "&" " " | tr "+" "\n" >> f5.txt
					
					cat f5.txt > /etc/dhcp/dhcpd.conf
					rm f5.txt
							
					cat /home/fablab/serviceManagement/listUsersDhcp.txt | tr "\n" "&" | sed -e "s/user="$currentUser",mac="$currentMac",ip="$currentIp".//" | sed -e "/^ *$/d" | tr "&" "\n" | sed -e "/^ *$/d" >> f6.txt 
					cat f6.txt > /home/fablab/serviceManagement/listUsersDhcp.txt
					rm f6.txt
							
					sudo /etc/init.d/isc-dhcp-server restart
					echo ""
					echo "DHCP User Removed !"	
					;;

				7)
					clear
					echo "List of DHCP Users: "
					echo ""
					cat /home/fablab/serviceManagement/listUsersDhcp.txt
					;;	
				*)
					clear
					;;
				esac
			;;
				
		3)

			clear
			echo "TFTP"
			echo ""
			echo "1.Start"
			echo "2.Restart"
			echo "3.Stop"
			echo "4.Status"
			echo "Press any key to go back"
			read serviceAnswer4
			
			case $serviceAnswer4 in
					
				1)
					clear
					echo "TFTP Started !"
					echo ""
					sudo /etc/init.d/xinetd start
					sudo /etc/init.d/tftpd-hpa start
					;;
				2)
					clear
					echo "TFTP Restarted !"
					echo ""
					sudo /etc/init.d/xinetd restart
					sudo /etc/init.d/tftpd-hpa restart
					;;
				3)
					clear
					echo "TFTP Stopped !"
					echo ""
					sudo /etc/init.d/xinetd stop
					sudo /etc/init.d/tftpd-hpa stop
					;;
				4)
					clear
					echo "Status of TFTP !"
					echo ""
					sudo /etc/init.d/xinetd status
					sudo /etc/init.d/tftpd-hpa status
					;;
				*)
					clear
					;;
				esac			
			;;
		
		4)

			clear
			echo "Apache2"
			echo ""
			echo "1.Start"
			echo "2.Restart"
			echo "3.Stop"
			echo "4.Status"
			echo "Press any key to go back"
			read serviceAnswer4
			
			case $serviceAnswer4 in
					
				1)
					clear
					echo "Apache2 Started !"
					echo ""
					sudo /etc/init.d/apache2 start
					;;
				2)
					clear
					echo "Apache2 Restarted !"
					echo ""
					sudo /etc/init.d/apache2 restart
					;;
				3)
					clear
					echo "Apache2 Stopped !"
					echo ""
					sudo /etc/init.d/apache2 stop
					;;
				4)
					clear
					echo "Status of Apache2 !"
					echo ""
					sudo /etc/init.d/apache2 status
					;;
				*)
					clear
					;;
				esac			
			;;
			
		5)

			clear
			echo "MySQL"
			echo ""
			echo "1.Start"
			echo "2.Restart"
			echo "3.Stop"
			echo "4.Status"
			echo "Press any key to go back"
			read serviceAnswer4
			
			case $serviceAnswer4 in
					
				1)
					clear
					echo "MySQL Started !"
					echo ""
					sudo /etc/init.d/mariadb start
					;;
				2)
					clear
					echo "MySQL Restarted !"
					echo ""
					sudo /etc/init.d/mariadb restart
					;;
				3)
					clear
					echo "MySQL Stopped !"
					echo ""
					sudo /etc/init.d/mariadb stop
					;;
				4)
					clear
					echo "Status of MySQL !"
					echo ""
					sudo /etc/init.d/mariadb status
					;;
				*)
					clear
					;;
				esac			
			;;
		
		
		6)

			clear
			sudo /bin/bash /home/fablab/serviceManagement/admin/sshAdminManagement.sh
			;;
		
		7)
			clear			
			echo "Config a File in XML"
			echo ""
			echo "1.Add a User"
			echo "2.Remove a User"
			echo "3.List of Users"
			echo "Press any key to go back"
			read serviceAnswer5
			
			case $serviceAnswer5 in
								
				1)				
					clear
					echo "Add a XML user: "
					echo ""
					echo "Number: "
					read usernumber
					echo "@MAC: (AABBCCDDEEFF)"
					read usermac
					
					cat /home/fablab/serviceManagement/listUsersXML.txt | tr "=" "\n" | tr "," "\n" >> test.txt
							
					if grep -qx $usermac test.txt || grep -qx $usernumber test.txt
					then
						clear
						echo "User already exist !"
						echo ""
					else
						echo "Name: "
						read username
						echo "Secret: "
						read userpassword
		
						cat /home/fablab/serviceManagement/blank/blankXML.txt | sed -e s/USERNAME/$username/ | sed -e s/USERNUMBER/$usernumber/ | sed -e s/USERPASSWORD/$userpassword/ | sed -e s/USERMAC/$usermac/ > /var/lib/tftpboot/"SEP"$usermac".cnf.xml"
						cat /home/fablab/serviceManagement/blank/blankListUsers3.txt | sed -e s/USERNAME/$username/ | sed -e s/USERNUMBER/$usernumber/ | sed -e s/USERPASSWORD/$userpassword/ | sed -e s/USERMAC/$usermac/ >> /home/fablab/serviceManagement/listUsersXML.txt
						sudo /etc/init.d/asterisk restart
						rm test.txt
						echo ""
						echo "XML User Added !"
					fi				
					;;
	
				2)
					clear
					echo "Remove a XML user: "
					echo ""
					echo "Current User: "
					read currentUser
					echo "Current Number: "
					read currentNumber
					echo "Current Password: "
					read currentPassword
					echo "Current @MAC: (AABBCCDDEEFF)"
					read currentMac
					
					echo ""
					
					cat /home/fablab/serviceManagement/listUsersXML.txt | tr "\n" ":" | sed -e "s/user="$currentUser",number="$currentNumber",secret="$currentPassword",domain=fablab,proxy=192.168.3.83,mac="$currentMac"://" | sed -e "/^ *$/d" | tr ":" "\n" >> f7.txt 
					cat f7.txt > /home/fablab/serviceManagement/listUsersXML.txt
					rm f7.txt
					
					rm /var/lib/tftpboot/"SEP"$currentMac".cnf.xml"
					sudo /etc/init.d/asterisk restart
					echo "XML User Removed !"				
					;;
		
				3)
					clear
					echo "List of XML Users: "
					echo ""
					cat /home/fablab/serviceManagement/listUsersXML.txt
					;;	
				*)
					clear
					;;
				esac
			;;
				
		8)
			clear
			echo "Select all Services"
			echo ""
			echo "1.Start"
			echo "2.Restart"
			echo "3.Stop"
			echo "4.Status"
			echo "Press any key to go back"
			read serviceAnswer6
			
			case $serviceAnswer6 in
					
				1)
					clear
					echo "Services Started !"
					sudo /etc/init.d/mariadb start
					sudo /etc/init.d/xinetd start
					sudo /etc/init.d/tftpd-hpa start
					sudo /etc/init.d/apache2 start
					sudo /etc/init.d/asterisk start
					sudo /etc/init.d/isc-dhcp-server start
					sudo ifconfig enp2s0 192.168.3.83
					sudo /etc/init.d/isc-dhcp-server restart
					;;
				
				2)
					clear
					echo "Services Restarted !"
					sudo /etc/init.d/mariadb restart
					sudo /etc/init.d/xinetd restart
					sudo /etc/init.d/tftpd-hpa restart
					sudo /etc/init.d/apache2 restart
					sudo /etc/init.d/asterisk restart
					sudo /etc/init.d/isc-dhcp-server restart
					;;
				
				3)
					clear
					echo "Services Stopped !"
					sudo /etc/init.d/mariadb stop
					sudo /etc/init.d/xinetd stop
					sudo /etc/init.d/tftpd-hpa stop
					sudo /etc/init.d/apache2 stop
					sudo /etc/init.d/asterisk stop
					sudo /etc/init.d/isc-dhcp-server stop
					sudo ifconfig enp2s0 0.0.0.0
					;;
					
				4)
					clear
					echo "Status of Services !"
					sudo /etc/init.d/mariadb status
					sudo /etc/init.d/xinetd status
					sudo /etc/init.d/tftpd-hpa status
					sudo /etc/init.d/apache2 status
					sudo /etc/init.d/asterisk status
					sudo /etc/init.d/isc-dhcp-server status
					;;
					
				*)
					clear
					;;
				esac					
			;;
		
		9)
			clear

			#sudo rm /etc/asterisk/users.conf
			#sudo rm /etc/asterisk/voicemail.conf
			#sudo rm /etc/asterisk/extensions.conf
			#sudo rm /etc/dhcpd/dhcpd.conf

			sudo rm /home/fablab/serviceManagement/extensions1.txt
			sudo rm /home/fablab/serviceManagement/extensions2.txt
			sudo rm /home/fablab/serviceManagement/listUsersAsterisk.txt
			sudo rm /home/fablab/serviceManagement/listUsersDhcp.txt
			sudo rm /home/fablab/serviceManagement/listUsersXML.txt
			
			sudo cat /home/fablab/serviceManagement/reset/extensions1.txt > /home/fablab/serviceManagement/extensions1.txt 
			sudo cat /home/fablab/serviceManagement/reset/extensions2.txt > /home/fablab/serviceManagement/extensions2.txt
			
			sudo echo "" > /etc/asterisk/extensions.conf
			sudo cat /home/fablab/serviceManagement/extensions1.txt >> /etc/asterisk/extensions.conf
			sudo cat /home/fablab/serviceManagement/extensions2.txt >> /etc/asterisk/extensions.conf
			
			sudo cat /home/fablab/serviceManagement/reset/users.txt > /etc/asterisk/users.conf
			sudo cat /home/fablab/serviceManagement/reset/voicemail.txt > /etc/asterisk/voicemail.conf
			   
			sudo cat /home/fablab/serviceManagement/reset/dhcpd.txt > /etc/dhcp/dhcpd.conf
			
			sudo find /var/lib/tftpboot/ -name '*.cnf.xml' -exec rm {} \;
			
			sudo echo "user=messagerie,secret=1234,domain=fablab,number=602" >> /home/fablab/serviceManagement/listUsersAsterisk.txt
			sudo echo "user=serveurvocal,secret=1234,domain=fablab,number=601" >> /home/fablab/serviceManagement/listUsersAsterisk.txt 
			
			echo ""
			echo "All settings have been reset to default"
			echo ""
			;;

		10)
			clear
			
			#sudo rm /etc/asterisk/users.conf
			#sudo rm /etc/asterisk/voicemail.conf
			#sudo rm /etc/asterisk/extensions.conf
			#sudo rm /etc/dhcpd/dhcpd.conf

			sudo rm /home/fablab/serviceManagement/extensions1.txt
			sudo rm /home/fablab/serviceManagement/extensions2.txt
			sudo rm /home/fablab/serviceManagement/listUsersAsterisk.txt
			sudo rm /home/fablab/serviceManagement/listUsersDhcp.txt
			sudo rm /home/fablab/serviceManagement/listUsersXML.txt
			sudo rm /home/fablab/serviceManagement/listUsersAdmin.txt
			
			sudo cp /home/fablab/serviceManagement/reset/listUsersAdmin.txt /home/fablab/serviceManagement/listUsersAdmin.txt

			#sudo find /var/lib/tftpboot/ -name '*.cnf.xml' -exec rm {} \;
			
			sudo cat /home/fablab/serviceManagement/backup/SEP001D70FC2031.cnf.xml > /var/lib/tftpboot/SEP001D70FC2031.cnf.xml

			sudo cat /home/fablab/serviceManagement/backup/SEP001906445169.cnf.xml > /var/lib/tftpboot/SEP001906445169.cnf.xml

			sudo cat /home/fablab/serviceManagement/backup/SEP00260BD7BA88.cnf.xml > /var/lib/tftpboot/SEP00260BD7BA88.cnf.xml

			sudo cat /home/fablab/serviceManagement/backup/dhcpd.conf > /etc/dhcp/dhcpd.conf

			sudo cat /home/fablab/serviceManagement/backup/extensions.conf > /etc/asterisk/extensions.conf
			sudo cat /home/fablab/serviceManagement/backup/voicemail.conf > /etc/asterisk/voicemail.conf
			sudo cat /home/fablab/serviceManagement/backup/users.conf > /etc/asterisk/users.conf

			sudo /bin/bash /home/fablab/serviceManagement/admin/resetAdmin.sh
			
			echo ""
			echo "Mistakes have been fixed !"
			echo ""
			;;

		
		*)
			clear
			echo "Thanks for using our service ! Have a wondeful day !"
			((count+=1))
			;;
		esac
done
