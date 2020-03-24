if [ "$CERTBOT" = "1" ] 
then
    nginx -c /tmp/nginx-certbot.conf
    certbot certonly --non-interactive --agree-tos -m $CERTBOT_MAIL -d $CERTBOT_DOMAIN_1 -d $CERTBOT_DOMAIN_2 --webroot -w /var/www/certbot
    nginx -s stop
    sleep 5
fi
if [ ! -f /etc/letsencrypt/dhparam.pem ]; then
  mv /tmp/dhparam.pem /etc/letsencrypt/dhparam.pem
fi
if [ ! -f /etc/nginx/conf.d/default.conf ]; then
  echo "default.conf is already removed, nothing to do here..."
else
  rm /etc/nginx/conf.d/default.conf
  echo "default.conf removed"
fi
# if [ ! -f /tmp/odyslam.github.io-master/index.html ]; 
# then
#   echo "Nothing to delete & nothing to move. Move along!"
# else
#   mv /tmp/odyslam.github.io-master/* /usr/share/nginx/html/
#   echo "Moved website files to /usr/share/nginx/html/"
#   rm -rf /tmp/odyslam.github.io-master
#   echo "Deleted website /tmp/ files"
# fi
nginx -g 'daemon off;'