node ('swarm') {
    stage "Checkout Deployment Architecture and Operations Source"
    checkout scm
    // sh "git submodule update --init"
    
    stage "Checkout Developer Source Code"
    dir("${env.DEVPROJROOTDIR}") {
        git url: "${env.DEVPROJROOTURL}"
        sh "git submodule update --init"
        sh "git submodule update --force"
    }
    
    stage "Build Docker Images"
    dir("${env.DEVPROJCOMPOSEDIR}") {
        sh "docker-compose build" // build --pull is failing on some nodes
    }
    
    stage "Upload and Checkout Docker Images from register"
    dir("${env.DEVPROJCOMPOSEDIR}") {
        sh "docker login -u ${env.DOCKER_HUB_USER} -p ${env.DOCKER_HUB_PASSWORD}"
        sh "docker-compose push"
        sh "docker-compose pull"
    }
    
    stage "Create Application Bundle"
    dir("${env.DEVPROJCOMPOSEDIR}") {
        sh "docker-compose bundle -o ${env.JOB_NAME}.dab"
    }

    stage "Deploy Docker App Bundle"
    dir("${env.DEVPROJCOMPOSEDIR}") {
        sh "docker stack deploy ${env.JOB_NAME}" // deploy create as well as update stack - ?Does note seem to be working?
    }
    
    stage "Configure Service updates for end users - External ports, volumes/networks, access control"
    dir("${env.DEVPROJCOMPOSEDIR}") {
        sh "docker service  update --publish-add 7979:5000 ${env.JOB_NAME}_apigateway"
    }
    
    stage "Publish Swarm Node and Service details"
    dir("${env.DEVPROJCOMPOSEDIR}") {
        sh "docker node ls"
        sh "docker service ls"
    }
}
