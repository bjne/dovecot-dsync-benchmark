FROM ubuntu:24.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends time rsync dovecot-core openssh-server

COPY --chmod=600 ssh/id_ed25519 /root/.ssh/
COPY --chmod=600 ssh/id_ed25519.pub /root/.ssh/authorized_keys
RUN sh -c '/bin/echo -e "Host *\n\tStrictHostKeyChecking no\n\tLogLevel ERROR" >/root/.ssh/config && chmod 400 /root/.ssh/config'

RUN mkdir /var/run/sshd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/\(.*pam_motd.so\)/#\1/g' /etc/pam.d/sshd
EXPOSE 22

# Start SSH server
CMD ["/usr/sbin/sshd", "-D"]
