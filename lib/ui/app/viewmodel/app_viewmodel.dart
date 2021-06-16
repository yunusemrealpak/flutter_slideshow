import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_ffmpeg/completed_ffmpeg_execution.dart';
import 'package:flutter_ffmpeg/statistics.dart';
import 'package:flutter_slideshow/core/base/base_viewmodel.dart';
import 'package:flutter_slideshow/core/enum/notification_type_enum.dart';
import 'package:flutter_slideshow/core/enum/view_state.dart';
import 'package:flutter_slideshow/core/extensions/context_extensions.dart';
import 'package:flutter_slideshow/core/navigation/navigation_constants.dart';
import 'package:flutter_slideshow/core/utils/video_util.dart';
import 'package:flutter_slideshow/entities/image.dart';
import 'package:images_picker/images_picker.dart';
import '../../../core/utils/ffmpeg_wrapper.dart';
import 'package:path_provider/path_provider.dart';

class AppViewModel extends BaseViewModel {
  List<GalleryImage> images = [];
  int maxImagesCount = 10;
  Statistics? _statistics;
  
  String loaderText = "";
  
  bool flagTransitionAnimation = false;

  init() {
    enableStatisticsCallback(statisticsCallback);
  }

  void statisticsCallback(Statistics statistics) {
    this._statistics = statistics;
    updateProgressDialog();
  }

  void updateProgressDialog() {
    var statistics = this._statistics;
    if (statistics == null) {
      return;
    }

    int timeInMilliseconds = statistics.time;
    if (timeInMilliseconds > 0) {
      int totalVideoDuration = images.length*3*1000;

      int completePercentage = (timeInMilliseconds * 100) ~/ totalVideoDuration;

      loaderText = "Video Hazırlanıyor % $completePercentage";
      saveChanges();
    }
  }

  void addPictures() async {
    List<Media>? res = await ImagesPicker.pick(
      language: Language.English,
      count: 10,
      pickType: PickType.image,
    );

    if (res != null){
      res.forEach((element) {
        if(images.length==10) {
          showNotification(NotificationType.ERROR, "En fazla 10 fotoğraf seçebilirsiniz");
          return;
        }
        images.add(GalleryImage(path: element.path));
      });
    }
    saveChanges();
  }
  
  void removeImage(GalleryImage image) {
    images.removeWhere((element) => element.id == image.id);
    saveChanges();
  }
  
  void changeAnimation(bool? val){
    flagTransitionAnimation = val!;
    saveChanges();
  }

  void convertVideo() async {
    if (images.length < 3) {
      showNotification(NotificationType.ERROR, "En az 3 fotoğraf seçmelisiniz");
      return;
    }
    
    setState(ViewState.Busy);

    testPostExecutionCommands();

    final String video = "video6.mp4";
    Directory documentsDirectory = await VideoUtil.documentsDirectory;
    var videoFilePath = File("${documentsDirectory.path}/$video");
    
    var imagePaths = images.map((e) => e.path).toList();

    var videoCodec = "mpeg4";
    var command = VideoUtil.generateEncodeVideoScript(
        imagePaths: imagePaths,
        customOptions: "",
        videoFilePath: videoFilePath.path,
        videoCodec: videoCodec,
        height: context!.height,
        flagAnimation: flagTransitionAnimation);
        
    executeAsyncFFmpeg(command, (CompletedFFmpegExecution execution) {
      setState(ViewState.Idle);
      clearFlags();
      if (execution.returnCode == 0) {
        print("Encode completed successfully; playing video.");
        playVideo(videoFilePath.path);
      } else {
        print("Encode failed with rc=${execution.returnCode}.");
      }
    }).then((executionId) {
      print("Async FFmpeg process started with arguments '$command' and executionId $executionId.");
    });
  }

  static void testPostExecutionCommands() {
    getLastCommandOutput().then((output) => print("Last command output: $output"));
    getLastReturnCode().then((returnCode) => print("Last return code: $returnCode"));
    getLastReceivedStatistics()
        .then((statistics) => print("Last received statistics: executionId: ${statistics.executionId}, "
            "video frame number: ${statistics.videoFrameNumber}, video fps: ${statistics.videoFps}, "
            "video quality: ${statistics.videoQuality}, size: ${statistics.size}, time: ${statistics.time}, "
            "bitrate: ${statistics.bitrate}, speed: ${statistics.speed}"));
  }
  
  clearFlags(){
    loaderText = "";
    saveChanges();
  }

  playVideo(String videoPath) {
    nvgSrv.navigateTo(Routes.VIDEO_PLAYER, arguments: videoPath);
  }

  
}
