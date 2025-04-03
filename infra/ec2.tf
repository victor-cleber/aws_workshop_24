resource "aws_instance" "app_server" {
  ami                         = "ami-0f9de6e2d2f067fca" #poc1-ubuntu22.04
  subnet_id                   = aws_subnet.alb_subnet_a.id
  instance_type               = "t2.micro"
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  associate_public_ip_address = true
  
  security_groups             = [aws_security_group.alb_security_group.id]
  user_data                   = <<EOF
        # sudo su
        # yes | apt update
        # yes | apt upgrade
        # yes | apt install apache2
        # yes | apt install -y php8.1-cli php8.1-common php8.1-mysql php8.1-zip php8.1-gd php8.1-mbstring php8.1-curl php8.1-xml php8.1-bcmath
        # yes | apt install apache2 git libapache2-mod-php8.1
        # yes | apt install mysql-client        
        #Setup default zone

        #  yes |apt install curl php-cli php-mbstring unzip
        # cd /tmp  //Back home directory

        # //Download composer installer
        # php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"

        # //Generating hash value for composer installer.
        # HASH="$(wget -q -O - https://composer.github.io/installer.sig)"

        # //Verifying hash key and installer
        # php -r "if (hash_file('SHA384', 'composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"

        # //Installing composer
        # yes | php composer-setup.php --install-dir=/usr/local/bin --filename=composer

        # //If suppose, you have any permission issue with composer file, assign by this
        # chmod +x /usr/local/bin/composer

        # composer  //check version

        # cd /tmp
        # git clone https://github.com/victor-cleber/aws_workshop_24.git
        # sudo mv /tmp/aws_workshop_24/app /var/www/html

        # echo "<h1>Server Details</h1><p><strong>Hostname: </strong> $(hostname)</p><p><strong>IP Address: </strong> $(hostname -I | cut -d " " -f1)</p>" > /var/www/html/index.html
        # systemctl restart apache2         

      EOF
  root_block_device {
    volume_type           = "gp3"
    delete_on_termination = true
  }
  tags = {
    Name = var.jh_server
  }
  depends_on = [aws_security_group.alb_security_group]
}