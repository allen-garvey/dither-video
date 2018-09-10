module dithermark_video.image;

import std.conv;
import std.string;
import std.stdio;
import std.uni : isWhite;

struct Image{
    int width;
    int height;
    ubyte[] data;
}


Image imageFromPpmHeader(string[] header)
in{
    assert(header.length == 3);
    assert(header[0] == "P6");
    assert(header[2] == "255");
}
do{
    Image image;

    string[] dimensions = header[1].chomp().split!isWhite;
    
    image.width = to!int(dimensions[0]);
    image.height = to!int(dimensions[1]);
    
    return image;
}