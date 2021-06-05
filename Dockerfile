ARG centos=7.9.2009
FROM aursu/rpmbuild:${centos}-build

USER root
RUN yum -y install \
        cyrus-sasl-devel \
        libevent-devel \
        memcached \
        python-sphinx \
        systemtap-sdt-devel \
    && yum clean all && rm -rf /var/cache/yum

COPY SOURCES ${BUILD_TOPDIR}/SOURCES
COPY SPECS ${BUILD_TOPDIR}/SPECS

RUN chown -R $BUILD_USER ${BUILD_TOPDIR}/{SOURCES,SPECS}

USER $BUILD_USER
ENTRYPOINT ["/usr/bin/rpmbuild", "libmemcached.spec"]
CMD ["-ba"]
