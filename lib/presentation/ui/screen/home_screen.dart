import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_visualizer/presentation/bloc/music/music_bloc.dart';
import 'package:music_visualizer/presentation/ui/widgets/player_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState(){
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_){
      context.read<MusicBloc>().add(const FetchMusic());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFF7D56FF),
            Color(0xFF447FFF),
          ]),
        ),
        child: BlocBuilder<MusicBloc, MusicState>(builder: (contex, state){
          switch(state){
            case MusicStateInitial():
              return const SizedBox.shrink();
            case MusicStateLoading():
              return const CircularProgressIndicator();
            case MusicStateLoaded(file: File file):
              return PlayerWidget(file: file,);
            case MusicStateError(ex: var _):
              return const Text("Error!");
          }
        })
      )
    );
  }
}