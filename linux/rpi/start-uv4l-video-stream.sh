
# start the uv4l driver to stream the raspiberry pi cam

sudo uv4l \
	-nopreview \
	--auto-video_nr \
	--driver raspicam \
	--encoding mj peg  \
	--width 1280  \
	--height 960 \
	--framerate 25 \
	--server-option '--port=9090' \
	--server-option '--max-queued-connections=10' \
	--server-option '--max-streams=15' \
	--server-option '--max-threads=20'
