# Getting port of webserver because every time port will change or we can also fix it 
port=$(sudo kubectl get -o jsonpath="{.spec.ports[0].nodePort}" services webserver)
# checking site is working or not
status=$(sudo curl -o /dev/null -s -w "%{http_code}" 192.168.99.106:"$port")
if [[ "$status" == 200 ]]
then 
	echo "App is working fine"
    exit 0
else
	echo "App is Not working"
    exit 1
fi
