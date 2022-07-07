#!/usr/bin/env python3
import os
import time
import sys
from pathlib import Path
import shlex
import subprocess

processes = list()
published = list()

ffmpeg_path = list(Path('.').glob('ffmpeg-*/ffmpeg'))[0]

try:
    os.environ['RTSP_RTSPADDRESS'] = '0.0.0.0:8554'
    processes.append(subprocess.Popen('./rtsp-simple-server'))

    has_videos = False
    # only H264 is supported
    for video in Path('videos/').glob('*.mp4'):
        has_videos = True
        url = f'rtsp://localhost:8554/{video.name}'
        published.append(url)
        cmd = f'{ffmpeg_path} -re -stream_loop -1 -i {video} -c copy -f rtsp {url}'
        print(cmd)
        processes.append(subprocess.Popen(shlex.split(cmd), stdout=subprocess.DEVNULL, stderr=subprocess.STDOUT))

    if not has_videos:
        sys.exit('No videos found, exiting')

    print(f'Now serving {len(published)} files:\n')
    for p in published:
        print(f'\t {p}')

    while True:
        time.sleep(1)

except KeyboardInterrupt:
    for p in processes:
        print(f'Terminate {p}')
        p.terminate()
