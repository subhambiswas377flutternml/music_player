enum EndPoints{
  getAudio,
}

extension EndpointsExtension on EndPoints{
  String val(){
    switch(this){
      case EndPoints.getAudio:
        // return "https://codeskulptor-demos.commondatastorage.googleapis.com/descent/background%20music.mp3";
        return "https://download.samplelib.com/mp3/sample-3s.mp3";
    }
  }
}