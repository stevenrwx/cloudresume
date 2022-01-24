#!/bin/bash

docker run \
-it \
--rm \
--volume ~/.aws:/root/.aws:ro \
toolbox \
bash
