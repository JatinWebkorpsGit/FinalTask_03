pipeline {
    agent any
    environment {
        SONAR_HOME = tool "Sonar"
    }

    stages {
        stage('Clone from GitHub') {
            steps {
                git url: 'https://github.com/JatinWebkorpsGit/FriendBook.git', branch: 'main'
            }
        }

        stage('Build Application') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('SonarQube Quality Analysis') {
            steps {
                withSonarQubeEnv("Sonar") {
                    // Pass the compiled classes directory to Sonar
                    sh "$SONAR_HOME/bin/sonar-scanner -Dsonar.projectName=friendbook -Dsonar.projectKey=friendbook -Dsonar.java.binaries=target/classes"
                }
            }
        }
        stage('Stop Previous Instance') {
            steps {
                sh '''
                pid=$(ps -ef | grep FriendBook | grep -v grep | awk '{print $2}')
                if [ -n "$pid" ]; then
                  kill -9 $pid
                fi
                '''
            }
        }

        stage('Run Spring Boot Application') {
            steps {
                sh 'nohup java -jar target/FriendBook-0.0.1-SNAPSHOT.jar > app.log 2>&1 &'
            }
        }
    }
}

