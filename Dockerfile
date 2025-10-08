FROM public.ecr.aws/lambda/provided:al2
WORKDIR /var/task
COPY build/cluster-mgmt-poc-1.0.0-SNAPSHOT-runner bootstrap
RUN chmod +x bootstrap
CMD ["bootstrap"]

