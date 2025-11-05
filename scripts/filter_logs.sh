#!/bin/bash
# Filter out Android MediaCodec/video system logs
# Usage: ./scripts/filter_logs.sh

adb logcat | grep -v -E "(CCodec|BufferQueueProducer|MediaCodec|CCodecBuffers|CCodecConfig|CCodecBufferChannel|Codec2Client|ReflectedParamUpdater|AudioTrack|PipelineWatcher|SurfaceUtils)"

