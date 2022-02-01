FROM python:3-alpine

Copy . /toolbox

WORKDIR /root/
RUN mkdir bin/

#Update
RUN apk update
RUN apk add --no-cache bash curl git openssh-client jq ansible vim
RUN pip install boto3

#Install Terraform
RUN wget https://releases.hashicorp.com/terraform/1.1.4/terraform_1.1.4_linux_arm64.zip \
&& unzip terraform_1.1.4_linux_arm64.zip && rm terraform_1.1.4_linux_arm64.zip \
&& mv terraform /usr/bin/terraform

#Install AWS cli
RUN curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" \
-o "awscli-bundle.zip" \
&& unzip awscli-bundle.zip \
&& ./awscli-bundle/install -i /root/bin/aws -b /bin/aws \
&& rm -fr awscli-bundle*
