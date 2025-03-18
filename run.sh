#!/bin/bash

docker build -t qualifire-rp:latest .
helm install qfrp-release-1 qfrp-chart/
