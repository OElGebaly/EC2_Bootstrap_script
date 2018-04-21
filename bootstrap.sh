#!/bin/bash
# script used to perfrom bootstrap actions to apply necessary installations and configurations


sudo apt-get update -y
sudo apt-get install default-jre default-jdk
sudo apt-get install nginx
sudo ufw allow 'Nginx HTTPS'
#Download the Artifacts
wget https://s3.eu-central-1.amazonaws.com/leverton-dev-test/hello.jar --output-file /home/ubuntu/hello.jar

#create systemd service file
sudo touch /lib/systemd/system/hello.service
sudo echo "[Unit]
Description=Hello Jar Service
[Service]
ExecStart=java -jar  /home/ubuntu/hello.jar
Type=simple
User=ubuntu
[Install]
WantedBy=multi-user.target" >> /lib/systemd/system/hello.service
sudo systemctl daemon-reload

#create SSL certificate for Nginx

sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx.key -out /etc/ssl/certs/nginx.crt
sudo touch /etc/nginx/snippets/SSL_Cert.conf
echo "ssl_certificate /etc/ssl/certs/nginx.crt;
ssl_certificate_key /etc/ssl/private/nginx.key;" >> /etc/nginx/snippets/SSL_Cert.conf

#configure Nginx
sudo /etc/nginx/conf.d/hello.conf
sudo echo "server {
        listen 443;
        listen [::]:443;
	    include snippets/SSL_Cert.conf


        location / {
             proxy_pass http://localhost:443/;
             proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
             proxy_set_header X-Forwarded-Proto $scheme;
             proxy_set_header X-Forwarded-Port $server_port;
        }
}
" >> /etc/nginx/conf.d/hello.conf

#Restart Nginx
sudo systemctl start nginx
sudo systemctl enable nginx



