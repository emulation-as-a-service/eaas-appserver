FROM phusion/baseimage:0.11
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y --allow-unauthenticated \
		git build-essential

RUN git clone https://gitlab.com/emulation-as-a-service/experiments/fake-clock.git /fake-clock
RUN cd /fake-clock && make