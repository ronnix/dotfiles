#!/bin/bash -e
# DEPENDS: brew curl

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions trivy >/dev/null; then
        brew install trivy
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    if ! dpkg -s trivy >/dev/null 2>&1; then
        curl -fsSL https://aquasecurity.github.io/trivy-repo/deb/public.key |
            sudo gpg --dearmor --yes --output /usr/share/keyrings/trivy.gpg
        echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb generic main" |
            sudo tee /etc/apt/sources.list.d/trivy.list >/dev/null
        sudo apt-get update
        sudo apt-get install --yes trivy
    fi
fi
