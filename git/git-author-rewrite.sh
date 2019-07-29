#!/bin/bash

#SOURCES:
#https://gist.github.com/octocat/0831f3fbd83ac4d46451
#https://gist.github.com/frz-dev/adf8c2c7275da1369e0cc340feda0ba0
#https://gist.github.com/octocat/0831f3fbd83ac4d46451#gistcomment-2178506

#######################################################################

### Parse Arguments ###
POSITIONAL=()
while [[ $# -gt 0 ]]
do
arg="$1"

function print_help {
    echo "Syntax: $0 [-on|--old_name OLD_NAME] [-oe|--old_email OLD_EMAIL] [-nn|--new_name NEW_NAME] [-ne|--new_email NEW_EMAIL] [-f]" 
    echo "At least one old name/email and one new name/email must be provided."
    echo "Unknown options will be passed to the \'git filter\' command"
    echo "For all matches, both author/committer name and email will be replaced (if both are provided)"
}

case $arg in
    -h)
	print_help
	shift # past argument
    ;;
    -on|--old_name)
	OLD_NAME="$2"
	shift # past argument
	shift # past value
    ;;
    -oe|--old_email)
	OLD_EMAIL="$2"
	shift # past argument
	shift # past value
    ;;
    -nn|--new_name)
	NEW_NAME="$2"
	shift # past argument
	shift # past value
    ;;
    -ne|--new_email)
	NEW_EMAIL="$2"
	shift # past argument
	shift # past value
    ;;
    -c|--committer)
	COMMITTER="true"
	shift # past argument
    ;;
    *)    # unknown option
	POSITIONAL+=("$1") # save it in an array for later
	shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

### Check parameters ###
if [ -z "$OLD_EMAIL" ] && [ -z "$OLD_NAME" ]; then
	echo "Please insert at least old name or old email"
	exit 1
fi
if [ -z "$NEW_EMAIL" ] && [ -z "$NEW_NAME" ]; then
	echo "Please insert at least new name or new email"
	exit 1
fi

### Apply Changes ###
git filter-branch --env-filter "
	if [ \"\$GIT_AUTHOR_NAME\" = \"${OLD_NAME}\" ] || [ \"\$GIT_AUTHOR_EMAIL\" = \"${OLD_EMAIL}\" ]
	then
	    [ ! -z \"$NEW_NAME\" ] && export GIT_AUTHOR_NAME=\"${NEW_NAME}\"
	    [ ! -z \"$NEW_EMAIL\" ] && export GIT_AUTHOR_EMAIL=\"${NEW_EMAIL}\"
	fi
	if ( [ \"\$GIT_COMMITTER_EMAIL\" = \"${OLD_EMAIL}\" ] ) && [ \"$COMMITTER\" = \"true\" ] && [ ! -z \"$NEW_EMAIL\" ]
	then
   	      export GIT_COMMITTER_EMAIL=\"${NEW_EMAIL}\"
	fi
	if [ \"\$GIT_COMMITTER_NAME\" = \"${OLD_NAME}\" ] && [ \"$COMMITTER\" = \"true\" ] && [ ! -z \"$NEW_NAME\" ]
	then
	       export GIT_COMMITTER_NAME=\"${NEW_NAME}\"
	fi
	" $@ --tag-name-filter cat -- --branches --tags

exit 0
#######################################################################
#TODO
OLD_EMAIL=(
    "your-old-email@example.com"
    "your-git-email@users.noreply.github.com"
)
#var=("a" "b")
#var=("${var[@]}" "c")

for NEW_EMAIL in ${OLD_EMAIL[@]}; do
    if [ "$GIT_COMMITTER_EMAIL" == "$NEW_EMAIL" ]; then
        export GIT_COMMITTER_NAME="$NEW_NAME"
        export GIT_COMMITTER_EMAIL="$NEW_EMAIL"
    fi
    if [ "$GIT_AUTHOR_EMAIL" == "$NEW_EMAIL" ]; then
        export GIT_AUTHOR_NAME="$NEW_NAME"
        export GIT_AUTHOR_EMAIL="$NEW_EMAIL"
    fi
done
