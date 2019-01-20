import 'dart:io';

import 'package:camera/camera.dart';
import 'package:emoji_scavenger_hunt/model/game_bloc_provider.dart';
import 'package:emoji_scavenger_hunt/util/util.dart';
import 'package:emoji_scavenger_hunt/widgets/app_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class CameraView extends StatefulWidget {
  @override
  CameraViewState createState() {
    return new CameraViewState();
  }
}

class CameraViewState extends State<CameraView> {
  CameraController _controller;
  var _isCapturing = false;

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
    _controller = CameraController(
      cameras[0],
      ResolutionPreset.medium,
    );
    await _controller.initialize();
    await _controller.startImageStream((image) async {
      _detectIfCan(image);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller.value.isInitialized) {
      return const AppProgressIndicator();
    }

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
}
