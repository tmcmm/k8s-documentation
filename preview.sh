#! /bin/bash

# Requirements: docker and toolkit setup with mkdocs configured

MKDOCS_SERVE_PORT=8888

echo "You can check mkdocs page in http://${HOSTNAME}:${MKDOCS_SERVE_PORT}/"

mkdocs serve -a 0.0.0.0:${MKDOCS_SERVE_PORT}
