FROM sphinxdoc/sphinx-latexpdf:latest

LABEL "maintainer"="Ammar Askar <ammar@ammaraskar.com>"

ADD entrypoint.py /entrypoint.py
ADD sphinx_action /sphinx_action

ENTRYPOINT ["/entrypoint.py"]
