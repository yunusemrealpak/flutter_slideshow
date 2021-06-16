import 'dart:io';

import 'package:path_provider/path_provider.dart';

class VideoUtil {
  static Future<Directory> get documentsDirectory async {
    return await getApplicationDocumentsDirectory();
  }

  static String generateEncodeVideoScript({
    required List<String?> imagePaths,
    required String videoFilePath,
    required String videoCodec,
    required String customOptions,
    required double height,
    required bool flagAnimation,
  }) {
    var h = height.toInt();
    var w = h * 0.5625;

    var str = "";
    var complexStr = "";
    var stremStartStr = "";
    var streamOutStr = "";
    var concatStr = "";
    var concatCount = (2 * (imagePaths.length)) - 1;

    imagePaths.forEach((element) {
      var index = imagePaths.indexOf(element);
      var isFirst = index == 0;
      var isLast = index == imagePaths.length - 1;

      str += "-loop 1 -i \"" + element! + "\" ";
      complexStr +=
          "[$index:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,$w/$h),min(iw,$w),-1)':h='if(gte(iw/ih,$w/$h),-1,min(ih,$h))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,split=2[stream${index + 1}out1][stream${index + 1}out2];";
      if (!isFirst)
        stremStartStr +=
            "[stream${index + 1}starting][stream${index}ending]blend=all_expr='${flagAnimation ? 'if(gte(X,(W/2)*T/1)*lte(X,W-(W/2)*T/1),B,A)' : 'if(gte(X,W*T/1)*lte(X,W*T/1),B,A)'}':shortest=1[stream${index + 1}blended];";

      if (isFirst) {
        concatStr += "[stream1overlaid]";
        streamOutStr +=
            "[stream1out1]pad=width=$w:height=$h:x=($w-iw)/2:y=($h-ih)/2:color=#00000000,trim=duration=3,select=lte(n\\,90)[stream1overlaid];" +
                "[stream1out2]pad=width=$w:height=$h:x=($w-iw)/2:y=($h-ih)/2:color=#00000000,trim=duration=1,select=lte(n\\,30)[stream1ending];";
      } else if (isLast) {
        concatStr += "[stream${index + 1}blended][stream${index + 1}overlaid]";
        streamOutStr +=
            "[stream${index + 1}out1]pad=width=$w:height=$h:x=($w-iw)/2:y=($h-ih)/2:color=#00000000,trim=duration=2,select=lte(n\\,60)[stream${index + 1}overlaid];" +
                "[stream${index + 1}out2]pad=width=$w:height=$h:x=($w-iw)/2:y=($h-ih)/2:color=#00000000,trim=duration=1,select=lte(n\\,30)[stream${index + 1}starting];";
      } else {
        concatStr += "[stream${index + 1}blended][stream${index + 1}overlaid]";
        streamOutStr +=
            "[stream${index + 1}out1]pad=width=$w:height=$h:x=($w-iw)/2:y=($h-ih)/2:color=#00000000,trim=duration=2,select=lte(n\\,60)[stream${index + 1}overlaid];" +
                "[stream${index + 1}out2]pad=width=$w:height=$h:x=($w-iw)/2:y=($h-ih)/2:color=#00000000,trim=duration=1,select=lte(n\\,30),split=2[stream${index + 1}starting][stream${index + 1}ending];";
      }
    });

    return "-hide_banner -y " +
        str +
        "-filter_complex " +
        "\"" +
        complexStr +
        streamOutStr +
        stremStartStr +
        concatStr +
        "concat=n=$concatCount:v=1:a=0,scale=w=$w:h=$h,format=yuv420p[video]\"" +
        " -map [video] -vsync 2 -async 1 " +
        customOptions +
        " -vb 50M " +
        "-r 30 "+
        videoFilePath;
  }
}
