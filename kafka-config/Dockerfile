FROM openjdk:21-jdk-slim-buster

ENV KAFKA_VERSION="2.8.2"
ENV KAFKA_PACKAGE="kafka_2.13-2.8.2"
ENV AWS_MSK_IAM_AUTH="1.1.0"
ENV GLIBC_VER="2.33-r0"

RUN apt update && apt install -y wget tar bash jq binutils curl less groff unzip

RUN curl -sL https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip \
    && unzip awscliv2.zip \
    && aws/install \
    && rm -rf awscliv2.zip aws \
    && apt remove -y binutils curl \
    && rm -rf /var/lib/apt/lists/* \

# setup java truststore
RUN cp $JAVA_HOME/lib/security/cacerts /tmp/kafka.client.truststore.jks

# install kafka
RUN wget https://downloads.apache.org/kafka/$KAFKA_VERSION/$KAFKA_PACKAGE.tgz \
    && tar -xzf $KAFKA_PACKAGE.tgz \
    && rm -rf $KAFKA_PACKAGE.tgz

WORKDIR /$KAFKA_PACKAGE

# install aws-msk-iam-auth jar
RUN wget https://github.com/aws/aws-msk-iam-auth/releases/download/$AWS_MSK_IAM_AUTH/aws-msk-iam-auth-$AWS_MSK_IAM_AUTH-all.jar \
    && mv aws-msk-iam-auth-$AWS_MSK_IAM_AUTH-all.jar libs/

## copy client properties file(s)
#COPY client*.properties bin/

CMD ["/bin/sh", "-c", "tail -f /dev/null"]

ENTRYPOINT ["/bin/bash"]