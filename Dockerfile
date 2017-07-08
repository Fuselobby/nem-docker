# This is a comment
FROM fedora:25
MAINTAINER rb2
RUN dnf -y install java-1.8.0-openjdk-headless.x86_64 tar tmux gnupg.x86_64 supervisor procps jq
RUN dnf -y upgrade nss
RUN curl -L http://bob.nem.ninja/nis-ncc-0.6.91.tgz > nis-ncc-0.6.91.tgz

#RUN curl http://bob.nem.ninja/nis-ncc-0.6.91.tgz.sig > nis-ncc-0.6.91.tgz.sig
#RUN gpg --keyserver keys.gnupg.net --recv-key A46494A9
#RUN gpg --verify nis-ncc-0.6.91.tgz.sig nis-ncc-0.6.91.tgz

<<<<<<< HEAD


# New signature scheme, not always published
RUN sha=$(curl -L -s http://bigalice3.nem.ninja:7890/transaction/get?hash=$(curl -L -s  http://bob.nem.ninja/nis-ncc-0.6.91.tgz.sig | grep txId | sed -e 's/txId: //') | jq -r '.transaction.message.payload[10:74]') && \
    echo "$sha nis-ncc-0.6.91.tgz"  > /tmp/sum && \
    sha256sum -c /tmp/sum

RUN tar xf nis-ncc-0.6.91.tgz

RUN useradd nem
RUN mkdir -p /home/nem/nem/ncc/
RUN mkdir -p /home/nem/nem/nis/
RUN chown nem /home/nem/nem -R
COPY ./container_scripts/supervisord.conf /etc/
EXPOSE 7890
EXPOSE 8989
CMD ["/usr/bin/supervisord"]
