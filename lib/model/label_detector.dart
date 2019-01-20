import 'dart:typed_data';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/foundation.dart';

@immutable
class LabelDetector {
  final _detector = FirebaseVision.instance.labelDetector();

  Future<List<Label>> detectImage(CameraImage image) async {
    return _detector.detectInImage(
      FirebaseVisionImage.fromBytes(
        _concatenatePlanes(image.planes),
        _buildMetaData(image),
      ),
    );
  }

  FirebaseVisionImageMetadata _buildMetaData(CameraImage image) {
    return FirebaseVisionImageMetadata(
      rawFormat: image.format.raw,
      size: Size(
        image.width.toDouble(),
        image.height.toDouble(),
      ),
      rotation: ImageRotation.rotation270,
      planeData: image.planes.map(
        (plane) {
          return FirebaseVisionImagePlaneMetadata(
            bytesPerRow: plane.bytesPerRow,
            height: plane.height,
            width: plane.width,
          );
        },
      ).toList(),
    );
  }

  Uint8List _concatenatePlanes(List<Plane> planes) {
    final allBytes = WriteBuffer();
    planes.forEach((plane) => allBytes.putUint8List(plane.bytes));
    return allBytes.done().buffer.asUint8List();
  }
}
