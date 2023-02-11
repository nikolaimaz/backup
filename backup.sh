#!/bin/bash
date=$(TZ='Europe/Kyiv' date +"%Y-%m-%d Time %H:%M")
clone='git clone enter repository!!!!!!!!! '
update='git pull enter repository and branch!!!!!!!!!'
push='git push -u origin master'
path="/backup/test"

start(){
        if [ -d "$(pwd)/backup" ] 
        then
        echo "Directory  exists."
        cd $(pwd)/backup/test
        $update
        else
                echo "Directory does not exists, creating <backup> directory in $(pwd)/backup "
                mkdir "$(pwd)/backup"
                cd $(pwd)/backup
                $clone
                echo please enter youre working email
                read mail
                cd test/
                git config user.email "$mail"
fi
}

updating(){
        cd $(pwd)$path
        git reset --hard
        $update

}

save(){

        cd $(pwd)$path

        git add *

        git commit -m "$date"

}

options(){
        echo -e 'Choose option \n 1 Download files update  \n 2 Save changes and push to Gitlab \n 9 Install '
        read answ
        if [[ $answ == 1 ]]
        then
                updating

        elif [[ $answ == 2 ]]
        then
                save
                $push

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

