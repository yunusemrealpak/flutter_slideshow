import 'package:uuid/uuid.dart';

class GalleryImage {
  String? id;
  String? path;
  
  GalleryImage({this.path}){
    var uuid = Uuid();
    id = uuid.v1(); 
  }
}