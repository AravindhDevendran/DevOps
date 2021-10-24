pipeline {
 agent any
 environment {
  DOCKER = credentials ('dockerhub')
 }
 stages {
  stage ('compile the application') {
   steps {
    sh 'mvn compile'
   }
  }
  stage ('Generate War package') {
   steps {
    sh 'mvn package'
   }
  }
  stage ('create docker image') {
   steps {
    sh 'sudo docker build -t devopsxprts/addressbook:20210928.$BUILD_NUMBER .'
   }
  }
  stage ('upload image to docker registry') {
   steps {
     sh '''
           sudo docker login --username $DOCKER_USR --password $DOCKER_PSW
           sudo docker push devopsxprts/addressbook:20210928.$BUILD_NUMBER
        '''
   }   
  }
  stage ('update kubernetes deployment') {
   steps {
    sh 'kubectl set image deployment addressbook container=devopsxprts/addressbook:20210928.$BUILD_NUMBER --record'
   }
  }
 }
}
