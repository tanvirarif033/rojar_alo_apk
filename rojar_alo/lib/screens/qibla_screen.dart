import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:geolocator/geolocator.dart';

class QiblaScreen extends StatefulWidget {
  const QiblaScreen({super.key});

  @override
  State<QiblaScreen> createState() => _QiblaScreenState();
}

class _QiblaScreenState extends State<QiblaScreen> {
  final _locationStreamController =
  StreamController<LocationStatus>.broadcast();

  @override
  void initState() {
    super.initState();
    _checkLocationStatus();
  }

  Future<void> _checkLocationStatus() async {
    final status = await FlutterQiblah.checkLocationStatus();
    _locationStreamController.add(status);
  }

  @override
  void dispose() {
    _locationStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LocationStatus>(
      stream: _locationStreamController.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final status = snapshot.data!;

        if (!status.enabled) {
          return const Center(
            child: Text("📍 Please enable location services"),
          );
        }

        if (status.status == LocationPermission.denied ||
            status.status == LocationPermission.deniedForever) {
          return Center(
            child: ElevatedButton(
              onPressed: _checkLocationStatus,
              child: const Text("Allow Location Permission"),
            ),
          );
        }

        // ✅ Location & sensor OK → Show Qibla
        return StreamBuilder<QiblahDirection>(
          stream: FlutterQiblah.qiblahStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final qiblaDirection = snapshot.data!;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Qibla Direction",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                Transform.rotate(
                  angle: qiblaDirection.qiblah * pi / 180,
                  child: const Icon(
                    Icons.navigation,
                    size: 150,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "${qiblaDirection.qiblah.toStringAsFixed(2)}°",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
