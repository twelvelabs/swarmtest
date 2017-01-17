node {

  stage('Build') {
    checkout scm
    sh "docker build -t twelvelabs/curl:0.0.${env.BUILD_NUMBER} ."
  }

  stage('Test') {
    echo "lol, tests"
  }

  stage('Publish') {
    sh "docker tag twelvelabs/curl:0.0.${env.BUILD_NUMBER} twelvelabs/curl:latest"
    //sh "docker push twelvelabs/curl:0.0.${env.BUILD_NUMBER}"
    //sh "docker push twelvelabs/curl:latest"
  }

  stage('Deploy') {
    sh "DOCKER_IMAGE_TAG=0.0.${env.BUILD_NUMBER} docker stack deploy -c docker-compose.yml curl"
  }

}
