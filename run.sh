#!/bin/bash

# docker build -t qualifire-rp:latest .  # deprecated - we now use caddy:latest

helm install qfrp-release-1 qualifire-reverse-proxy-chart/
