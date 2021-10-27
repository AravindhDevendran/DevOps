pipeline {
agent {
  label 'slave'
}
 environment {
  DOCKER = credentials ('dockerhub')
registry = "aravindhdeva5/devopsproj1" 
        registryCredential = 'dockerhub'
 }
 stages {
  stage ('create docker image') {
   steps {
    sh 'sudo docker build -t aravindhdeva5/devopsproj1:1111.$BUILD_NUMBER .'
   }
  }
  stage ('upload image to docker registry') {
   steps {
     sh '''
           sudo docker login --username $DOCKER_USR --password $DOCKER_PSW
           sudo docker push aravindhdeva5/devopsproj1:1111.$BUILD_NUMBER
        '''
   }   
  }
  stage ('Run Docker Container and global service') {
   steps {
    sh '''
        sudo docker run -d aravindhdeva5/devopsproj1:1111.$BUILD_NUMBER
	sudo docker swarm -f leave
	sudo docker swarm init
	sudo docker service create --name devopsproj1 --mode global -d -p 9000:80 aravindhdeva5/devopsproj1:1111.$BUILD_NUMBER
	'''
   }
  }
  stage ('update kubernetes deployment') {
   steps {
    sh '''
    	  sudo apt install -y kubelet kubeadm kubectl
	  sudo kubectl set image deployment devopsproj1 container=aravindhdeva5/devopsproj1:1111.$BUILD_NUMBER --record'
	'''
   }
  }
 }
}
