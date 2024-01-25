FROM alpine:3.9.2
RUN sed -i "s|http://dl-cdn.alpinelinux.org|https://mirrors.aliyun.com|g" /etc/apk/repositories \
&& apk add gcc g++ make automake libpcap-dev
COPY qemu-aarch64-static /usr/bin
RUN chmod + x /usr/bin/qemu-aarch64-static
#ADD tcpdump-4.9.2.tar.gz /opt
WORKDIR /opt
RUN wget http://www.tcpdump.org/release/tcpdump-4.9.2.tar.gz \
    && tar -xvf tcpdump-4.9.2.tar.gz
RUN cd tcpdump-4.9.2 && CFLAGS=-static ./configure --without-crypto && make
RUN mv tcpdump-4.9.2/tcpdump /static-tcpdump  && rm -rf tcpdump-4.9.2 tcpdump-4.9.2.tar.gz