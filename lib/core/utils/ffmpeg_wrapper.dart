import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:flutter_ffmpeg/statistics.dart';

final FlutterFFmpegConfig _flutterFFmpegConfig = new FlutterFFmpegConfig();
final FlutterFFmpeg _flutterFFmpeg = new FlutterFFmpeg();

void enableStatisticsCallback(StatisticsCallback? callback) {
  _flutterFFmpegConfig.enableStatisticsCallback(callback);
}

Future<int> executeFFmpeg(String command) async {
  return await _flutterFFmpeg.execute(command);
}

Future<int> executeAsyncFFmpeg(
    String command, ExecuteCallback executeCallback) async {
  return await _flutterFFmpeg.executeAsync(command, executeCallback);
}

Future<String> getLastCommandOutput() async {
  return await _flutterFFmpegConfig.getLastCommandOutput();
}

Future<int> getLastReturnCode() async {
  return await _flutterFFmpegConfig.getLastReturnCode();
}

Future<Statistics> getLastReceivedStatistics() async {
  return await _flutterFFmpegConfig.getLastReceivedStatistics();
}