imgName=devnet-apache2
contName=devnet-apache2-cont


echo "************ Clearing existing images and containers for a fresh start"
docker stop $contName || true
docker rm $contName || true
docker rmi $imgName || true

