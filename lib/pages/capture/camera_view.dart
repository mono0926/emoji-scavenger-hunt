import 'dart:io';

import 'package:camera/camera.dart';
import 'package:emoji_scavenger_hunt/model/game_bloc_provider.dart';
import 'package:emoji_scavenger_hunt/util/util.dart';
import 'package:emoji_scavenger_hunt/widgets/app_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as imglib;
import 'package:path_provider/path_provider.dart';

class CameraView extends StatefulWidget {
  @override
  CameraViewState createState() {
    return new CameraViewState();
  }
}

enum CameraPreparationState {
  initializing,
  notAvailable,
  prepared,
}

class CameraViewState extends State<CameraView> {
  CameraController _controller;
  var _isCapturing = false;
  var _state = CameraPreparationState.initializing;

  @override
  void initState() {
    super.initState();

    initializeCameraController();

    final bloc = GameBlocProvider.of(context);
    bloc.correct.listen((_) async {
      if (_isCapturing) {
        return;
      }
      _isCapturing = true;
      final path = await _takePicture();
      _isCapturing = false;
      logger.info('picture saved path: $path');
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Found ${bloc.emoji.value.character} !')));
    });
  }

  void initializeCameraController() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      setState(() {
        _state = CameraPreparationState.notAvailable;
      });
      return;
    }
    _controller = CameraController(
      cameras[0],
      ResolutionPreset.medium,
    );
    await _controller.initialize();
    await _controller.startImageStream((image) async {
      _detectIfCan(image);
    });
    setState(() {
      _state = CameraPreparationState.prepared;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_state) {
      case CameraPreparationState.initializing:
        return const AppProgressIndicator();
      case CameraPreparationState.notAvailable:
        return Center(
          child: Text(
            'Camera not available ☹',
            style: Theme.of(context).textTheme.display1,
          ),
        );
      case CameraPreparationState.prepared:
        return Container(
          child: OverflowBox(
            maxWidth: double.infinity,
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: CameraPreview(_controller),
            ),
          ),
        );
    }
    assert(false);
    return null;
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<String> _takePicture() async {
    final dir = await getTemporaryDirectory();
    final dirPath = '${dir.path}/pictures/detected';
    await new Directory(dirPath).create(recursive: true);
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final filePath = '$dirPath/$timestamp.jpg';
    await _controller.takePicture(filePath);
    return filePath;
  }

  void _detectIfCan(CameraImage image) async {
    final bloc = GameBlocProvider.of(context);
    bloc.detected.add(image);
  }

  Future<Image> _convertYUV420toImageColor(CameraImage image) async {
    final width = image.width;
    final height = image.height;
    final uvRowStride = image.planes[1].bytesPerRow;
    // MEMO: null(iPhone XS Plus)
    final uvPixelStride = image.planes[1].bytesPerPixel ?? 1;

    logger.fine('uvRowStride: $uvRowStride');
    logger.fine('uvPixelStride: $uvPixelStride');

    // imgLib -> Image package from https://pub.dartlang.org/packages/image
    final img = imglib.Image(width, height); // Create Image buffer

    // Fill image buffer with plane[0] from YUV420_888
    for (var x = 0; x < width; x++) {
      for (var y = 0; y < height; y++) {
        final uvIndex =
            uvPixelStride * (x / 2).floor() + uvRowStride * (y / 2).floor();
        final index = y * width + x;

        final yp = image.planes[0].bytes[index];
        final up = image.planes[1].bytes[uvIndex];
        // MEMO: image.planes' length is 2(iPhone XS Plus)
        final vp = image.planes.length > 2 ? image.planes[2].bytes[uvIndex] : 0;
        // Calculate pixel color
        final r = (yp + vp * 1436 / 1024 - 179).round().clamp(0, 255).toInt();
        final g = (yp - up * 46549 / 131072 + 44 - vp * 93604 / 131072 + 91)
            .round()
            .clamp(0, 255)
            .toInt();
        final b = (yp + up * 1814 / 1024 - 227).round().clamp(0, 255).toInt();
        // color: 0x FF  FF  FF  FF
        //           A   B   G   R
        img.data[index] = (0xFF << 24) | (b << 16) | (g << 8) | r;
      }
    }

    final png = imglib.PngEncoder(level: 0, filter: 0).encodeImage(img);
    // MEMO: What?
//      muteYUVProcessing = false;
    return Image.memory(png as Uint8List);
  }
}
