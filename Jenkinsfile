node {

  stage('Build') {
    checkout scm
    sh "docker build -t swarmtest:0.0.${env.BUILD_NUMBER} ."
  }

  stage('Test') {
    echo "lol, tests"
  }

  stage('Publish') {
    sh "docker tag swarmtest:0.0.${env.BUILD_NUMBER} twelvelabs/curl:latest"
    //sh "docker push swarmtest:0.0.${env.BUILD_NUMBER}"
    //sh "docker push swarmtest:latest"
  }

  stage('Deploy') {
    sh "DOCKER_IMAGE_TAG=0.0.${env.BUILD_NUMBER} docker stack deploy -c docker-compose.yml swarmtest"
  }

}
