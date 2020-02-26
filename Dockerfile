FROM tutum/lamp

MAINTAINER aracloud <aracloud@gmx.net>

# version changed from v1.9 to master
ENV VERSION 1.9

RUN rm -rf /app && \
    apt-get update && \
    apt-get install -y wget php5-gd && \
    rm -rf /var/lib/apt/lists/*

COPY conf/* /tmp/

# IMPORTANT NOTE !!!
# /mysql-setup.sh is being defined in /create_mysql_admin_user.sh
# to initiate the DVWA DB therefor the script is beeing renamed

RUN wget https://github.com/ethicalhack3r/DVWA/archive/v${VERSION}.tar.gz && \
    tar xvf /v${VERSION}.tar.gz && \
    mv -f /DVWA-${VERSION} /app && \
    rm /app/.htaccess && \
    mv /tmp/.htaccess /app && \
    mv /tmp/login.php /app && \
    chmod +x /tmp/myStartupScript.sh && \
    mv /tmp/myStartupScript.sh /mysql-setup.sh && \
    chmod +x /tmp/setup_dvwa.sh && \
    /tmp/setup_dvwa.sh && \
    mv /tmp/create_mysql_admin_user.sh / && \
    chmod +x create_mysql_admin_user.sh

CMD ["/run.sh"]

