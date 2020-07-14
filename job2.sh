# file name must be index for performing  this task
if sudo kubectl get pods | grep webserver
then 
	echo "Already Running"
    echo "But creating a new fresh pod"
    sudo kubectl delete all --all
fi

    
if sudo ls /Base_OS/task3/ | grep "index"
then
	file=$(sudo ls /Base_OS/task3/ | grep "index")
    extension=${file##*.}
    
    if [[ "$extension" == "html" ]]
    then 
		echo "HTML file found"
        sudo kubectl run webserver --image=httpd
        sudo kubectl expose pod webserver --port=80 --type=NodePort
        sleep 60
        sudo kubectl cp /Base_OS/task3/index."$extension" webserver:/usr/local/apache2/htdocs/
    elif [[ "$extension" == "php" ]]
    then 
    	echo "PHP file found"
        sudo kubectl run webserver --image=vimal13/apache-webserver-php
        sudo kubectl expose pod webserver --port=80 --type=NodePort
        sleep 60
        sudo kubectl cp /Base_OS/task3/index."$extension" webserver:/var/www/html/
   	else
    	echo "Neither HTML nor PHP file found"
        exit 1
    fi
else
	echo "File name index not found"
    exit 1

fi 
