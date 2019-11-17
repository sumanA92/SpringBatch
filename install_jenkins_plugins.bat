echo off

java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin parameterized-trigger < plugins.txt