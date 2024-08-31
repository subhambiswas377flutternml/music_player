import 'dart:async';
import 'dart:io';

import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_visualizer/core/extensions/context_extension.dart';
import 'package:music_visualizer/presentation/bloc/amplitude/amplitude_bloc.dart';
import 'package:music_visualizer/presentation/ui/widgets/common_shimmer.dart';
import 'package:music_visualizer/presentation/ui/widgets/wave/wave_widget.dart';

class PlayerWidget extends StatefulWidget {
  final File file;
  const PlayerWidget({super.key,
  required this.file,
  });

  @override
  State<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> with SingleTickerProviderStateMixin{
  late final AudioPlayer audioPlayer;
  final ValueNotifier<bool> playNotifier = ValueNotifier<bool>(false);

  late final AnimationController animationController;
  late final Animation<double> animation;
  late final CurvedAnimation curvedAnimation;
  late final StreamSubscription playerCompletionSubscription;
  @override
  void initState(){
    super.initState();
    audioPlayer = AudioPlayer();
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    curvedAnimation = CurvedAnimation(parent: animationController,
    curve: Curves.bounceInOut,
    );
    animation = Tween<double>(begin: 1.0, end: 2.0).animate(animationController);

    playerCompletionSubscription = audioPlayer.playerStateStream.listen((state){
      playNotifier.value = false;
      _resetAudio();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async{
      _loadAmplitude();
    });
  }

  Future<Duration> _setAndGetDuration() async{
    final duration = await audioPlayer.setAudioSource(AudioSource.file(widget.file.path));
    if(duration==null){
      return const Duration(seconds: 0);
    }else{
      return duration;
    }
  }

  @override
  void dispose(){
    super.dispose();
    audioPlayer.dispose();
    playerCompletionSubscription.cancel();
    playNotifier.dispose();
  }

  void _loadAmplitude(){
    context.read<AmplitudeBloc>().add(ExtractAmplitude(file: widget.file));
  }

  void _playAudio(){
    audioPlayer.play();
    animationController.repeat(reverse: true);
  }

  void _pauseAudio(){
    // audioPlayer.pause();
    animationController.stop();
  }

  void _resetAudio(){
    // await audioPlayer.seek(Duration.zero);
    animationController.reset();
  }

  @override
  Widget build(BuildContext context) {
    final amplitudeState = context.watch<AmplitudeBloc>();
    return Container(
      height: context.screenHeightPercentage(25),
      width: context.screenWidth,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Card(
        elevation: 20,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            FutureBuilder(
              future: _setAndGetDuration(),
              builder: (context, futSnapshot) {
                if(futSnapshot.hasData){
                  return StreamBuilder(
                  stream: audioPlayer.positionStream ,
                  builder: (context, snapshot){
                    if(snapshot.hasData){
                      return Container(
                      width: (context.screenWidth-(20.w*2))*(snapshot.data!.inMicroseconds/futSnapshot.data!.inMicroseconds),
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Colors.black12,
                    ),
                    );
                    }else{
                      return const SizedBox.shrink();
                    }
                });
                }else{
                  return const SizedBox.shrink();
                }
              }
            ),
            Positioned(
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                  child: Row(children: [
                    ElevatedButton(
                      onPressed: amplitudeState.state.isLoaded? (){
                        if(!playNotifier.value){
                          _playAudio();
                          playNotifier.value = true;
                        }else{
                          _pauseAudio();
                          playNotifier.value = false;
                        }
                      }:null,
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        padding: const EdgeInsets.all(5),
                        backgroundColor: const Color(0xFF6767FF),
                        foregroundColor: Colors.white,
                        shape: const CircleBorder()
                      ),
                      child: ValueListenableBuilder(
                        valueListenable: playNotifier,
                        builder: (context, isPlaying, child){
                          return Icon(isPlaying?Icons.pause:Icons.play_arrow, size: 50.w,);
                        }),
                      ),
                      SizedBox(width: 10.w,),
                      BlocBuilder<AmplitudeBloc, AmplitudeState>(builder: (ctx, state){
                        switch(state){
                          case AmplitudeStateInitial():
                            return const SizedBox.shrink();
                          case AmplitudeStateExtracting():
                            return const Expanded(child: CommonPlaceHolder(cornerRadius: 10,));
                          case AmplitudeStateExtracted(data: var  data):
                            return Expanded(child: AnimatedBuilder(
                              animation: CurvedAnimation(parent: animationController, curve: Curves.bounceInOut,),
                              builder: (context, widget){
                                return WaveWidget(amplititudeData: data, amplifyFactor: animation.value);
                              },
                            ));
                          case AmplitudeStateError(ex: _):
                            return Expanded(
                                child: Center(
                                child: IconButton(
                                  onPressed: (){
                                    _loadAmplitude();
                                  },
                                  icon: const Icon(Icons.replay)),));
                        }
                      }),
                  ],),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}