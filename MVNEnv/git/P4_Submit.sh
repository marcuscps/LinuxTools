#!/bin/bash

if [ "$#" -lt "2" ]; then
    echo -e "Syntax: $0 <initial commit> <final commit>"
    echo
    echo -e "\tNote: the commit range is ]initial, final]."
    echo -e "\tIn other words, first commit is ignored and last is included."
    echo
    echo -e "For each author in the commit range, a configuration script is necessary."
    echo -e "The script is based on the author's email address and must be in the"
    echo -e "directory pointed by the GIT_P4_SCRIPTS_PATH environment variable."
    echo
    echo -e "The script name must be: SET_ENV_<user_id>.sh"
    echo -e "Where user_id is the email, without anything after the @ sign, with"
    echo -e "all dots removed."
    echo
    echo -e "Example:"
    echo -e "\tuser email:\tjohn.hopkins@email.com"
    echo -e "\tscript:\t\tSET_ENV_johnhopkins.sh"
    echo
    echo -e "Each user script must contain the following definitions:"
    echo
    echo -e "\tP4USER \tP4 username"
    echo -e "\tP4CLIENT\tP4 workspace"
    echo -e "\tP4PASSWD\tP4 password"
    echo
    echo -e "Example:"
    echo -e "\texport P4USER=john.hopkins"
    echo -e "\texport P4CLIENT=DEV-Precedence2015-john.hopkins"
    echo -e "\texport P4PASSWD=veryHardPassword"
    echo
    echo -e "The P4 PORT address must be contained in the P4PORT environment variable."
    echo -e "It defaults to 105.103.70.242:1888"
    echo
    echo -e "Note: GIT_P4_SCRIPTS_PATH defaults to ~/Git-P4-Scripts"
    exit
fi

function SAVE_P4_SKIP_SUBMIT_EDIT {
    # Keep the original value of the git-p4.skipsubmitedit configuration
    P4SkipSubmitEdit=`git config --global -l |grep git-p4.skipsubmitedit |cut -d '=' -f 2`
}

function RESTORE_P4_SKIP_SUBMIT_EDIT {
    # Restore the original value of the git-p4.skipsubmitedit configuration
    if [ "${P4SkipSubmitEdit}" == "" ]; then
        git config --global --unset git-p4.skipsubmitedit
    else
        git config --global git-p4.skipsubmitedit ${P4SkipSubmitEdit}
    fi
}

INITIAL_COMMIT=$1
FINAL_COMMIT=$2

# GIT_P4_SCRIPTS_PATH defaults to ~/Git-P4-Scripts
if [ "${GIT_P4_SCRIPTS_PATH}" == "" ]; then
    GIT_P4_SCRIPTS_PATH=~/Git-P4-Scripts
fi

# P4PORT defaults to 105.103.70.242:1888
if [ "${P4PORT}" == "" ]; then
    P4PORT=105.103.70.242:1888
fi

SAVE_P4_SKIP_SUBMIT_EDIT
git config --global git-p4.skipsubmitedit true

# Get first commit to process
commit=`git log --reverse ${INITIAL_COMMIT}..${FINAL_COMMIT} --format="%H" | head -n 1`

while ! [ "${commit}" == "" ]; do
    # Extract the committer's email
    # The script id is the committer's email, without 
    email=`git --no-pager show -s --format="%aE" ${commit}`
    atSignPos=`expr index ${email} @`
    let atSignPos=atSignPos-1
    username=${email:0:${atSignPos}}
    scriptId=${username//\./}

    source ${GIT_P4_SCRIPTS_PATH}/SET_ENV_${scriptId}.sh
    git p4 submit ${commit}
    if ! [ "$?" == "0" ]; then
        echo
        echo "ERROR submitting to P4. Aborting!"
        RESTORE_P4_SKIP_SUBMIT_EDIT
        exit 1
    fi

    # Get next commit to process
    commit=`git log --reverse remotes/p4/master..${FINAL_COMMIT} --format="%H" | head -1`
done

RESTORE_P4_SKIP_SUBMIT_EDIT
echo
echo "DONE!"

