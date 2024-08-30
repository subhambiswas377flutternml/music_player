enum EndPoints{
  getAudio,
}

extension EndpointsExtension on EndPoints{
  String val(){
    switch(this){
      case EndPoints.getAudio:
        // return "https://codeskulptor-demos.commondatastorage.googleapis.com/descent/background%20music.mp3";
        return "https://drive.usercontent.google.com/u/0/uc?id=1_9kF7atacEEzikCFTbfOnQTnVgLK93dy&export=download";
    }
  }
}