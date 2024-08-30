import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_visualizer/core/extensions/context_extension.dart';
import 'package:music_visualizer/presentation/bloc/amplitude/amplitude_bloc.dart';
import 'package:music_visualizer/presentation/ui/widgets/wave_widget.dart';

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

    playerCompletionSubscription = audioPlayer .onPlayerComplete.listen((event){
      playNotifier.value = false;
      _resetAudio();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async{
      context.read<AmplitudeBloc>().add(ExtractAmplitude(file: widget.file));
    });
  }

  Future<Duration> _setAndGetDuration() async{
    await audioPlayer.setSourceDeviceFile(widget.file.path);
    await audioPlayer.setReleaseMode(ReleaseMode.stop);
    return await audioPlayer.getDuration()?? const Duration(seconds: 1);
  }

  @override
  void dispose(){
    super.dispose();
    audioPlayer.dispose();
    playerCompletionSubscription.cancel();
  }

  Future<void> _playAudio() async{
    await audioPlayer.resume();
    animationController.repeat(reverse: true);
  }

  Future<void> _pauseAudio() async{
    await audioPlayer.pause();
    animationController.stop();
  }

  Future<void> _resetAudio() async{
    animationController.reset();
    await audioPlayer.seek(Duration.zero);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenHeightPercentage(25),
      width: context.screenWidth,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            FutureBuilder(
              future: _setAndGetDuration(),
              builder: (context, futSnapshot) {
                if(futSnapshot.hasData){
                  return StreamBuilder(
                  stream: audioPlayer.onPositionChanged,
                  builder: (context, snapshot){
                    if(snapshot.hasData){
                      return Container(
                      width: (context.screenWidth-(20.w*2))*(snapshot.data!.inMicroseconds/futSnapshot.data!.inMicroseconds),
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
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
                      onPressed: ()async{
                        if(!playNotifier.value){
                          await _playAudio();
                          playNotifier.value = true;
                        }else{
                          await _pauseAudio();
                          playNotifier.value = false;
                        }
                      },
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
                            return const CircularProgressIndicator();
                          case AmplitudeStateExtracted(data: var  data):
                            return Expanded(child: AnimatedBuilder(
                              animation: CurvedAnimation(parent: animationController, curve: Curves.bounceInOut,),
                              builder: (context, widget){
                                return WaveWidget(amplititudeData: data, amplifyFactor: animation.value);
                              },
                            ));
                          case AmplitudeStateError(ex: _):
                            return const SizedBox.shrink();
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