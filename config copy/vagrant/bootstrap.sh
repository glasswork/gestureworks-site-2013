# Install mysql and set the root password to 'password'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password password' 
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password password'
sudo apt-get -y install mysql-server

# Install Apache & PHP
sudo apt-get install -y apache2 php5 libapache2-mod-php5 php5-mcrypt php5-mysql

# Create a vhost file for wordpress
cat >/etc/apache2/sites-available/wordpress.conf <<EOL
<VirtualHost *:80>
  DocumentRoot /var/www
  <Directory /var/www>
    Options Indexes FollowSymLinks MultiViews
    AllowOverride All
    RewriteEngine On
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteRule ^ index.php [QSA,L]
  </Directory>
</VirtualHost>
EOL

# Enable our host file and restart apache
sudo a2enmod rewrite
sudo a2dissite 000-default.conf
sudo a2ensite wordpress.conf
sudo service apache2 restart

# Create a mysql user and database
mysql -uroot -ppassword -e "CREATE DATABASE wordpress;"
mysql -uroot -ppassword -e "CREATE USER 'wordpress'@'localhost' IDENTIFIED BY 'password';"
mysql -uroot -ppassword -e "GRANT ALL PRIVILEGES ON *.* TO 'wordpress'@'localhost';"
mysql -uroot -ppassword -e "FLUSH PRIVILEGES;"

# Seed the database
# Disabled as there is currently no seed data
# mysql -u root -p<your_database_password> <your_database_name> < /var/www/config/vagrant/database_seed.sql

