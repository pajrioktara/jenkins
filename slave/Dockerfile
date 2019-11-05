FROM berrywira16/alpine-oracle8

LABEL maintainer "berry.wirattama@gmail.com"

RUN apk add --no-cache bash openssh-client openssh-server-pam jq git curl nodejs=10.14.2-r0 npm=10.14.2-r0 yarn=1.12.3-r0 docker python3 unzip && \
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" && \
    python3 get-pip.py && \
    unzip awscli-bundle.zip && \
    python3 ./awscli-bundle/install -i /usr/local/aws -b /usr/bin/aws && \
    rm get-pip.py && rm awscli-bundle.zip && rm -r awscli-bundle && \
    sed -i 's|session         required        pam_motd.so|session         optional        pam_motd.so|g' /etc/pam.d/base-session && \
    mkdir -p /var/run/sshd && \
    yes | ssh-keygen -A && \
    curl -L -o /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x /usr/bin/kubectl && \
    kubectl version --client

ADD rootfs/id_rsa.pub /root/.ssh/authorized_keys
ADD rootfs/config /root/.ssh/config
ADD rootfs/sshd_config /etc/ssh/sshd_config

RUN chmod 600 /root/.ssh/authorized_keys && \
    chmod 600 /root/.ssh/config

VOLUME /opt/jenkins/

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
