FROM centos/python-36-centos7

COPY . /san-exporter

WORKDIR /san-exporter

USER root

# Configure YUM repositories and update system
RUN yum clean all && \
    yum makecache fast && \
    sed -i 's|mirrorlist=|#mirrorlist=|g' /etc/yum.repos.d/CentOS-* && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-* && \
    yum-config-manager --add-repo=http://vault.centos.org/centos/7/os/x86_64/ && \
    yum-config-manager --add-repo=http://vault.centos.org/centos/7/updates/x86_64/ && \
    yum update -y && \
    yum install -y \
        python3 \
        python3-pip \
        ca-certificates \
        openssl && \
    update-ca-trust

# Install Python dependencies
RUN pip install --no-cache-dir --trusted-host pypi.python.org -r requirements.txt

ENTRYPOINT [ "python" ]

CMD [ "manage.py" ]
