#!/bin/sh
 
set -e
set -x

# THE CONFIG
# if no source folder
if [ -z "$INPUT_SOURCE_FOLDER" ]
then
  # then fail
  echo "Source folder must be defined"
  return 1
fi
#if no shared name
if [ -z "$INPUT_SHARED_NAME" ]
then
  #if no shared folder
  if [ -z "$INPUT_SHARED_FOLDER" ]
  then
    # then shared name is "shared"
    INPUT_SHARED_NAME="shared"
  else
    # otherwise shared name is the same as the shared folder name
    INPUT_SHARED_NAME="$INPUT_SHARED_FOLDER"
  fi
fi
#if no git server
if [ -z "$INPUT_GIT_SERVER" ]
then
  # then use github
  INPUT_GIT_SERVER="github.com"
fi
#if no commit message
if [ -z "$INPUT_COMMIT_MESSAGE" ]
then
  # then use default 
  INPUT_COMMIT_MESSAGE="Update from https://$INPUT_GIT_SERVER/${GITHUB_REPOSITORY}/commit/${GITHUB_SHA}"
fi
#if no destination branch
if [ -z "$INPUT_DESTINATION_BRANCH" ]
then
  # then destination branch is main
  INPUT_DESTINATION_BRANCH="main"
fi
OUTPUT_BRANCH="$INPUT_DESTINATION_BRANCH"

# THE JOB
#make a temp folder (this is the target repo)
CLONE_DIR=$(mktemp -d)
#clone target repo to the temp folder
echo "Cloning destination git repository"
git config --global user.email "$INPUT_USER_EMAIL"
git config --global user.name "$INPUT_USER_NAME"
git clone --single-branch --branch $INPUT_DESTINATION_BRANCH "https://x-access-token:$API_TOKEN_GITHUB@$INPUT_GIT_SERVER/$INPUT_DESTINATION_REPO.git" "$CLONE_DIR"

echo "Copying contents to git repo"
#rm all contents of the target folder
rm -rf "$CLONE_DIR"/*
#if no shared folder
if [ -z "$INPUT_SHARED_FOLDER" ]
then
  # skip the else
  echo "Skipping shared folder"
else
  # then copy the shared folder to the target folder
  cp -R "$INPUT_SHARED_FOLDER" "$CLONE_DIR/$INPUT_SHARED_NAME" 
fi
#go into the source folder 
cd "$INPUT_SOURCE_FOLDER"
for fileder in * 
do 
  # and copy the root files and folders from 
  # the source folder to the target directory
  cp -R "$fileder" "$CLONE_DIR"
done
#go into the target folder
cd "$CLONE_DIR"
#if there is a destination branch
if [ ! -z "$INPUT_DESTINATION_BRANCH_CREATE" ]
then
  # then switch to that branch
  echo "Creating new branch: ${INPUT_DESTINATION_BRANCH_CREATE}"
  git checkout -b "$INPUT_DESTINATION_BRANCH_CREATE"
  OUTPUT_BRANCH="$INPUT_DESTINATION_BRANCH_CREATE"
fi
#lastly commit and push
echo "Adding git commit"
git add .
if git status | grep -q "Changes to be committed"
then
  git commit --message "$INPUT_COMMIT_MESSAGE"
  echo "Pushing git commit"
  git push -u origin HEAD:"$OUTPUT_BRANCH"
else
  echo "No changes detected"
fi

#create PR stage -> main
# not working - ad :(
echo "Create PR stage to main"
if [[ "$INPUT_DESTINATION_BRANCH" == "stage" ]]
then
  hub --version
fi
