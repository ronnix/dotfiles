#!/bin/bash -e
# DEPENDS: git

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions gitlab-runner >/dev/null; then
        brew install gitlab-runner
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    if ! dpkg -s gitlab-runner >/dev/null 2>&1; then
        # Official GitLab apt repository (not available in the Debian/Ubuntu archives)
        curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh" | sudo bash
        sudo apt-get install -y gitlab-runner
    fi
fi
