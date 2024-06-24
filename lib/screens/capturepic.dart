import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CapturePicPage extends StatefulWidget {
  final List<CameraDescription> cameras;
   const CapturePicPage({super.key, required this.cameras});

  @override
  CapturePicPageState createState() => CapturePicPageState();
}

class CapturePicPageState extends State<CapturePicPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late CameraDescription _currentCamera;
  bool _isFrontCamera = false;
  XFile? _image;

  @override
  void initState() {
    super.initState();
    _currentCamera = widget.cameras.first;
    _initializeController(_currentCamera);
  }

  void _initializeController(CameraDescription cameraDescription) {
    _controller = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  void _toggleCamera() {
    setState(() {
      _isFrontCamera = !_isFrontCamera;
      _currentCamera = _isFrontCamera
          ? widget.cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front)
          : widget.cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.back);
      _initializeController(_currentCamera);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _captureImage() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();
      setState(() {
        _image = image;
      });
    } catch (e) {
      print(e);
    }
  }
//The picture captured by the camera is saved in the default location provided by the camera package, 
//which is typically the application's directory on the device's storage. a custom function can be made later on to save the image elsewhere
  void _saveImage() {
    if (_image != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DisplayPictureScreen(imagePath: _image!.path),
        ),
      );
    }
  }

  void _retakeImage() {
    setState(() {
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capture Picture'),
        //backgroundColor: Colors.grey[850],
        actions: [
          IconButton(
            icon: const Icon(Icons.cameraswitch),
            onPressed: _toggleCamera,
          ),
        ],
      ),
      body: _image == null
          ? FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
                    children: [
                      Expanded(child: CameraPreview(_controller)),
                      ElevatedButton(
                        onPressed: _captureImage,
                        child: const Text('Capture Picture'),
                      ),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )
          : Column(
              children: [
                Expanded(child: Image.file(File(_image!.path))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _retakeImage,
                      child: const Text('Retake'),
                    ),
                    ElevatedButton(
                      onPressed: _saveImage,
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('saved picture')),
      body: Image.file(File(imagePath)),
    );
  }
}
