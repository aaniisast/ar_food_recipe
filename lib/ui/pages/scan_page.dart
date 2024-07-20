import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanPage extends StatefulWidget {
  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  AudioPlayer audioPlayer = AudioPlayer();
  final Flutter3DController arController = Flutter3DController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Permission.camera.request(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data!.isGranted) {
              return Stack(
                children: <Widget>[
                  QRView(
                    key: qrKey,
                    onQRViewCreated: _onQRViewCreated,
                  ),
                  Center(
                    child: (result != null)
                        ? augmentedReality(result!)
                        : Text('Scan a code'),
                  )
                ],
              );
            }
            if (snapshot.data!.isDenied) {
              return Center(child: Text("Izinkan Kamera"));
            }
          }

          return Center(child: Text("Something went wrong"));
        },
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  Widget augmentedReality(Barcode result) {
    switch (result.code) {
      case "ayam":
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await audioPlayer.setAsset("assets/audio/ayam.mp3");
          audioPlayer.play();
        });
        return Flutter3DViewer(
          progressBarColor: Colors.green,
          src: "assets/3DModel/Ayam.glb",
          controller: arController,
        );
      case "telur":
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await audioPlayer.setAsset("assets/audio/telur.mp3");
          audioPlayer.play();
        });
        return Flutter3DViewer(
          progressBarColor: Colors.green,
          src: "assets/3DModel/Egg.glb",
          controller: arController,
        );
      case "lele":
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await audioPlayer.setAsset("assets/audio/lele.mp3");
          audioPlayer.play();
        });
        return Flutter3DViewer(
          progressBarColor: Colors.green,
          src: "assets/3DModel/Lele.glb",
          controller: arController,
        );
      default:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (audioPlayer.playing) {
            audioPlayer.stop();
          }
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Qr Code tidak valid")));
        });
        return Container();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    audioPlayer.dispose();
    super.dispose();
  }
}
