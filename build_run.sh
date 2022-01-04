imgName=devnet-apache2
contName=devnet-apache2-cont


echo "************ building devnet-apache2 docker image *********"
docker build -t $imgName .

echo "************ Running my-apache2 docker image  *********"
docker run -dit --name $contName -p 8081:8081 devnet-apache2
docker ps
