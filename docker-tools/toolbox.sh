#!/bin/bash

docker run \
-it \
--rm \
--volume ~/.aws:/root/.aws:ro \
--volume ~/cloudresume/backend/:/root/backend/ \
--volume ~/cloudresume/frontend/:/root/frontend/ \
toolbox \
bash
