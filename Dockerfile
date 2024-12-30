FROM centos/python-36-centos7

COPY . /san-exporter

WORKDIR /san-exporter

# Need to upgrade pip due to package cryptography - the requeriment of paramiko
#   link: https://github.com/Azure/azure-cli/issues/16858
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    && update-ca-certificates

# Install Python dependencies
RUN pip install --no-cache-dir --trusted-host pypi.python.org -r requirements.txt

USER root

ENTRYPOINT [ "python" ]

CMD [ "manage.py" ]
