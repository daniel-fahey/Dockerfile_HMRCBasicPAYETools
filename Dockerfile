FROM debian:bookworm-20240423-slim

ARG PAYETOOLS_VERSION="24.1.24086.542"

RUN apt-get update \
    && apt-get install -y curl unzip \
    && cd /root/ \
    && curl -LO https://www.gov.uk/government/uploads/uploaded/hmrc/payetools-rti-${PAYETOOLS_VERSION}-linux.zip \
    && unzip payetools-rti-${PAYETOOLS_VERSION}-linux.zip \
    && /root/payetools-rti-${PAYETOOLS_VERSION}-linux --mode unattended \
    && rm /root/payetools-rti-${PAYETOOLS_VERSION}-linux /root/payetools-rti-${PAYETOOLS_VERSION}-linux.zip \
    && apt-get autoremove -y curl unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y   libfontconfig1 libglib2.0-0 libsm6 libxrender1 \
                            libxext6 libxt6 libgstreamer-plugins-base1.0-0 \
                            libsqlite3-0 libgl1-mesa-glx xvfb \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd -g users -m paye_user
USER paye_user

EXPOSE 46729

ENTRYPOINT ["/usr/bin/stdbuf", "-oL", "/usr/bin/xvfb-run", "--auto-servernum", "/opt/HMRC/payetools-rti/rti.linux"]
