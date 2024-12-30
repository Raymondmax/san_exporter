FROM centos/python-36-centos7

COPY . /san-exporter

WORKDIR /san-exporter

USER root

# Need to upgrade pip due to package cryptography - the requeriment of paramiko
#   link: https://github.com/Azure/azure-cli/issues/16858
RUN yum update -y && sudo yum install -y \
    python3 \
    python3-pip \
    ca-certificates \
    openssl && \
    update-ca-trust

# Install Python dependencies
RUN pip install --no-cache-dir --trusted-host pypi.python.org -r requirements.txt

ENTRYPOINT [ "python" ]

CMD [ "manage.py" ]
