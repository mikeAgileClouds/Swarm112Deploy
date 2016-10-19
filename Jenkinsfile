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
    
    stage "Upload Application Bundle"
    dir("${env.DEVPROJCOMPOSEDIR}") {
        sh "curl -u admin:73admin79 -X PUT http://169.55.59.106:8080/artifactory/ext-release-local/${env.JOB_NAME}.dab -T ${env.JOB_NAME}.dab"
    }
    
    stage "Download Application Bundle"
    dir("${env.DEVPROJCOMPOSEDIR}") {
        sh "curl -u admin:73admin79 -X PUT http://169.55.59.106:8080/artifactory/ext-release-local/${env.JOB_NAME}.dab -o ${env.JOB_NAME}.dab"
    }

    stage "Deploy Docker App Bundle"
    dir("${env.DEVPROJCOMPOSEDIR}") {
        sh "docker stack deploy ${env.JOB_NAME}" // deploy create as well as update stack - ?Does note seem to be working?
    }
    
    stage "Configure Service updates for end users - External ports, volumes/networks, access control"
    dir("${env.DEVPROJCOMPOSEDIR}") {
        sh "polyglot-deploy.sh ${env.JOB_NAME}"
    }
    
    stage "Publish Swarm Node and Service details"
    dir("${env.DEVPROJCOMPOSEDIR}") {
        sh "docker node ls"
        sh "docker service ls"
    }
}
