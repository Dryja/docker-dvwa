FROM tutum/lamp

MAINTAINER aracloud <aracloud@gmx.net>

ENV VERSION 1.9

RUN rm -rf /app && \
    apt-get update && \
    apt-get install -y wget php5-gd && \
    rm -rf /var/lib/apt/lists/*

COPY conf/* /tmp/

RUN wget https://github.com/ethicalhack3r/DVWA/archive/v${VERSION}.tar.gz && \
    tar xvf /v${VERSION}.tar.gz && \
    mv -f /DVWA-${VERSION} /app && \
    rm /app/.htaccess && \
    mv /tmp/.htaccess /app && \
    chmod +x /tmp/myStartupScript.sh && \
    chmod +x /tmp/setup_dvwa.sh && \
    /tmp/setup_dvwa.sh && \
    sleep 5 && \
    /tmp/myStartupScript.sh

# EXPOSE 80 3306

#CMD ["/run.sh && /tmp/myStartupScript.sh"]
CMD ["/run.sh"]

### ENTRYPOINT ["/tmp/myStartupScript.sh"]

