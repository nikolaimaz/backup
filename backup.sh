#!/bin/bash
date=$(TZ='Europe/Kyiv' date +"%Y-%m-%d Time %H:%M")
clone='git clone enter repository!!!!!!!!! '
update='git pull enter repository and branch!!!!!!!!!'
push='git push -u origin master'
path="/backup/test"

####################Text color output####################
clear='\033[0m'
green='\033[0;32m'
red='\033[0;31m'


start(){
	if [ -d "$(pwd)/backup" ] 
	then
    	echo "Directory  exists."
    	cd $(pwd)/backup/test
    	$update
	else
		echo "Directory does not exists, creating <backup> directory in $(pwd)/backup "
		sudo apt install yamllint -y
		mkdir "$(pwd)/backup"
		cd $(pwd)/backup
		$clone
		echo please enter youre working email
		read mail
		cd test/ ###### change name of dir to the name youre repository
		git config user.email "$mail"
	fi
}

updating(){
	cd $(pwd)$path
	git reset --hard
	$update
	
}

testing(){
	yamllint .
	yamllint . > test.txt
	yaml_test=$(cat test.txt| grep -o error |sort -u)
}

save(){
	
	cd $(pwd)$path
	testing
	if [[ "$yaml_test" == 'error' ]]
	then 
		echo -e "\n${red}You have error in yaml file,cancelling saving"
		echo -e "please review yaml files${clear}\n"
		rm test.txt

	elif [[ "$yaml_test" == "" ]]
	then
		echo -e "\n${green}everything is ok, saving and pushing${clear}\n"
		rm test.txt
		git add *
		git commit -m "$date"
		$push
	else
		echo 'else'
	fi
}
####################END OF CONFIGS####################


####################MAIN FUNCTION###################

options(){
	echo -e 'Choose option \n 1 Download files update \n\n 2 Save changes and push to Gitlab \n\n 9 Install\n'
	read answ
	if [[ $answ == 1 ]]
	then
		updating

	elif [[ $answ == 2 ]]
	then
		save
		

	elif [[ $answ == 9 ]]
	then
		start
	else
 
		echo "Ooops you have made mistake restarting script"
		echo
		options

	fi
	
}

options
