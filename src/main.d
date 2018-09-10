module dithermark_video.main;

import std.stdio;
import std.range;
import std.array;
import std.file;

import dithermark_video.image;

int main(string[] args){
    File inputFile;
    
    if(isInputFromPipe()){
        inputFile = stdin;
    }
    else{
        if(!areArgumentsValid(args)){
            return printUsage(args[0]);
        }
        string inputFileName = args[1];
        
        if(!exists(inputFileName)){
            writef("%s does not exist\n", inputFileName);
            return 1;
        }
        if(!isFile(inputFileName)){
            writef("%s is not a file\n", inputFileName);
            return 1;
        }
        inputFile.open(inputFileName);
    }
    
    processFrame(inputFile);
    
    return 0;
}

//cross platform compatible version of isatty,
//just returns false on Windows
bool isInputFromPipe(){
    version(Windows){
        return false;
    }
    else{
        import core.sys.posix.unistd;
        return isatty(stdin.fileno) == 0;
    }
}

bool areArgumentsValid(string[] args){
    return args.length == 2;
}

int printUsage(string programName){
    stderr.writef("usage: %s <input_filename.ppm>\n", programName);
    return 1;
}


//have to convert range into string array, or dimensions somehow get messed up
string[] parseHeaderRange(Range)(Range header){
    string[] ret = new string[3];
    int index = 0;
    foreach(line; header){
        ret[index] = line.dup;
        index++;
    }
    return ret;
}

// int calculateHeaderLength(string[] header){
//     int length = 0;
//     foreach(s; header){
//         length += s.length;
//     }

//     return length;
// }

void processFrame(File file){
    auto range = file.byLine();

    string[] header = parseHeaderRange(range.take(3));
    Image image = imageFromPpmHeader(header);

    ubyte[] imageData = new ubyte[image.width * image.height * 3];
    file.rawRead(imageData);
    image.data = imageData;
}