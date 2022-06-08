mysql --user=fablab --password=Fablab.123admin fablab << EOF
TRUNCATE TABLE admin;
EOF

mysql --user=fablab --password=Fablab.123admin fablab << EOF
INSERT INTO admin (\`username\`, \`password\`) VALUES ("walid", "1234");
EOF
	
mysql --user=fablab --password=Fablab.123admin fablab << EOF
INSERT INTO admin (\`username\`, \`password\`) VALUES ("thomas", "1234");
EOF
	
mysql --user=fablab --password=Fablab.123admin fablab << EOF
INSERT INTO admin (\`username\`, \`password\`) VALUES ("theivathan", "1234");
EOF
