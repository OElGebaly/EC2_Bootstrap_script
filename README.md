# script is written in bash and to use the amazon CLI to start the instance

# download both LaunchAWSinstance.sh & bootstrap.sh

1- LaunchAWSinstance.sh

- script will 1st create a security group in the required region , by default the 443 port is closed for inbound access as long as its not opened
- script will create a keypair file to be used for SSH access
- script will open SSH port 
- when starting the EC2 instance , bootstrap script well be executed to apply the needed installs and configurations

2 bootstrap .sh 

- update ubuntu OS
- download and install defualt JDK & JRE
- install nginx and allow acces for HTTPS
- Download hello.jar file
- create systemd service for the jar file
- configure Nginx and create SSL Certificate
- when creating SSL Certificate you will be asked for SSL certifacte parameters to be entered
- start and enable nginx service on port 443  

# How To Run

{code}
$ chmod 775 LaunchAWSinstance.sh bootstrap.sh 
$ ./LaunchAWSinstance.sh