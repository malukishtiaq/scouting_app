@echo off
REM Filter out Android MediaCodec/video system logs (Windows)
REM Usage: scripts\filter_logs.bat

adb logcat | findstr /V /C:"CCodec" /C:"BufferQueueProducer" /C:"MediaCodec" /C:"CCodecBuffers" /C:"CCodecConfig" /C:"CCodecBufferChannel" /C:"Codec2Client" /C:"ReflectedParamUpdater" /C:"AudioTrack" /C:"PipelineWatcher" /C:"SurfaceUtils"

