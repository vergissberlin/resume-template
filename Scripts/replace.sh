#!/usr/bin/env sh

################################################################################
echo "👉\tReplace characters in \"$1\""

################################################################################
## Variables
################################################################################

# Load dot env file with variables
set -a
. .env 2>/dev/null || true
set +a

# Get current date in format DD.MM.YYYY
document_date=$(date +%d.%m.%Y)

# Get latest git tag
document_git_tag=$(git describe --tags --abbrev=0 2>/dev/null || echo "v0.0.0")


################################################################################
## Environment specific replacements commands
################################################################################

if [ "$CI" = "true" ]; then
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

# Replace basic resume information
$sedcmd "s/REPLACE_NAME/$(echo $RESUME_NAME | sed 's/ /\\ /g')/g" $1
$sedcmd "s/REPLACE_USERNAME/$RESUME_USERNAME/g" $1
$sedcmd "s/REPLACE_EMAIL/$RESUME_EMAIL/g" $1

# Replace contact information
$sedcmd "s|REPLACE_PHONE|$RESUME_PHONE|g" $1
$sedcmd "s|REPLACE_ADDRESS|$RESUME_ADDRESS|g" $1
$sedcmd "s|REPLACE_WEBSITE|$RESUME_WEBSITE|g" $1
$sedcmd "s|REPLACE_LINKEDIN|$RESUME_LINKEDIN|g" $1
$sedcmd "s|REPLACE_GITHUB|$RESUME_GITHUB|g" $1

# Replace social media
$sedcmd "s|REPLACE_TWITTER|$RESUME_TWITTER|g" $1
$sedcmd "s|REPLACE_XING|$RESUME_XING|g" $1
$sedcmd "s|REPLACE_STACKOVERFLOW|$RESUME_STACKOVERFLOW|g" $1

# Replace company information
$sedcmd "s/REPLACE_COMPANY_1/$RESUME_COMPANY_1/g" $1
$sedcmd "s/REPLACE_COMPANY_2/$RESUME_COMPANY_2/g" $1
$sedcmd "s/REPLACE_COMPANY_3/$RESUME_COMPANY_3/g" $1
$sedcmd "s/REPLACE_COMPANY_4/$RESUME_COMPANY_4/g" $1

# Replace university information
$sedcmd "s/REPLACE_UNIVERSITY/$RESUME_UNIVERSITY/g" $1
$sedcmd "s|REPLACE_UNIVERSITY_URL|$RESUME_UNIVERSITY_URL|g" $1

# Replace project information
$sedcmd "s/REPLACE_PROJECT_1_NAME/$RESUME_PROJECT_1_NAME/g" $1
$sedcmd "s|REPLACE_PROJECT_1_URL|$RESUME_PROJECT_1_URL|g" $1
$sedcmd "s|REPLACE_PROJECT_1_REPO|$RESUME_PROJECT_1_REPO|g" $1

$sedcmd "s/REPLACE_PROJECT_2_NAME/$RESUME_PROJECT_2_NAME/g" $1
$sedcmd "s|REPLACE_PROJECT_2_URL|$RESUME_PROJECT_2_URL|g" $1
$sedcmd "s|REPLACE_PROJECT_2_REPO|$RESUME_PROJECT_2_REPO|g" $1

$sedcmd "s/REPLACE_PROJECT_3_NAME/$RESUME_PROJECT_3_NAME/g" $1
$sedcmd "s|REPLACE_PROJECT_3_URL|$RESUME_PROJECT_3_URL|g" $1
$sedcmd "s|REPLACE_PROJECT_3_REPO|$RESUME_PROJECT_3_REPO|g" $1

# Add "\newpage" in the line before each heading 1
if [ "$CI" = "true" ]; then
    sed -i $'s/^# /\\\n\\\newpage\\\n\\\n# /g' $1
else
    sed -i '' $'s/^# /\\\n\\\newpage\\\n\\\n# /g' $1
fi
