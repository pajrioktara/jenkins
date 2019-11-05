#!/bin/bash

collaborator="$1"
repoName="$2"

for nameCollaborator in $collaborator
do
    echo "add $nameCollaborator"
    curl -s -i -u $github_username:$github_token -X PUT ${github_api_collab}/${github_username}/${repoName}/collaborators/$nameCollaborator > /dev/null
done
