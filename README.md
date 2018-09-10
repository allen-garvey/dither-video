# dither-video

Tool to dither video using ffmpeg and D

## Dependencies

* ffmpeg
* Recent D compiler

## Getting Started

* Clone or download this repository
* `cd` into the project folder, and run `make`
* Create ppm file from video with `ffmpeg -ss 01:23:45 -i input -vframes 1 -q:v 2 output.ppm` [See here for more details](https://stackoverflow.com/questions/27568254/how-to-extract-1-screenshot-for-a-video-with-ffmpeg-at-a-given-time)
* Run `./bin/main output.ppm`

## Resources

* [Reading video frame by frame with ffmpeg](https://www.drmaciver.com/2010/12/reading-video-frame-by-frame-with-ffmpeg)
* [PPM file format specification](http://paulbourke.net/dataformats/ppm)

## License

dither-video is released under the MIT License. See license.txt for more details.