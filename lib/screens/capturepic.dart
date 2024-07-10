import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CapturePicPage extends StatefulWidget {
  const CapturePicPage({super.key});

  @override
  CapturePicPageState createState() => CapturePicPageState();
}

class CapturePicPageState extends State<CapturePicPage> {
  late CameraController _controller;
  Future<void> _initializeControllerFuture = Future<void>(() {});
  late CameraDescription _currentCamera;
  late Future<List<CameraDescription>> _cameraList;
  bool _isFrontCamera = false;
  XFile? _image;

  @override
  void initState() {
    super.initState();
    _cameraList = getCameras();
    _cameraList.then((List<CameraDescription> cameras) {
      if (cameras.isNotEmpty) {
        _currentCamera = cameras.first;
        _initializeController(_currentCamera);
        setState(() {}); // i have used this to update the state of the widget
      } else {
        Get.snackbar(
          "Error",
          "No valid Camera Detected",
          duration: Duration(seconds: 1),
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
        Navigator.pushNamed(context, '/home');
        Navigator.pop(context);
      }
    });
  }

  Future<List<CameraDescription>> getCameras() async {
    final cameras = await availableCameras();
    return cameras;
  }

  void _initializeController(CameraDescription cameraDescription) async {
    _controller = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  Future<void> _toggleCamera() async {
    final cameras =
        await _cameraList; // Wait for the Future to complete and get the list of cameras
    setState(() {
      _isFrontCamera = !_isFrontCamera;
      _currentCamera = _isFrontCamera
          ? cameras.firstWhere(
              (camera) => camera.lensDirection == CameraLensDirection.front)
          : cameras.firstWhere(
              (camera) => camera.lensDirection == CameraLensDirection.back);
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
      Navigator.pop(context, {'imagePath': _image!.path});
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
        backgroundColor: Colors.blue,
        title: const Text('VERIFY YOU'),
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
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Column(
                        children: [
                          Expanded(child: CameraPreview(_controller)),
                          IconButton(
                            onPressed: _captureImage,
                            icon: Icon(Icons.camera),
                            iconSize: 50,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(child: Image.file(File(_image!.path))),
                Row(
                  children: [
                    ImageActionButton(
                      label: 'RETAKE',
                      onTap: _retakeImage,
                      color: Colors.red,
                    ),
                    ImageActionButton(
                      label: 'SUBMIT',
                      onTap: _saveImage,
                      color: Colors.green,
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

class ImageActionButton extends StatelessWidget {
  final Function onTap;
  final Color color;
  final String label;

  const ImageActionButton(
      {super.key,
      required this.label,
      required this.onTap,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: TextButton(
        onPressed: () {
          onTap();
        },
        style: TextButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
              color: Colors.white, fontSize: 20.0, letterSpacing: 1),
        ),
      ),
    );
  }
}
