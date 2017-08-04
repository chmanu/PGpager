export YELLOW=`echo -e '\033[1;33m'`
export RED=`echo -e '\033[1;31m'`
export GREEN=`echo -e '\033[1;32m'`
export LIGHT_CYAN=`echo -e '\033[1;36m'`
export BLUE=`echo -e '\033[1;34m'`
export NOCOLOR=`echo -e '\033[0m'`
export LESS="-iMSx4 -FXR"

# Commentaires : une ligne par ligne de commande sed:

# La première ligne en jaune
# Les dates (différents formats - contrôles pas fin) en vert
# les symboles de délimitation de colonne en jaune
# le résultat du nombre de ligne en jaune
# les valeurs null en bleu
# dans le cas d'affichage étendu, la ligne numérotant RECORD en jaune
# la ligne de séparation en tête en jaune
# les nombres suivis d'un espace et ne faisant pas partie de la ligne RECORD en cyan
# les nombres en fin de ligne et ne faisant pas partie de la ligne RECORD en cyan
# la valeur "<insufficient privilege>" en rouge

sed -e "1s!\(.*\)!${YELLOW}\1!g" \
        -e "2,\$s!\([0-9]\{4\}\-[0-9]\{2\}\-[0-9]\{2\}\([[:space:]][0-9]\{2\}:[0-9]\{2\}:[0-9]\{2\}\(.[0-9+]\+\)\?\)\?\)!${GREEN}\1${NOCOLOR}!g" \
        -e "2,\$s!|!$YELLOW|$NOCOLOR!g;" \
        -e "s!\(^([0-9]\+\ row\(s\)\?)\)!${YELLOW}\1${NOCOLOR}!g" \
        -e "2,\$s!\((null)\)!${BLUE}\1${NOCOLOR}!g" \
        -e "s!\(-\[ RECORD [0-9]* \][0-9]*[-+]*\)!${YELLOW}\1${NOCOLOR}!g" \
        -e "s!^\([-+]*\)!$YELLOW\1$NOCOLOR!g" \
        -e "/|/{s#\([[:space:]]\+[0-9.]\+\ \)#${LIGHT_CYAN}\1${NOCOLOR}#g}" \
        -e "/|/{s#\([[:space:]]\+[0-9.]\+$\)#${LIGHT_CYAN}\1${NOCOLOR}#g}" \
        -e "s!\(<insufficient privilege>\)!${RED}\1${NOCOLOR}!g" \
 | less

