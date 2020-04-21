FROM eaas/eaas-base AS wildfly-build
WORKDIR /var/work
COPY galleon/provisioning.xml .
# install official galleon tool
ARG galleon_version='4.2.5.Final'
RUN curl -o galleon.zip --location https://github.com/wildfly/galleon/releases/download/${galleon_version}/galleon-${galleon_version}.zip
RUN unzip galleon.zip && mv galleon-${galleon_version} galleon
# provision wildfly application server
RUN mkdir wildfly && ./galleon/bin/galleon.sh provision provisioning.xml --dir=wildfly
COPY ./files/standalone.conf ./wildfly/bin/
RUN rm -rf ./wildfly/welcome-content/*
RUN chown -R bwfla:bwfla ./wildfly


FROM eaas/eaas-base
CMD ["/sbin/my_init"]
COPY --from=wildfly-build /var/work/wildfly/ /home/bwfla/bw-fla-server/
COPY files/service /etc/service/
