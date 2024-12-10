import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraScanScreen extends StatefulWidget {
  @override
  _CameraScanScreenState createState() => _CameraScanScreenState();
}

class _CameraScanScreenState extends State<CameraScanScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      // Ambil daftar kamera yang tersedia
      final cameras = await availableCameras();

      // Cek apakah ada kamera yang terdeteksi
      if (cameras.isNotEmpty) {
        _controller = CameraController(
          cameras[0], // Menggunakan kamera pertama yang tersedia
          ResolutionPreset
              .medium, // Menggunakan resolusi yang lebih rendah untuk mempercepat
        );

        // Inisialisasi kamera
        _initializeControllerFuture = _controller!.initialize();
        setState(() {});
      } else {
        // Tampilkan pesan jika tidak ada kamera yang ditemukan
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Tidak ada kamera yang tersedia")),
        );
      }
    } catch (e) {
      print("Error inisialisasi kamera: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal menginisialisasi kamera: $e")),
      );
    }
  }

  @override
  void dispose() {
    // Lepaskan kontroler kamera
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aplikasi Fashion - Scan Kamera'),
      ),
      body: _controller == null
          ? Center(child: Text("Menunggu kamera..."))
          : FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_controller!);
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Gagal memuat kamera: ${snapshot.error}"),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
    );
  }
}
