// file: lib/screens/scanner_screen.dart
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:safeeats_app/screens/result_screen.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  late List<CameraDescription> _cameras;
  CameraController? _controller;
  bool _isCameraInitialized = false;
  bool _isScanning = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    // Dapatkan daftar kamera yang tersedia
    _cameras = await availableCameras();
    if (_cameras.isNotEmpty) {
      // Inisialisasi controller untuk kamera pertama (biasanya kamera belakang)
      _controller = CameraController(_cameras[0], ResolutionPreset.high);
      await _controller!.initialize();
      if (!mounted) return;
      setState(() {
        _isCameraInitialized = true;
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _scanImage() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: Camera not initialized.')),
      );
      return;
    }

    setState(() {
      _isScanning = true;
    });

    try {
      // Ambil gambar
      final XFile imageFile = await _controller!.takePicture();

      // Siapkan input gambar untuk ML Kit
      final InputImage inputImage = InputImage.fromFilePath(imageFile.path);
      
      // Buat instance TextRecognizer
      final textRecognizer = TextRecognizer();
      
      // Proses gambar untuk mengekstrak teks
      final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
      
      // Tutup TextRecognizer setelah selesai
      textRecognizer.close();

      // Navigasi ke halaman hasil dengan membawa teks yang diekstrak
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ResultScreen(extractedText: recognizedText.text),
        ),
      );

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error scanning image: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isScanning = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isCameraInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Product Label')),
      body: Stack(
        fit: StackFit.expand,
        children: [
          CameraPreview(_controller!),
          // Overlay untuk tombol scan
          if (_isScanning)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    Text('Extracting text...', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isScanning ? null : _scanImage,
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}