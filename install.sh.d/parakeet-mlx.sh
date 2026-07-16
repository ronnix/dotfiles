#!/bin/bash -e
# DEPENDS: uv ffmpeg

# MLX runs on Apple Silicon only, so skip Intel Macs and Linux entirely:
# the package installs there but fails at runtime.
if [ "$(uname -s)" == "Darwin" ] && [ "$(uname -m)" == "arm64" ]; then
    if ! uv tool list | grep -q '^parakeet-mlx ' ; then
        uv tool install parakeet-mlx
    fi
fi
