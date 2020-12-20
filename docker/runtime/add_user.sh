#!/usr/bin/env bash

echo "Begin add group in image, id=${DOCKER_GRP_ID} name=${DOCKER_GRP}"
addgroup --gid "$DOCKER_GRP_ID" "$DOCKER_GRP"
echo "Add group in image success"

echo "Begin add user in image, id=${DOCKER_USER} name=${DOCKER_USER_ID}"
adduser --disabled-password --force-badname --gecos '' "$DOCKER_USER" \
    --uid "$DOCKER_USER_ID" --gid "$DOCKER_GRP_ID" 2>/dev/null
echo "Add user in image success"

usermod -aG sudo "$DOCKER_USER"
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
cp -r /etc/skel/. /home/${DOCKER_USER}

# Set user files ownership to current user, such as .bashrc, .profile, etc.
chown ${DOCKER_USER}:${DOCKER_GRP} /home/${DOCKER_USER}
ls -ad /home/${DOCKER_USER}/.??* | xargs chown -R ${DOCKER_USER}:${DOCKER_GRP}