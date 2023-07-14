# Start from Node.js ready container 
FROM node:20
# Install java
RUN apt-get update
RUN apt-get install -y default-jre-headless
# Install git
RUN apt-get update && apt-get install -y git
# Clone Connector Architecture repository
RUN git -C /opt clone https://github.com/TREEcg/connector-architecture.git pipeline
# Setup working folder
WORKDIR /opt/pipeline
RUN git submodule update --init --recursive
RUN cd processor/file-utils-processors-ts && npm install && npm run build
RUN cd processor/rml-mapper-processor-ts && npm install && npm run build
RUN cd processor/sds-processors && npm install && npm run build
RUN cd processor/sds-storage-writer-mongo && npm install && npm run build
RUN cd runner/js-runner && npm install && npm run build
COPY . .
# Setup container's entrypoint command
ENTRYPOINT [ "node", "--experimental-specifier-resolution=node", "runner/js-runner/bin/js-runner.js" ]
