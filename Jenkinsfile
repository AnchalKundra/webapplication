pipeline {
    environment {
    registry = "anchalkundra/tomcat"
    registryCredential = 'dockerid'
    dockerImage = ''
  }
    agent any
    parameters {
        gitParameter(branch: '',
        branchFilter: '.*',
        defaultValue: 'master',
        description: 'enter the branch name',
        name: 'branch', quickFilterEnabled: false,
        selectedValue: 'NONE',
        sortMode: 'NONE',
        tagFilter: '*',
        type: 'PT_BRANCH')
    }
    stages {
        stage('checkout') {
            steps {
                checkout([$class: 'GitSCM',
                branches: [[name: '*/master']],
                extensions: [],
                userRemoteConfigs: [[credentialsId: 'Git_Creds',
                url: 'https://github.com/AnchalKundra/webapplication']]])
            }
			}
        stage('build') {
            steps{
              tool name: 'Java_home', type: 'jdk'
              tool name: 'Maven_home', type: 'maven'
              sh 'mvn clean install'
            }
        }
	 stage('Building image') {
      	    steps{
              script {
              	dockerImage = docker.build registry + ":$BUILD_NUMBER"
            }
          }
        }
	 stage('Push Image') {
            steps{
              script {
                docker.withRegistry( '', registryCredential ) {
                dockerImage.push()
              }
            }
         }
     }
}
}
