  #!/bin/bash
 #pek-mpd-alpha.sh
 #script pour gérer mpd dans un menu de pekwm
 #Ajoutez ceci dans le fichier ~/.pekwm/menu :
 # 
 # Entry = "" { Actions = "Dynamic /path/to/the/script/pek-mpd-alpha.sh 1 " }
 #
 #thuban@fritalk.org
 #\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/\O/\o/\o/\o/\o/\o/\o/\o/\o/\o/\Q/\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/#
 LISTE_ARTISTE="/tmp/liste_artiste"
 CHEMIN="/home/sean/.pekwm/cripts" # chemin du dossier où sont enregistrés les scripts
 mpc list artist | sort -f > $LISTE_ARTISTE
 NB_ARTISTE=`cat $LISTE_ARTISTE | wc -l`
 N=25 # nombre d'artistes à afficher en une fois
 STATUS1=`mpc current` #Qu'est ce que joue mpd?
 STATUS2=`mpc | grep 'playing' | grep -Eo '[0-9]+:[0-9]+/[0-9]+:[0-9]+'` #temps écoulé

 #la fonction qui affiche les noms d'artistes
 affiche_ () {
     for ((i=$1 ; i<=(($1 + N)) ; i++))
     do
         ARTISTE=`cat $LISTE_ARTISTE | sed -n ${i}p`
         echo "Submenu = \"$ARTISTE\" {"
         echo "Entry \"\" { Actions = \"Dynamic /home/sean/.pekwm/scripts/pek-mpd-artiste.sh $ARTISTE &\" }"
         echo "}" 
        
     done
 }

 echo "Dynamic {"
 #on affiche le status de mpd que la première fois
 if [ "$1" = "1" ]; then
 #mpd joue :
 if [ "$STATUS1" != "" ];then
 echo "Submenu = \"$STATUS1 $STATUS2\" {" #status
 else
 #mpd est arrêté
 echo "Submenu = \"MPD : Ne joue pas\" { "
 fi
 # Un menu d'action pour mpd
 echo "Entry = \"Play-Pause\" { Actions = \" Exec mpc toggle & \" }" #play/payse
 echo "Entry = \"Next\" { Actions = \" Exec mpc next & \" }" #chanson suivant
 echo "Entry = \"Previous\" { Actions = \" Exec mpc prev & \" }" #chanson précédente
 echo "Separator {}"
 fi
 affiche_ $1
 #si on n'est pas à la fin, on propose un sous menu pour afficher les N artistes suivants
 if [ "$i" -le "$NB_ARTISTE" ]; then
 echo "Submenu = \"Plus...\" {"
 echo "Entry \"\" { Actions = \"Dynamic $CHEMIN/pek-mpd-alpha.sh $i &\" }"
 echo "}" 
 fi
 echo "}"

 exit 0; 