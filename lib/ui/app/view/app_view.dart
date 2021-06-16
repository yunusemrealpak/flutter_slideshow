import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slideshow/core/base/base_loader.dart';
import 'package:flutter_slideshow/core/base/base_view.dart';
import 'package:flutter_slideshow/core/enum/view_state.dart';
import 'package:flutter_slideshow/core/extensions/context_extensions.dart';
import 'package:flutter_slideshow/ui/app/viewmodel/app_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<AppViewModel>(
      viewModel: AppViewModel(),
      onModelReady: (model) {
        model.init();
        model.setContext(context);
      },
      builder: (context, model, _) => BaseLoader(
        showLoader: model.state == ViewState.Busy,
        showTextArea: true,
        loaderText: model.loaderText,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Flutter SlideShow",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: model.addPictures,
                child: Container(
                  width: context.width,
                  margin: context.paddingNormal,
                  padding: context.paddingNormal,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: model.images.length == 0
                      ? Container(
                          height: context.customWidthValue(0.35),
                          child: Center(
                            child: Text("Fotoğraf seçimi için tıklayın..."),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              direction: Axis.horizontal,
                              runSpacing: 10,
                              children: model.images.map((image) {
                                var file = File(image.path!);
                                return Container(
                                  width: context.customWidthValue(0.17),
                                  height: context.customWidthValue(0.2),
                                  child: Stack(
                                    children: [
                                      Image.file(
                                        file,
                                        fit: BoxFit.cover,
                                      ),
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: InkWell(
                                            onTap: () => model.removeImage(image),
                                            child: Icon(Icons.remove_circle, color: Colors.red)),
                                      )
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(top: context.normalWidthValue),
                              child: Text(
                                "${model.images.length}/${model.maxImagesCount}",
                                style: TextStyle(
                                  fontSize: context.customWidthValue(0.028),
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: context.mediumWidthValue),
                    child: Text("Geçiş Animasyonu"),
                  ),
                  Checkbox(value: model.flagTransitionAnimation, onChanged: model.changeAnimation),
                ],
              ),
              OutlinedButton(
                onPressed: model.convertVideo,
                child: Text("Videoya Çevir"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
