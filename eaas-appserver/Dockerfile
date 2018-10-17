FROM eaas/eaas-base
CMD ["/sbin/my_init"]

#add appserver-wildfly-10.1.tgz /home/bwfla/
add appserver-wildfly-14.0.1.tgz /home/bwfla/
run mv /home/bwfla/appserver-wildfly-14.0.1/ /home/bwfla/bw-fla-server/
# Disable wildfly's security restrictions on management port when we run in Docker.
# This is not a problem, even if the management interface is bound to 0.0.0.0, because
# Docker won't expose this port automatically and we will only ever bind the management
# port to localhost, resulting in the same security as if we would run wildfly natively
# without Docker.
RUN sed -i 's/security-realm="ManagementRealm"//' /home/bwfla/bw-fla-server/standalone/configuration/standalone.xml
RUN chown -R bwfla:bwfla /home/bwfla/bw-fla-server

RUN rm -rf /home/bwfla/bw-fla-server/welcome-content/*
copy files/standalone.conf /home/bwfla/bw-fla-server/bin/
#ADD files/web/index.html /home/bwfla/bw-fla-server/welcome-content/

COPY files/service /etc/service/

