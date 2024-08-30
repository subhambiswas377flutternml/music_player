import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WaveWidget extends StatelessWidget {
  final List<double> amplititudeData;
  final Color waveformColor;
  final double amplifyFactor;

  const WaveWidget({
    super.key,
    required this.amplititudeData,
    required this.amplifyFactor,
    this.waveformColor = const Color(0xFF9EA0C6),
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint){
      return CustomPaint(
      size: Size(
        constraint.maxWidth,
        constraint.maxHeight,
        ),
      painter: CustomWave(amplititudeData: amplititudeData, waveformColor: waveformColor, amplifyFactor:amplifyFactor),
    );
    });
  }
}

class CustomWave extends CustomPainter {
  final List<double> amplititudeData;
  final Color waveformColor;
  final double amplifyFactor;

  CustomWave({
    required this.amplititudeData,
    required this.waveformColor,
    required this.amplifyFactor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = waveformColor
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    final spacing = size.width/amplititudeData.length;
    double dx = 0.0;
    final centerPoint = size.height/2;

    for(int i=0;i<amplititudeData.length;i++){
      canvas.drawLine(
        Offset(dx, centerPoint - (amplititudeData.elementAt(i)/2).h*amplifyFactor),
        Offset(dx, centerPoint + (amplititudeData.elementAt(i)/2).h*amplifyFactor),
        paint);

        dx+=spacing;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}