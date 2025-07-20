FROM node:18

RUN npm install -g elasticdump \
 && curl -O https://dl.min.io/client/mc/release/linux-amd64/mc \
 && chmod +x mc && mv mc /usr/local/bin/mc

WORKDIR /dumps

COPY export-and-upload.sh /elasticdump/export-and-upload.sh
RUN chmod +x /elasticdump/export-and-upload.sh

CMD ["/bin/bash", "/elasticdump/export-and-upload.sh"]

