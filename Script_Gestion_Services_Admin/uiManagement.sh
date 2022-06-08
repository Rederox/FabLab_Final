#!/bin/bash

clear

count=0
while ((count!=1))
do		
		
	userService=("1.Asterisk" "2.DHCP" "3.TFTP" "4.MySQL" "5.Apache2" "6.Admin" "7.Config a File in XML" "8.Select all Services" "9.Reset to Factory" "10.Fix" "Quit")
	serviceAnswer=`zenity --title="Which Service ?" --list --column=Menu "${userService[@]}" --width=200 --height=365`
	case $serviceAnswer in
				
		"1.Asterisk")
					
			userService2=("1.Start" "2.Restart" "3.Stop" "4.Status" "5.Add a User" "6.Remove a User" "7.List of Users" "8.Quit")
			serviceAnswer2=`zenity --width=200 --height=300 --title="1.Asterisk" --list --column=Menu "${userService2[@]}"`
			case $serviceAnswer2 in
					
				"1.Start")
					zenity --width=200 --height=100 --info --text="Asterisk Started !"
					sudo /etc/init.d/asterisk start
					;;
				"2.Restart")
					zenity --width=200 --height=100 --info --text="Asterisk Restarted !"
					sudo /etc/init.d/asterisk restart
					;;
				"3.Stop")
					zenity --width=200 --height=100 --info --text="Asterisk Stopped !"
					sudo /etc/init.d/asterisk stop
					;;
				"4.Status")
					clear
					zenity --width=200 --height=100 --info --text="Status of Asterisk !"
					sudo /etc/init.d/asterisk status
					;;
				"5.Add a User")
					number=$(zenity --width=200 --height=200 --title="Add a Asterisk User" --entry --text="Number:")
					cat /home/fablab/serviceManagement/listUsersAsterisk.txt | tr "=" "\n" | tr "," "\n" >> test.txt
					#cat /home/fablab/serviceManagement/listUsersXML.txt | tr "=" "\n" | tr "," "\n" >> test.txt				
					if grep -qx $number test.txt
					then
						zenity --width=200 --height=100 --info title="Add a Asterisk User" --text="User already exist !"
						rm test.txt
					else
						name=$(zenity --width=200 --height=200 --title="Add a Asterisk User" --entry --text="Name:")
						secret=$(zenity --width=200 --height=200 --title="Add a Asterisk User" --password --text="Secret:")
						cat /home/fablab/serviceManagement/blank/blankListUsers.txt | sed -e s/NAME/$name/ | sed -e s/NUMBER/$number/ | sed -e s/SECRET/$secret/ >> /home/fablab/serviceManagement/listUsersAsterisk.txt
								
						cat /home/fablab/serviceManagement/blank/blankExtensions1.txt | sed -e s/NUMBER/$number/ | sed -e s/NUMBER2/$number/ | sed -e s/NUMBER3/$number/ >> /home/fablab/serviceManagement/extensions1.txt 
						
						cat /home/fablab/serviceManagement/blank/blankExtensions2.txt | sed -e s/NUMBER4/$number/ | sed -e s/NUMBER5/$number/ >> /home/fablab/serviceManagement/extensions2.txt
						
						rm /home/fablab/serviceManagement/extensions.txt
						
						cat /home/fablab/serviceManagement/extensions1.txt >> /home/fablab/serviceManagement/extensions3.txt
						cat /home/fablab/serviceManagement/extensions2.txt >> /home/fablab/serviceManagement/extensions3.txt
						cat /home/fablab/serviceManagement/extensions3.txt > /etc/asterisk/extensions.conf
						echo "exten => _[04-9*#],1,Goto(serveurvocal,s,1)" >> /etc/asterisk/extensions.conf
						echo "exten => t,1,Goto(serveurvocal,s,3)" >> /etc/asterisk/extensions.conf
						
						rm extensions3.txt
								
						cat /home/fablab/serviceManagement/blank/blankVoicemail.txt | sed -e s/NUMBER/$number/ | sed -e s/NAME/$name/ | sed -e s/NAME2/$name/ | sed -e s/SECRET/$secret/ >> /etc/asterisk/voicemail.conf
						
						echo " " >> /etc/asterisk/users.conf
						
						cat /home/fablab/serviceManagement/blank/blankUsers.txt | sed -e s/NUMBER/$number/ | sed -e s/NAME/$name/ | sed -e s/SECRET/$secret/ >> /etc/asterisk/users.conf
						
						rm test.txt

						sudo /etc/init.d/asterisk restart
						zenity --width=200 --height=100 --title="Add a Asterisk User" --info --text="Asterisk User Added!"
					fi
					;;
							
				"6.Remove a User")
					name=$(zenity --width=200 --height=200 --title="Remove a Asterisk User" --entry --text="Name:")
					number=$(zenity --width=200 --height=200 --title="Remove a Asterisk User" --entry --text="Number:")
					secret=$(zenity --width=200 --height=200 --title="Remove a Asterisk User" --password --text="Secret:")
							
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
						
					sudo /etc/init.d/asterisk restart
					zenity --width=200 --height=100 --info --title="Remove a Asterisk User" --text="Asterisk User Removed !"
					;;
							
				"7.List of Users")
					zenity --width=200 --height=100 --info --title="List of Asterisk Users" --text="List of Asterisk Users !"
					clear
					sudo cat /home/fablab/serviceManagement/listUsersAsterisk.txt
					;;	
				*)
					;;
					esac
					;;
				
				
		"2.DHCP")
					
			userService3=("1.Start" "2.Restart" "3.Stop" "4.Status" "5.Add a User" "6.Remove a User" "7.List of Users" "8.Quit")
			serviceAnswer3=`zenity --title="2.DHCP" --list --column=Menu "${userService3[@]}" --width=200 --height=300`
			case $serviceAnswer3 in
					
				"1.Start")
					zenity --width=200 --height=100 --info --text="DHCP Started !"
					sudo /etc/init.d/isc-dhcp-server start
					sudo ifconfig enp2s0 192.168.3.83
					sudo /etc/init.d/isc-dhcp-server restart
					;;
				"2.Restart")
					zenity --width=200 --height=100 --info --text="DHCP Restarted !"
					sudo /etc/init.d/isc-dhcp-server restart
					;;
				"3.Stop")
					zenity --width=200 --height=100 --info --text="DHCP Stopped !"
					sudo /etc/init.d/isc-dhcp-server stop
					sudo ifconfig enp2s0 0.0.0.0
					;;
				"4.Status")
					clear
					zenity --width=200 --height=100 --info --text="Status of DHCP !"
					sudo /etc/init.d/isc-dhcp-server status
					;;
				"5.Add a User")						
					ip=$(zenity --width=200 --height=200 --title="Add a DHCP User" --entry --text="@IP:")
					mac=$(zenity --width=200 --height=200 --title="Add a DHCP User" --entry --text="@MAC: (ex: AA:BB:CC:DD:EE:FF)")
							
					cat /home/fablab/serviceManagement/listUsersDhcp.txt | tr "=" "\n" | tr "," "\n" >> test.txt
							
					if grep -qx $ip test.txt || grep -qx $mac test.txt 
					then
						zenity --width=200 --height=100 --info title="Add a DHCP User" --text="User already exist !"
					else
						user=$(zenity --width=200 --height=200 --title="Add a DHCP User" --entry --text="Host:")
						echo "" >> /etc/dhcp/dhcpd.conf
						
						cat /home/fablab/serviceManagement/blank/blankDHCP.txt | sed -e s/USER/$user/ | sed -e s/MAC/$mac/ | sed -e s/IP/$ip/ >> /etc/dhcp/dhcpd.conf
						
						cat /home/fablab/serviceManagement/blank/blankListUsers2.txt | sed -e s/USER/$user/ | sed -e s/MAC/$mac/ | sed -e s/IP/$ip/ >> /home/fablab/serviceManagement/listUsersDhcp.txt
						rm test.txt
						sudo /etc/init.d/isc-dhcp-server restart
						
						zenity --width=200 --height=100 --info --title="Add a DHCP User" --text="DHCP User Added !"
					fi
							
							
					;;
				"6.Remove a User")
							
					currentIp=$(zenity --width=200 --height=200 --title="Remove a DHCP User" --entry --text="@IP:")
					currentMac=$(zenity --width=200 --height=200 --title="Remove a DHCP User" --entry --text="@MAC: (ex: AA-BB-CC-DD-EE-FF)")
					currentUser=$(zenity --width=200 --height=200 --title="Remove a DHCP User" --entry --text="Host:")
								
					cat /etc/dhcp/dhcpd.conf | tr " " "&" | tr "\n" "+" | sed "s/+host&$currentUser&{+hardware&ethernet&"$currentMac";+fixed-address&"$currentIp";+}+//" | tr "&" " " | tr "+" "\n" >> f5.txt
					
					cat f5.txt > /etc/dhcp/dhcpd.conf
					rm f5.txt
							
					cat /home/fablab/serviceManagement/listUsersDhcp.txt | tr "\n" "&" | sed -e "s/user="$currentUser",mac="$currentMac",ip="$currentIp".//" | sed -e "/^ *$/d" | tr "&" "\n" | sed -e "/^ *$/d" >> f6.txt 
					cat f6.txt > /home/fablab/serviceManagement/listUsersDhcp.txt
					rm f6.txt
							
					sudo /etc/init.d/isc-dhcp-server restart
					zenity --width=200 --height=100 --info --title="Remove a DHCP User" --text="DHCP User Removed !"	
					;;

				"7.List of Users")
					zenity --width=200 --height=100 --info --title="List of DHCP Users" --text="List of DHCP Users !"				
					clear
					cat /home/fablab/serviceManagement/listUsersDhcp.txt
					;;	
				*)
					;;
				esac
			;;
				
		"3.TFTP")

			userService4=("1.Start" "2.Restart" "3.Stop" "4.Status" "5.Quit")
			serviceAnswer4=`zenity --title="3.TFTP" --list --column=Menu "${userService4[@]}" --width=200 --height=250`
			case $serviceAnswer4 in
					
				"1.Start")
					zenity --width=200 --height=100 --info --text="TFTP Started !"
					sudo /etc/init.d/xinetd start
					sudo /etc/init.d/tftpd-hpa start
					;;
				"2.Restart")
					zenity --width=200 --height=100 --info --text="TFTP Restarted !"
					sudo /etc/init.d/xinetd restart
					sudo /etc/init.d/tftpd-hpa restart
					;;
				"3.Stop")
					zenity --width=200 --height=100 --info --text="TFTP Stopped !"
					sudo /etc/init.d/xinetd stop
					sudo /etc/init.d/tftpd-hpa stop
					;;
				"4.Status")
					clear
					zenity --width=200 --height=100 --info --text="Status of TFTP !"
					sudo /etc/init.d/xinetd status
					sudo /etc/init.d/tftpd-hpa status
					;;
				*)
					;;
				esac			
			;;
			
		"4.MySQL")

			userService4=("1.Start" "2.Restart" "3.Stop" "4.Status" "5.Quit")
			serviceAnswer4=`zenity --title="4.MySQL" --list --column=Menu "${userService4[@]}" --width=200 --height=250`
			case $serviceAnswer4 in
					
				"1.Start")
					zenity --width=200 --height=100 --info --text="MySQL Started !"
					sudo /etc/init.d/mariadb start
					;;
				"2.Restart")
					zenity --width=200 --height=100 --info --text="MySQL Restarted !"
					sudo /etc/init.d/mariadb restart
					;;
				"3.Stop")
					zenity --width=200 --height=100 --info --text="MySQL Stopped !"
					sudo /etc/init.d/mariadb stop
					;;
				"4.Status")
					clear
					zenity --width=200 --height=100 --info --text="Status of MySQL !"
					sudo /etc/init.d/mariadb status
					;;
				*)
					;;
				esac			
			;;
			
		"5.Apache2")

			userService4=("1.Start" "2.Restart" "3.Stop" "4.Status" "5.Quit")
			serviceAnswer4=`zenity --title="4.Apache2" --list --column=Menu "${userService4[@]}" --width=200 --height=250`
			case $serviceAnswer4 in
					
				"1.Start")
					zenity --width=200 --height=100 --info --text="Apache2 Started !"
					sudo /etc/init.d/apache2 start
					;;
				"2.Restart")
					zenity --width=200 --height=100 --info --text="Apache2 Restarted !"
					sudo /etc/init.d/apache2 restart
					;;
				"3.Stop")
					zenity --width=200 --height=100 --info --text="Apache2 Stopped !"
					sudo /etc/init.d/apache2 stop
					;;
				"4.Status")
					clear
					zenity --width=200 --height=100 --info --text="Status of Apache2 !"
					sudo /etc/init.d/apache2 status
					;;
				*)
					;;
				esac			
			;;
		

		"6.Admin")
			clear
			sudo /bin/bash /home/fablab/serviceManagement/admin/uiAdminManagement.sh
			;;


		"7.Config a File in XML")

			userService5=("1.Add a User" "2.Remove a User" "3.List of Users" "4.Quit")
			serviceAnswer5=`zenity --title="5.Config a File in XML" --list --column=Menu "${userService5[@]}" --width=200 --height=200`
			case $serviceAnswer5 in
								
				"1.Add a User")
							
					usernumber=$(zenity --width=200 --height=200 --title="Add a XML User" --entry --text="Number")
					usermac=$(zenity --width=200 --height=200 --title="Add a XML User" --entry --text="@MAC (ex: AABBCCDDEEFF):")	
					#cat /home/fablab/wipScript/zenity/listUsersAsterisk.txt | tr "=" "\n" | tr "," "\n" >> test.txt
					cat /home/fablab/serviceManagement/listUsersXML.txt | tr "=" "\n" | tr "," "\n" >> test.txt
							
					if grep -qx $usermac test.txt || grep -qx $usernumber test.txt
					then
						zenity --width=200 --height=100 --info title="Add a XML User" --text="User already exist !"
					else
						username=$(zenity --width=200 --height=200 --title="Add a XML User" --entry --text="Name:")
						userpassword=$(zenity --width=200 --height=200 --title="Add a XML User" --password --text="Secret:")			
						cat /home/fablab/serviceManagement/blank/blankXML.txt | sed -e s/USERNAME/$username/ | sed -e s/USERNUMBER/$usernumber/ | sed -e s/USERPASSWORD/$userpassword/ | sed -e s/USERMAC/$usermac/ > /var/lib/tftpboot/"SEP"$usermac".cnf.xml"
						cat /home/fablab/serviceManagement/blank/blankListUsers3.txt | sed -e s/USERNAME/$username/ | sed -e s/USERNUMBER/$usernumber/ | sed -e s/USERPASSWORD/$userpassword/ | sed -e s/USERMAC/$usermac/ >> /home/fablab/serviceManagement/listUsersXML.txt
						sudo /etc/init.d/asterisk restart
						rm test.txt
						zenity --width=200 --height=100 --info --title="Add a XML User" --text="XML User Added !"
					fi				
					;;
	
				"2.Remove a User")
						
					currentUser=$(zenity --width=200 --height=200 --title="Remove a XML User" --entry --text="Name:")
					currentNumber=$(zenity --width=200 --height=200 --title="Remove a XML User" --entry --text="Number: ")
					currentPassword=$(zenity --width=200 --height=200 --title="Remove a XML User" --password --text="Secret: ")
					currentMac=$(zenity --width=200 --height=200 --title="Remove a XML User" --entry --text="@MAC (ex: AABBCCDDEEFF):")
					cat /home/fablab/serviceManagement/listUsersXML.txt | tr "\n" ":" | sed -e "s/user="$currentUser",number="$currentNumber",secret="$currentPassword",domain=fablab,proxy=192.168.3.83,mac="$currentMac"://" | sed -e "/^ *$/d" | tr ":" "\n" >> f7.txt 
					cat f7.txt > /home/fablab/serviceManagement/listUsersXML.txt
					rm f7.txt
					
					rm /var/lib/tftpboot/"SEP"$currentMac".cnf.xml"
					sudo /etc/init.d/asterisk restart
					zenity --width=200 --height=100 --info --title="Remove a XML User" --text="XML User Removed !"				
					;;
		
				"3.List of Users")
		
					zenity --width=200 --height=100 --info --title="List of XML Users" --text="List of XML Users !"
					clear
					cat /home/fablab/serviceManagement/listUsersXML.txt
					;;	
				*)
					;;
				esac
			;;
				
		"8.Select all Services")
								
			userService6=("1.Start" "2.Restart" "3.Stop" "4.Status" "5.Quit")
			serviceAnswer6=`zenity --title="6.Select all Services" --list --column=Menu "${userService6[@]}" --width=350 --height=350`
			case $serviceAnswer6 in
					
				"1.Start")
					zenity --width=200 --height=100 --info --title="Services Started" --text="Services Started !"
					sudo /etc/init.d/mariadb start
					sudo /etc/init.d/xinetd start
					sudo /etc/init.d/tftpd-hpa start
					sudo /etc/init.d/apache2 start
					sudo /etc/init.d/asterisk start
					sudo /etc/init.d/isc-dhcp-server start
					sudo ifconfig enp2s0 192.168.3.83
					sudo /etc/init.d/isc-dhcp-server restart
					;;
				
				"2.Restart")
					zenity --width=200 --height=100 --info --title="Services Restarted" --text="Services Restarted !"
					sudo /etc/init.d/mariadb restart
					sudo /etc/init.d/xinetd restart
					sudo /etc/init.d/tftpd-hpa restart
					sudo /etc/init.d/apache2 restart
					sudo /etc/init.d/asterisk restart
					sudo /etc/init.d/isc-dhcp-server restart
					;;
				
				"3.Stop")
					zenity --width=200 --height=100 --info --title="Services Stopped" --text="Services Stopped !"
					sudo /etc/init.d/mariadb stop
					sudo /etc/init.d/xinetd stop
					sudo /etc/init.d/tftpd-hpa stop
					sudo /etc/init.d/apache2 stop
					sudo /etc/init.d/asterisk stop
					sudo /etc/init.d/isc-dhcp-server stop
					sudo ifconfig enp2s0 0.0.0.0
					;;
					
				"4.Status")
					clear
					zenity --width=200 --height=100 --info --title="Status of Services" --text="Status of Services !"
					sudo /etc/init.d/mariadb status
					sudo /etc/init.d/xinetd status
					sudo /etc/init.d/tftpd-hpa status
					sudo /etc/init.d/apache2 status
					sudo /etc/init.d/asterisk status
					sudo /etc/init.d/isc-dhcp-server status
					;;
					
				*)
					;;
				esac					
			;;
					

		"9.Reset to Factory")
			clear
			zenity --width=200 --height=100 --info --title="8.Reset to Factory !" --text="All settings have been reset to default"
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
			;;


		
		"10.Fix")
			clear
			zenity --width=200 --height=100 --info --title="9.Fix !" --text="Mistakes have been fixed !"

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

			;;

		
		*)
			clear
			zenity --width=200 --height=100 --info --title="Thanks for using our service !" --text="Have a wondeful day !"
			((count+=1))
			;;
		esac
done
