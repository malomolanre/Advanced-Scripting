#!/bin/bash
echo "Detecting network location..."

if [ `curl google.com 2>&1 | grep HEAD |wc -l` -gt 0 ]
then 
	packet=`ping  proxy.ecu.edu.au -c 2 2>&1 `
	check=`echo $packet |grep "0 received"|wc -l`;
	if [ $check -eq 0 ]
	then
		echo "You are on an ECU network"

		read -p "Please enter your ECU username: " user

		read -sp "Please enter your ECU password: " pass

		if [ `grep -i "http_proxy=" /etc/environment| wc -l` -gt 0 ]
		then
			x=`sed -i "s/^http_proxy.*/http_proxy=http:\/\/$user:$pass@proxy.ecu.edu.au:80/" /etc/environment`
		else
			echo "http_proxy=http://$user:$pass@proxy.ecu.edu.au:80">>/etc/environment
		fi
		echo '
Your proxy has been set!'
	else
		echo "You are off canpus"
		if [ `grep -i "http_proxy=" /etc/environment| wc -l` -gt 0 ]
		then
			`sed -i "/^http_proxy.*/d" /etc/environment`
			echo 'Proxy settings have been cleared'
		else
			echo "No proxy to clear!"
		fi
	fi
	echo 'You are “Online”'
else
	if [ `grep -i "http_proxy=" /etc/environment| wc -l` -gt 0 ]
	then
		`sed -i "/^http_proxy.*/d" /etc/environment`
		echo 'Proxy settings have been cleared'
	else
		echo "No proxy to clear!"
	fi
	echo 'You are “Offline”'
fi
