pipeline {
  agent {
    node {
      label 'jslave'
    }

  }
  stages {
    stage('Create Repository') {
      steps {
        deleteDir()
        script {
          try {
            sh '''
            /opt/jenkins/github/createRepo.sh
            /opt/jenkins/github/addCollab.sh $GithubUser $RepoName
            '''
            currentBuild.result = 'SUCCESS'
          } catch (Exception err) {
            currentBuild.result = 'FAILURE'
          }
          echo "RESULT: ${currentBuild.result}"
        }

      }
    }
  }
  environment {
    github_username = 'pajrioktara'
    github_token = credentials('addRepoCollaborator')
    github_api = 'https://api.github.com/user/repos'
    github_api_collab = 'https://api.github.com/repos'
  }
  options {
    skipDefaultCheckout(true)
  }
  parameters {
    string(defaultValue: '', description: 'Repository Name', name: 'RepoName')
    choice(choices: ['pajri'], description: 'Github user list', name: 'GithubUser')
  }
}
