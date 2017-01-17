node {

  stage('Build') {
    checkout scm
    def app = docker.build "twelvelabs/curl:${env.BUILD_TAG}"
  }

}
