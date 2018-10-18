FROM nextcloud

RUN apt-get update && \
    apt-get install -y aria2 wget && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/log/aria2c && \
    mkdir -p /var/local/aria2c && \
    echo '' > /var/log/aria2c/aria2c.log && \
    echo '*/1 * * * * chown -R www-data:www-data /var/www/html/data/*/files/Downloads/' > /var/spool/cron/crontabs/www-data && \
    echo '' > /var/local/aria2c/aria2c.sess && \
    chown www-data.www-data -R /var/log/aria2c /var/local/aria2c && \
    chmod 770 -R /var/log/aria2c /var/local/aria2c && \
    echo '*/15 * * * * php -f /var/www/html/cron.php' >> /var/spool/cron/crontabs/www-data

RUN wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/1.7/gosu-amd64" && \
    chmod +x /usr/local/bin/gosu && \
    gosu nobody true

 CMD ["sh", "-c", "gosu www-data aria2c --enable-rpc --rpc-allow-origin-all -c -D --log=/var/log/aria2c/aria2c.log --check-certificate=false --save-session=/var/local/aria2c/aria2c.sess --save-session-interval=2 --continue=true --input-file=/var/local/aria2c/aria2c.sess --rpc-save-upload-metadata=true --force-save=true --log-level=warn;apache2-foreground"]
