#!/usr/bin/env bash
# This script downloads the latest beta version number from xmage.today
# updates the VERSION file when it has changed
# and creates a tag for the Version

mage_version=$(curl --silent --show-error http://xmage.today/config.json | jq --raw-output '.XMage.version' | sed 's/ /_/g' | sed 's/[\(\)]//g')
echo $mage_version

# At least try to check if it looks like a version number
if [[ $mage_version =~ ^[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+-dev_.*$ ]]; then
  echo "Looks like a version number"
else
  echo "Dont think this is a Version number"
  exit 1 
fi

# Set mage version for other actions
echo "MAGE_VERSION=$mage_version" >> $GITHUB_ENV

# Update VERSION file
echo $mage_version > XMAGE_VERSION

if [[ `git status --porcelain --untracked-files=no` ]]; then
  echo "Yeah!! Looks like we got an update"
  git config user.name "GitHub Actions Bot" && \
  git config user.email "<>" && \
  git add XMAGE_VERSION && \
  git commit -m "update xmage version to ${mage_version}" && \
  git tag -a ${mage_version} -m "XMage Beta Version ${mage_version}" && \
  git push origin main && \
  git push origin ${mage_version} && \
  echo "\o/"
else
  echo "nothing new"
fi
