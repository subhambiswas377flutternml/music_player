enum EndPoints{
  getAudio,
}

extension EndpointsExtension on EndPoints{
  String val(){
    switch(this){
      case EndPoints.getAudio:
        return "https://codeskulptor-demos.commondatastorage.googleapis.com/descent/background%20music.mp3";
    }
  }
}