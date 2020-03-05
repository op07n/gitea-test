
FROM python:3.7
RUN pip3 install \
    jupyterhub \
    jhsingle-native-proxy>=0.0.9
    

RUN wget -O gitea https://dl.gitea.io/gitea/1.11.0/gitea-1.11.0-linux-amd64

RUN chmod +x gitea

RUN mv ./gitea /usr/bin/

# create a user, since we don't want to run as root
RUN useradd -m jovyan
ENV HOME=/home/jovyan
WORKDIR $HOME
USER jovyan

COPY --chown=jovyan:jovyan entrypoint.sh /home/jovyan

EXPOSE 8888

# ENTRYPOINT ["/home/jovyan/entrypoint.sh"]

CMD ["jhsingle-native-proxy", "--destport", "8505", "streamlit", "hello", "{--}server.port", "{port}", "{--}server.headless", "True", "{--}server.enableCORS", "False", "--port", "8888"]
