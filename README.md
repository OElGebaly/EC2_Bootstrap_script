1- script is written in bash and to use the amazon CLI to start the instance
2- steps illustrated below to run the script:

# download both Leve

3- script will 1st create a security group in the required region , by default the 443 port is closed for inbound access as long as its not opened
4- when starting the EC2 instance , bootstrap script well be executed to apply the needed installs and configurations
5- when running the bootstrap script, will ask for SSL certifcate parameters
6-