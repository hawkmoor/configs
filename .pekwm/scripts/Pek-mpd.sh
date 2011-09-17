  #!/bin/bash
 #pek-mpd.sh
 #script pour gérer mpd dans un menu de pekwm
 #Ajoutez ceci dans le fichier ~/.pekwm/menu :
 # Submenu = "MPD :" {
 # Entry = "" { Actions = "Dynamic /path/to/the/script/pek-mpd.sh 1 " }
 # }
 #thuban@fritalk.org
 #\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/\O/\o/\o/\o/\o/\o/\o/\o/\o/\o/\Q/\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/#
 CHEMIN="/home/sean/.pekwm/scripts/" # chemin du dossier où sont enregistrés les scripts
 NB=`mpc playlist | wc -l` # on compte le nombre de chansons
 MUSDIR="~/music" #le répertoire contenant la musique, si la playlist est vide
 STATUS1=`mpc current` #Qu'est ce que joue mpd?
 STATUS2=`mpc | grep 'playing' | grep -Eo '[0-9]+:[0-9]+/[0-9]+:[0-9]+'` #temps écoulé
 PLAYLIST="/tmp/pek-playlist" # on stocke la playlist dans un fichier pour gagner en ressources
 if [ -e $PLAYLIST ]; then
 rm $PLAYLIST
 fi
 mpc playlist | cut -d')' -f2 | cut -c 2- > $PLAYLIST

 N=25 # nombre de chansons à afficher en une fois

 if [ "$NB" = "0" ]; then # Si la playlist est vide, on la rempli
 mpc update $MUSDIR
 mpc ls | mpc add
 fi

 # la fonction qui affichera le menu.  Prend en argument le numéro de
 # la chanson qui doit être affichée en premier
 affiche_ () {
     for ((i=$1 ; i<=(($1 + N)) ; i++))
     do
     echo "Entry = \"$( cat $PLAYLIST | sed -n ${i}p)\" { Actions = \" Exec mpc play $i & \" }"
 done
    
    
 }

 ## Quelques commandes pratiques en début de menu
 echo "Dynamic {"
 if [ "$STATUS1" != "" ];then
 echo "Entry = \"$STATUS1 $STATUS2\" { Actions = \" Exec mpc toggle & \" }" #status
 echo "Separator {}"
 fi
 echo "Entry = \"Play-Pause\" { Actions = \" Exec mpc toggle & \" }" #play/payse
 echo "Entry = \"Next\" { Actions = \" Exec mpc next & \" }" #chanson suivant
 echo "Entry = \"Previous\" { Actions = \" Exec mpc prev & \" }" #chanson précédente
 echo "Separator {}"
 #on affiche les chansons :
 affiche_ $1
 #si on n'est pas à la fin, on propose un sous menu pour afficher les N chansons suivantes
 if [ "$i" -le "$NB" ]; then
 echo "Submenu = \"Plus...\" {"
 echo "Entry \"\" { Actions = \"Dynamic $CHEMIN/pek-mpd.sh $i &\" }"
 echo "}" 
 fi
 echo "}"



 exit 0; 