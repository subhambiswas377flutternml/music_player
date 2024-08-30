extension ListSize<N extends num> on List<N> {
  List<double> reduceListSize({
    required int targetSize,
  }) {
    if (length > targetSize) {
      final finalList = <double>[];
      final chunk = length / targetSize;
      final iterationsCount = targetSize;
      for (int i = 0; i < iterationsCount; i++) {
        final part = skip((chunk * i).floor()).take(chunk.floor());
        final sum = part.fold<double>(
            0, (previousValue, element) => previousValue + element);
        final peak = sum / part.length;
        finalList.add(peak);
      }
      return finalList;
    } else {
      return map((e) => e.toDouble()).toList();
    }
  }
}