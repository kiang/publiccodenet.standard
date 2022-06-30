#!/usr/bin/env bash
set -e # halt script on error

# if PAGES_REPO_NWO is not set then default to publiccodenet/standard
# (jekyll defaults to "origin" if a remote of that name exists,
# which makes sense for a true fork, but not for most contributors)
if [ "_${PAGES_REPO_NWO}_" == "__" ]; then
export PAGES_REPO_NWO=publiccodenet/standard
fi

# Build the site
bundle exec jekyll build

# Check for broken links and missing alt tags:
# jekyll does not require extentions like HTML
# run only "ScriptCheck" and "ImageCheck"; skip "LinkCheck"
# set an extra long timout for test-servers with poor connectivity
# ignore request rate limit errors (HTTP 429)
# using the files in Jekylls build folder
bundle exec htmlproofer \
    --assume-extension \
    --disable-external \
    ./_site
