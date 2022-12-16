ARG os=8.7.20221112
ARG image=build
FROM aursu/rpmbuild:${os}-${image}

USER root
RUN dnf -y install \
        cmake \
        cyrus-sasl-devel \
        libevent-devel \
        memcached \
        openssl-devel \
        python3-sphinx \
        systemtap-sdt-devel \
    && dnf clean all && rm -rf /var/cache/dnf

COPY SOURCES ${BUILD_TOPDIR}/SOURCES
COPY SPECS ${BUILD_TOPDIR}/SPECS

RUN chown -R $BUILD_USER ${BUILD_TOPDIR}/{SOURCES,SPECS}

USER $BUILD_USER
ENTRYPOINT ["/usr/bin/rpmbuild", "libmemcached.spec"]
CMD ["-ba"]
