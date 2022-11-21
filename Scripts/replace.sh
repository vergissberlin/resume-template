#!/usr/bin/env sh

################################################################################
echo "👉\tReplace characters in \"$1\""

################################################################################
## Variables
################################################################################

# Get current date in format DD.MM.YYYY
document_date=$(date +%d.%m.%Y)

# Get latest git tag
document_git_tag=$(git describe --tags --abbrev=0)


################################################################################
## Environment specific replacements commands
################################################################################

if [ $CI ]; then
	sedcmd="sed -i"
else
	sedcmd="sed -i ''"
fi


################################################################################
## REPLACERS
################################################################################

# Document date
$sedcmd "s/REPLACE_DATE/$document_date/g" $1

# Document version
$sedcmd "s/REPLACE_VERSION/v$CI_COMMIT_REF_NAME/g" $1

# Replace path to images
$sedcmd 's/Media\//Temp\/Media\//g' $1

# Replace RESUME_NAME and escape spaces
$sedcmd "s/REPLACE_NAME/$(echo $RESUME_NAME | sed 's/ /\\ /g')/g" $1

# Replace RESUME_USERNAME
$sedcmd "s/REPLACE_USERNAME/$RESUME_USERNAME/g" $1

# Add "\newpage" in the line before each heading 1
sed -i '' $'s/^# /\\\n\\\newpage\\\n\\\n# /g' $1
