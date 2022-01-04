imgName=devnet-apache2
contName=devnet-apache2-cont

echo "************ Get default httpd.conf file"
docker run --rm httpd:2.4 cat /usr/local/apache2/conf/httpd.conf > my-httpd.conf
echo "************ Editing default conf file to listen 8081 port NOT 80"
sed -i 's/Listen 80/Listen 8081/g' my-httpd.conf

echo "************ Get default httpd-vhosts.conf file" 
docker run --rm httpd:2.4 cat /usr/local/apache2/conf/extra/httpd-vhosts.conf > my-httpd-vhosts.conf
echo "************ Editing default my-httpd-vhosts.conf file "
sed -i 's/<VirtualHost \*:80>$/<VirtualHost \*:8081>/g' my-httpd-vhosts.conf


echo "************ Preparing the dockerfile *********"
echo "FROM httpd:2.4" > dockerfile
echo "COPY ./my-httpd.conf /usr/local/apache2/conf/httpd.conf" >> dockerfile
echo "COPY ./my-httpd-vhosts.conf /usr/local/apache2/conf/extra/httpd-vhosts.conf" >> dockerfile
echo "COPY ./static-html/ /usr/local/apache2/htdocs/" >> dockerfile
echo "EXPOSE 8081" >> dockerfile

echo "************ Clearing existing images and containers for a fresh start"
docker stop $contName || true
docker rm $contName || true
docker rmi $imgName || true

