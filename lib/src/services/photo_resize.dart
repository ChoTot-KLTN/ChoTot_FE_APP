// import 'dart:io';
// import 'dart:math';
// import 'dart:typed_data';
// import 'dart:ui';

// class PhotoHelper {
//   Future<File?> reduceSize(String pathImage, {int quality = 80}) async {
//     if (isNeedFormat(pathImage)) {
//       UtilLogger.log('BEFORE REDUCE', getFileSize(pathImage));
//       var path = await PathHelper.tempDir;
//       CompressObject compressObject = CompressObject(
//         imageFile: File(pathImage), //image
//         path: path.path, //compress to path
//         quality: quality, //first compress quality, default 80
//         step: 9, //compress quality step, The bigger the fast, Smaller is more accurate, default 6
//         mode: CompressMode.LARGE2SMALL, //default AUTO
//       );

//       String? compressedPath = await Luban.compressImage(compressObject);
//       if (compressedPath != null) {
//         UtilLogger.log('AFTER REDUCE', getFileSize(compressedPath));
//         return File(compressedPath);
//       }

//       return null;
//     }

//     return File(pathImage);
//   }

//   String getFileSize(String path) {
//     var file = File(path);
//     int bytes = file.lengthSync();
//     if (bytes <= 0) return "0 B";
//     const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
//     var i = (log(bytes) / log(1024)).floor();
//     return ((bytes / pow(1024, i)).toStringAsFixed(2)) + ' ' + suffixes[i];
//   }

//   bool isNeedFormat(String path) {
//     var file = File(path);
//     int bytes = file.lengthSync();
//     if (bytes <= 0) return false;
//     var i = (log(bytes) / log(1024)).floor();
//     var size = bytes / pow(1024, i);
//     if (i < 1) {
//       if (i == 1 && size > 100) {
//         return false;
//       }

//       return true;
//     }
//     return true;
//   }

//   Future<File> cropImageDataWithDartLibrary({required ExtendedImageEditorState state}) async {
//     final Rect? cropRect = state.getCropRect();

//     Uint8List data = state.rawImageData;
//     final EditActionDetails? editAction = state.editAction;

//     Image? src = decodeImage(data);
//     src = copyCrop(src!, cropRect!.left.toInt(), cropRect.top.toInt(), cropRect.width.toInt(),
//         cropRect.height.toInt());
//     if (editAction!.hasRotateAngle) {
//       src = copyRotate(src, editAction.rotateAngle);
//     }
//     src = bakeOrientation(src);
//     src = copyResize(src, width: 1280);
//     // return data;
//     Uint8List buffer = encodeJpg(src) as Uint8List;
//     Directory path = await PathHelper.tempDir;

//     return File(path.path + '/crop-temp-image.jpg').writeAsBytes(buffer);
//   }
// }