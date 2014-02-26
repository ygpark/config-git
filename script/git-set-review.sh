#!/bin/bash

HOST_INFO=$(git remote -v | grep fetch | awk '{print $2}' | sed 's/\/\w*$//' | sed 's/http:\/\/[^@][^@]*@/http:\/\//')

echo "curl -o .git/hooks/commit-msg $HOST_INFO/tools/hooks/commit-msg"
curl -o .git/hooks/commit-msg $HOST_INFO/tools/hooks/commit-msg
echo "chmod u+x .git/hooks/commit-msg"
chmod u+x .git/hooks/commit-msg

CURRENT_BRANCH=$(git branch | grep '^\*' | cut -d" " -f2)
NEW_PUSH_REF=HEAD:refs/for/$CURRENT_BRANCH

echo "git config remote.origin.push $NEW_PUSH_REF"
git config remote.origin.push $NEW_PUSH_REF
