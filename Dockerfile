FROM hp2b/ts-utils:9.1.8.1

USER root:root
RUN mkdir /build

ADD UtilityJobs /build/
RUN chmod -R a+x /build

ADD build.sh /build/
RUN chmod +x /build/build.sh

WORKDIR /build/

ENTRYPOINT []
