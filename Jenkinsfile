pipeline {
    environment {
        PROJECT_CICD="cicd"
        PROJECT_DEV="kirom-hadiyanto-dev"
        APP_NAME_DEV = "hello-world"
        GIT_REPO1="git@github.com:vohanks354/hello-world.git"
        GIT_BRANCH="master"
        GIT_CRED1="githubkirom"
        TEMPLATE_NAME_DEV="drc-cms-template"
        YAML_FILE_DEV="django-drc-cms.yaml"
    }

    agent any

    stages{
        stage('Get Latest Code') {
            steps {
                script {
                    try {
                        git branch: "${GIT_BRANCH}", url: "${GIT_REPO1}", credentialsId: "${GIT_CRED1}"
                    } catch (Exception e) {
                        sh "echo ${e}"
                    }
                }
            }
        }
        stage("Authentication Credential") {
            steps {
                script{
                    sh "oc login --token=sha256~ot7lZT6s5mBwv3cjYVdZhY-asJIBp19ZvdkAPEs7_Zs --server=https://api.sandbox-m2.ll9k.p1.openshiftapps.com:6443"
                    sh "oc project ${PROJECT_DEV}"
                }
            }
        }
        stage('Cleanup') {
            steps {
                script {
                    try {
                        sh "oc delete all -l app=${APP_NAME_DEV}"
                    } catch (Exception e) {
                        sh "echo ${e}"
                    }
                }
            }
        }
        stage('Build Config') {
            steps {
                script {
                    try {
                        sh "oc create -f yaml/buildconfig.yaml"
                    } catch (Exception e) {
                        sh "echo ${e}"
                    }
                }
            }
        }
        stage('Build Imagestream') {
            steps {
                script {
                    try {
                        sh "oc create -f yaml/imagestream.yaml"
                    } catch (Exception e) {
                        sh "echo ${e}"
                    }
                }
            }
        }
        stage('Build Application') {
            steps {
                script {
                    try {
                        sh "oc start-build ${APP_NAME_DEV} --from-dir=./ --follow"
                    } catch (Exception e) {
                        sh "echo ${e}"
                    }
                }
            }
        }
        stage('Build Deployment') {
            steps {
                script {
                    try {
                        sh "oc create -f yaml/deployment.yaml"
                    } catch (Exception e) {
                        sh "echo ${e}"
                    }
                }
            }
        }
        stage('Build Service') {
            steps {
                script {
                    try {
                        sh "oc create -f yaml/service.yaml"
                    } catch (Exception e) {
                        sh "echo ${e}"
                    }
                }
            }
        }
        stage('Build Route') {
            steps {
                script {
                    try {
                        sh "oc create -f yaml/route.yaml"
                    } catch (Exception e) {
                        sh "echo ${e}"
                    }
                }
            }
        }
    }
    post { 
        success { 
            echo 'Mission complete'
        }
        failure { 
            echo 'Mission failure'
        }
    }
}