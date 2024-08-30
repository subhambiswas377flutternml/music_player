import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_visualizer/presentation/bloc/amplitude/amplitude_bloc.dart';
import 'package:music_visualizer/presentation/bloc/music/music_bloc.dart';
import 'package:music_visualizer/presentation/ui/screen/home_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget{
  const App({super.key});

  @override
  Widget build(BuildContext context){
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: <BlocProvider>[
            BlocProvider<MusicBloc>(create: (_)=> MusicBloc()..add(const InitMusic())),
            BlocProvider<AmplitudeBloc>(create: (_)=> AmplitudeBloc()),
          ],
          child: const MaterialApp(
            home: HomeScreen(),
          ),
        );
      }
    );
  }
}