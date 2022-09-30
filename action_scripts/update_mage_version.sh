#!/usr/bin/env bash
# This script downloads the latest version number from xmage.de
# updates the VERSION file when it has changed
# and creates a tag for the Version

mage_version=$(curl --silent --show-error http://xmage.de/xmage/config.json | jq --raw-output '.XMage.version' |  cut -d " " -f1)
echo $mage_version

# At least try to check if it looks like a version number
[[ $mage_version =~ ^[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+[[:digit:]_[:alnum:]]*$ ]] && echo "Looks like a version number" || exit 1 "Dont think this is a Version number"

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
  git tag -a ${mage_version} -m "XMage Release Version ${mage_version}" && \
  git push origin master && \
  git push origin ${mage_version} && \
  echo "\o/"
else
  echo "nothing new"
fi
