FROM registry.access.redhat.com/ubi8/ubi-minimal

LABEL name="osa api server" \
      description="Probable Vulnerability API server" \
      email-ids="arajkuma@redhat.com" \
      git-url="https://github.com/kubesecurity/osa-api-server" \
      git-path="/" \
      target-file="Dockerfile" \
      app-license="GPL-3.0"


ENV LANG=en_US.UTF-8 \
    F8A_WORKER_VERSION=58d3025 \
    F8A_AUTH_VERSION=5211e23 \
    F8A_UTILS=3bca34e


COPY bayesian/ /app/bayesian/
ADD ./requirements.txt /app/

RUN microdnf install python3 npm git && pip3 install --upgrade pip &&\
    pip3 install -r /app/requirements.txt && rm /app/requirements.txt &&\
    npm install -g semver-ranger

RUN pip3 install git+https://github.com/fabric8-analytics/fabric8-analytics-worker.git@${F8A_WORKER_VERSION}
RUN pip3 install git+https://github.com/fabric8-analytics/fabric8-analytics-auth.git@${F8A_AUTH_VERSION}
RUN pip3 install git+https://github.com/fabric8-analytics/fabric8-analytics-version-comparator.git#egg=f8a_version_comparator
RUN pip3 install git+https://github.com/fabric8-analytics/fabric8-analytics-utils.git@${F8A_UTILS}

ADD scripts/entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh

ENTRYPOINT ["/bin/entrypoint.sh"]
