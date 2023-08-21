#!/bin/bash

read -r -p "RedHat / CentOS====>>>1,Ubuntu====>>>2,#### Debian====>>>3" input
case $input in
    1)
    curl -sSL https://resource.fit2cloud.com/1panel/package/quick_start.sh -o quick_start.sh && sh quick_start.sh
		;;

    2)
		curl -sSL https://resource.fit2cloud.com/1panel/package/quick_start.sh -o quick_start.sh && sudo bash quick_start.sh
       	;;

    3)
		curl -sSL https://resource.fit2cloud.com/1panel/package/quick_start.sh -o quick_start.sh && bash quick_start.sh
       	;;
    *)
		echo "Invalid input..."
		exit 1
		;;
esac
