## uncomment as adequate

### after the ushahidi container starts this commands needs to be run, to substitute
## the install script
#docker cp run-after-install.sh platformrelease_ushahidi_1:/run.sh

## for the ssl certificate
docker exec -it platformrelease_ushahidi_1 certbot -d mapa.rutasdelamemoria.org

### restore database and migrate to a new version
#docker cp /tmp/ushahidi.sql platformrelease_mysql_1:/tmp
#docker exec  platformrelease_mysql_1 mysql -u root -e "drop database ushahidi ;"
#docker exec  platformrelease_mysql_1 mysql -u root -e "create database ushahidi ;"
#docker exec  platformrelease_mysql_1 mysql -u root ushahidi < /tmp/ushahidi.sql
#docker exec -it -w /var/www/html/platform/ platformrelease_ushahidi_1 php artisan migrate

## copy backup files
## media-zip is a zip copy of the media folder in older ushahidi versions
### here is an example of a media.zip archive stored in tmp
### modify if necessary

#docker cp  /tmp/media.zip platformrelease_ushahidi_1:/tmp
#docker exec -it -w /tmp platformrelease_ushahidi_1  unzip media.zip
#docker exec -it -w / platformrelease_ushahidi_1 rsync -av /tmp/media/uploads/  /var/www/html/platform/storage/app/public
