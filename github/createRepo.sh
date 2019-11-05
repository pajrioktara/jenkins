#!/bin/bash

function sendAlert(){
    curl -X POST --data-urlencode \
    "payload={\"channel\": \"${slack_channel}\", \"username\": \"${slack_user}\", \"icon_emoji\": \":jenkins:\", \
    \"attachments\": [ { \"color\": \"${color}\", \"pretext\": \"Github Job Status\", \
    \"text\": \"${text}\" } ] }" ${slack_hook}
}

getRepoName=$(curl -u "$github_username:$github_token" -s ${github_api}?per_page=1000 | jq -r ".[] | select(.name == \"$RepoName\") | .name")

if [[ ! -z $getRepoName ]] && [[ "$getRepoName" == "$RepoName" ]]
then
    getRepoUrl=$(curl -u "$github_username:$github_token" -s ${github_api}?per_page=1000 | jq -r ".[] | select(.name == \"$RepoName\") | .html_url")
    color="good"
    text="Repository has been added, uri : $getRepoUrl"
    sendAlert
else

    echo -n "Creating Github repository $RepoName ..."

    repo_status=$(curl -s -o /dev/null -w "%{http_code}" -u "$github_username:$github_token" ${github_api} -d "{\"name\":\"$RepoName\", \"private\": true}")

    if [[ $repo_status -ge 200 ]] && [[ $repo_status -le 299 ]]
    then
      getRepoUrl=$(curl -u "$github_username:$github_token" -s ${github_api}?per_page=1000 | jq -r ".[] | select(.name == \"$RepoName\") | .html_url")
      color="good"
      text="Repository has been added, uri : $getRepoUrl"
      sendAlert
      echo " Done."
    else
      echo " Fail"
      color="danger"
      text="Fail to create repository $RepoName"
      sendAlert
      exit 1
    fi
fi
