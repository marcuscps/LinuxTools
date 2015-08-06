#!/bin/bash

ME=$0

# TODO Set version file
SPEC_FILE=VERSION_FILE

ALG_INDEX=3
FORCE_VERSION=No
ADD_SUFFIX=0
VERSION_INC=1
COMMIT=No

function showHelp {
    echo "Syntax: $ME <options>" >&2
    echo -e "\tOptions:" >&2
    echo -e "\t\t -h\t\t Show help (this content)." >&2
    echo -e "\t\t -x <spec file>\t Define spec file to be processed." >&2
    echo -e "\t\t -f <version>\t Force a new version number." >&2
    echo -e "\t\t -n <algarism>\t Define which algarism will be incremented (1 = first, 3 = default)." >&2
    echo -e "\t\t\t\t Implies option -q 1 (will add one suffix). Override it with -q if desired." >&2
    echo -e "\t\t -q <quantity>\t Define how many suffixes (\".0\") will be added." >&2
    echo -e "\t\t -s\t\t Prevent the addition of a suffix to the new version. Equivalent to -q 0." >&2
    echo -e "\t\t -i <inc>\t Define the version increment (1 = default)." >&2
    echo -e "\t\t -c\t\t Enable version increment git commit. Requires option -j." >&2
    echo -e "\t\t -j <job>\t Defines git commit Kona job (commit suffix)." >&2
    echo
}

# Command line options
while getopts ":hx:f:n:sq:i:cj:" arg; do
	case $arg in
        h)
            showHelp
            exit 0
            ;;
        x)
            echo -e "Spec file: $OPTARG"
            SPEC_FILE=$OPTARG
            ;;
		f)
			echo -e "Forcing version to $OPTARG"
			NEW_VERSION=$OPTARG
            FORCE_VERSION=Yes
			;;
		n)
			echo -e "Forcing increment to happen in the ${OPTARG} algarism."
			ALG_INDEX=$OPTARG
            ADD_SUFFIX=1
			;;
        q)
            echo -e "Suffix quantity: $OPTARG"
            ADD_SUFFIX=$OPTARG
            ;;
        s)
            echo -e "Suffix is not going to be added."
            ADD_SUFFIX=0
            ;;
        i)
            echo -e "Version increment: $OPTARG"
            VERSION_INC=$OPTARG
            ;;
        c)
            echo -e "Commit enabled."
            COMMIT=Yes
            ;;
        j)
            echo -e "Commit Job defined: $OPTARG"
            COMMIT_JOB=$OPTARG
            ;;
		\?)
			echo "Invalid option: -$OPTARG" >&2
			echo >&2
            showHelp
			exit 1
			;;
		:)  echo "Option -$OPTARG requires an argument." >&2
			exit 1
			;;
	esac
done

if [ "${COMMIT}" == "Yes" ]; then
    if [ "${COMMIT_JOB}" == "" ]; then
        echo "ERROR: Commit job required. Use option -j <job>"
        exit 1
    fi
fi

VERSION_LINE=`grep "Version:" ${SPEC_FILE}`
line=${VERSION_LINE// /}
commaPos=`expr index "${line}" :`
CURRENT_VERSION=${line:${commaPos}}

if ! [ "${FORCE_VERSION}" == "Yes" ]; then
    let aux_alg_index=ALG_INDEX-1
    if [ "${ALG_INDEX}" -ge "2" ]; then
        prefix=`echo ${CURRENT_VERSION} | cut -d '.' -f -${aux_alg_index}`.
    else
        prefix=""
    fi
    workDigit=`echo ${CURRENT_VERSION} | cut -d '.' -f ${ALG_INDEX}`
    let workDigit=workDigit+VERSION_INC
    NEW_VERSION="${prefix}${workDigit}"

    while [  ${ADD_SUFFIX} -gt 0 ]; do
        NEW_VERSION=${NEW_VERSION}.0
        let ADD_SUFFIX=ADD_SUFFIX-1
    done

    echo CURRENT VERSION: ${CURRENT_VERSION}
fi

echo NEW VERSION: ${NEW_VERSION}

sed -i "s/${CURRENT_VERSION}/${NEW_VERSION}/" ${SPEC_FILE}

if [ "${COMMIT}" == "Yes" ]; then
    echo -e "Commiting..."
# COMMIT COMMAND -------------------------------------------------------------   
    git commit -m "
Version increment to ${NEW_VERSION}

Jobs:
    ${COMMIT_JOB}" ${SPEC_FILE}
# END OF COMMIT COMMAND ------------------------------------------------------
fi

