#!/bin/sh

# Stop updating file access time to improve performance.
mount -vuwo noatime /
