#!/bin/bash

if [ "$#" -lt "2" ]; then
    echo -e "Syntax: $0 <initial commit> <final commit>"
    echo
    echo -e "\tNote: the commit range is ]initial, final]."
    echo -e "\tIn other words, first commit is ignored and last is included."
    echo
    echo -e "It is necessary to define an entry in \${GIT_P4_SCRIPTS_PATH}/P4_Ids"
    echo -e "for each committer in the commit range."
    echo
    echo -e "The syntax for the \${GIT_P4_SCRIPTS_PATH}/P4_Ids file is:"
    echo
    echo -e "\t<email>=<p4_id>"
    echo
    echo -e "Example:"
    echo -e "\tjohn.hopkins@email.com=RQ123456-12345"
    echo
    echo -e "Note: GIT_P4_SCRIPTS_PATH defaults to ~/Git-P4-Scripts"
    exit
fi

INITIAL_COMMIT=$1
FINAL_COMMIT=$2

# GIT_P4_SCRIPTS_PATH defaults to ~/Git-P4-Scripts
if [ "${GIT_P4_SCRIPTS_PATH}" == "" ]; then
    GIT_P4_SCRIPTS_PATH=~/Git-P4-Scripts
fi

declare -A P4_MAP

# Read each user's P4 id from ${GIT_P4_SCRIPTS_PATH}/P4_Ids
while read user_config; do
    email=`echo ${user_config} | cut -d '=' -f 1`
    p4_id=`echo ${user_config} | cut -d '=' -f 2`
    P4_MAP[${email}]="${p4_id}"
done < ${GIT_P4_SCRIPTS_PATH}/P4_Ids

# It is tricky to compare strings inside the filter script.
# EVAL causes that to behavior strangely.
# The solution is to use case (the second in the FILTER_SUFFIX) to
# emulate a substring function.
# It is also possible to use python to process the commit message,
# but it is a little troublesome.
# Complete investigation can be found here:
#   http://stackoverflow.com/questions/31613192/git-how-add-a-suffix-to-commit-messages-of-a-commit-range-only-if-is-not-alread/31616261#31616261
FILTER_PREFIX="
    ORIGINAL_COMMIT=\`cat\` &&
    echo \"\${ORIGINAL_COMMIT}\" &&
    case "\${GIT_AUTHOR_EMAIL}" in"

FILTER_SUFFIX="
        *) p4_job=\"UNKNOWN\" ;;
    esac &&
    case \"\${ORIGINAL_COMMIT}\" in
        *Jobs:*) ;;
        *)
            echo
            echo Jobs:
            echo -e \"\t\${p4_job}\"
    esac"

# Create the filter:
# First, accumulate the prefix.
# Add one case statement for each user
# Finaly, add the suffix.
FILTER=${FILTER_PREFIX}
for KEY in "${!P4_MAP[@]}"; do
    FILTER=${FILTER}"
        \"${KEY}\") p4_job=\"${P4_MAP[${KEY}]}\" ;;"
done
FILTER=${FILTER}${FILTER_SUFFIX}

echo Running git filter branch
git filter-branch --msg-filter "${FILTER}" ${INITIAL_COMMIT}..${FINAL_COMMIT}

