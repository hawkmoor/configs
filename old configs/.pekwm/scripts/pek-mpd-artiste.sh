 #!/bin/bash
#pek-mpd-artiste2.sh
#script pour gérer mpd dans un menu de pekwm, va avec pek-mpd-alpha.sh
#thuban@fritalk.org
#-----------------------------------------------------------------------------
#c'est une autre façon de faire pour ajouter les pistes
#De plus, avec l'autre script (pek-mpd-artiste.sh), la chanson suivante était TOUJOURS la première de la playlist...

#!!!les espaces dans les noms de fichier de passent pas!!!
#remplacer la ligne "mpc find artist" par "mpc search artist" si besoin

#\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/\O/\o/\o/\o/\o/\o/\o/\o/\o/\o/\Q/\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/#
##|##|##|##|##|##|##|##|##|##|##|##|##|##|##|##|##|##|##|##|##|##|##|##|##|##|##|##|##|##|##|##|##|##|##|##|##|##|##|##|##|##|##|##|##
##A##A##A##A##A##A##A##A##A##A##A##A##A##A##A##A##A##A##A##A##A##A##A##A##A##A##A##A##A##A##A##A##A##A##A##A##A##A##A##A##A##A##A##A##

LISTE_CHANSON="/tmp/liste_chanson" # on enregistre la liste des chansons de l'artiste dans un fichier pour ne pas avoir à éxécuter cette commande tout le temps

mpc search artist "$1" > $LISTE_CHANSON # on cherche l'artiste dans la bibliotheque

NB_CHANSON=`cat $LISTE_CHANSON | wc -l` # on compte combien de chansons de cet artiste existent

#La variable suivante donne le nombre de chansons différentes dans la bibliothèque
#Elle permet d'éviter d'avoir une liste de lecture avec des doublons, et qui s'agrandit à chaque éxécution du script
NB_CHANSON_LIB=`mpc stats | grep "Songs" | awk '{print $2}'`
NB_CHANSON_PLAYLIST=`mpc playlist | wc -l`
    

if [ "$NB_CHANSON_PLAYLIST" -lt "$NB_CHANSON_LIB" ] | [ "$NB_CHANSON_PLAYLIST" -gt "((NB_CHANSON_LIB+1))" ] ;then
mpc clear
mpc ls | mpc add
NB_CHANSON_PLAYLIST=`mpc playlist | wc -l`
fi
    
    
    if [ "$NB_CHANSON_PLAYLIST" -eq "$NB_CHANSON_LIB" ]; then # Si on n'a pas de doubles, on ajoute la chanson à jouer normalement
        echo "Dynamic {"
            for ((i=1 ; i<=$NB_CHANSON ; i++))
            do        
            CHANSON=`cat "$LISTE_CHANSON" | sed -n ${i}p`
            echo "Entry = \"$CHANSON\" { Actions = \"Exec cat $LISTE_CHANSON | sed -n ${i}p | mpc add && mpc play $((NB_CHANSON_LIB+1)) & \" }"
            done
        echo "}"
        
    else #Si on a déja ajouté une chanson à la playlist, on la supprime avant d'ajouter la nouvelle
    echo "Dynamic {"
            for ((i=1 ; i<=$NB_CHANSON ; i++))
            do        
            CHANSON=`cat "$LISTE_CHANSON" | sed -n ${i}p`
            echo "Entry = \"$CHANSON\" { Actions = \"Exec mpc del $NB_CHANSON_PLAYLIST && cat $LISTE_CHANSON | sed -n ${i}p | mpc add && mpc play $((NB_CHANSON_LIB+1)) & \" }"
            done
        echo "}"
    fi
exit 0;