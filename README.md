# backchannel

Build the container (it will have gstreamer in it).

    docker build -t backchannel .

Once build run the container

    docker run -e RTSP_URL="rtsp://xxx:554" --name back -t backchannel

In a seperate terminal exec in the container.

    docker exec -it back bash

In the session run the gstreamer session. 

    gst-launch-1.0 audiotestsrc freq=300 ! audioconvert ! audioresample ! audio/x-raw,rate=8000 ! mulawenc ! rtppcmupay ! udpsink host=127.0.0.1 port=9000

You 'll see the main program receiving packets, but nothing is pushed through the backchannel. 

Without the container build the backchannel does work properly.