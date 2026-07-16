#!/bin/bash -e
# DEPENDS: uv ffmpeg

# MLX runs on Apple Silicon only, so skip Intel Macs and Linux entirely:
# the package installs there but fails at runtime.
if [ "$(uname -s)" == "Darwin" ] && [ "$(uname -m)" == "arm64" ]; then
    if ! uv tool list | grep -q '^mlx-whisper ' ; then
        uv tool install mlx-whisper
    fi
fi
