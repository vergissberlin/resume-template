#!/usr/bin/env sh

################################################################################
echo "👉\tFilter characters in \"$1\""


################################################################################
## Environment specific replacements commands
################################################################################

if [ "$CI" = "true" ]; then
	sedcmd="sed -i"
else
	sedcmd="sed -i ''"
fi


################################################################################
## Replacers
################################################################################


# Remove header navigation
$sedcmd 's/>\ \[Introduction\].*//g' $1

# Remove name from title
$sedcmd 's/–\ .*//g' $1

# Remove badges
$sedcmd '/\[\!\[PDF\ Download/d' $1

# Remove download link
$sedcmd 's/## Download//g' $1
$sedcmd 's/\-\ .*\ \[PDF\ CV//g' $1

# Remove top links from headers
$sedcmd 's/\[\[↑\]\(\#.*\)\]\ //g' $1

# Remove top links from headers
$sedcmd 's/\#\-/#/g' $1

# Remove crosses from headers
$sedcmd 's/\[x\]\ //g' $1
$sedcmd 's/\[\ \]\ //g' $1

# Remove double empty lines
$sedcmd '/^$/N;/^\n$/D' $1

# Remove unsupported characters
$sedcmd 's/↗//g' $1
$sedcmd 's/⚠️ //g' $1
