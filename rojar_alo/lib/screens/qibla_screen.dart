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
  final StreamController<LocationStatus> _locationStream =
  StreamController<LocationStatus>.broadcast();

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      _locationStream.add(
        LocationStatus(false, LocationPermission.denied),
      );
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    final status = await FlutterQiblah.checkLocationStatus();
    _locationStream.add(status);
  }

  @override
  void dispose() {
    _locationStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE8F5E9),
              Color(0xFFF1F8F4),
            ],
          ),
        ),
        child: StreamBuilder<LocationStatus>(
          stream: _locationStream.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final status = snapshot.data!;

            if (!status.enabled) {
              return const Center(child: Text("📍 Enable location service"));
            }

            if (status.status == LocationPermission.denied ||
                status.status == LocationPermission.deniedForever) {
              return Center(
                child: ElevatedButton(
                  onPressed: _initLocation,
                  child: const Text("Allow Location Permission"),
                ),
              );
            }

            return StreamBuilder<QiblahDirection>(
              stream: FlutterQiblah.qiblahStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final qiblah = snapshot.data!;

                /// Device heading (0° = North)
                final double heading = qiblah.direction;

                /// WEST relative to phone
                final double westAngle =
                    (270 - heading) * pi / 180;

                /// Compass dial rotation
                final double dialAngle =
                    -heading * pi / 180;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "West Direction Indicator",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B5E20),
                      ),
                    ),
                    const SizedBox(height: 30),

                    SizedBox(
                      width: 300,
                      height: 300,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          /// Compass Dial
                          Transform.rotate(
                            angle: dialAngle,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const RadialGradient(
                                  colors: [
                                    Colors.white,
                                    Color(0xFFE8F5E9),
                                  ],
                                ),
                                border: Border.all(
                                  color: Colors.green,
                                  width: 4,
                                ),
                              ),
                              child: const Stack(
                                children: [
                                  Positioned(
                                    top: 12,
                                    left: 0,
                                    right: 0,
                                    child: Center(
                                      child: Text(
                                        "N",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 12,
                                    top: 0,
                                    bottom: 0,
                                    child: Center(child: Text("W")),
                                  ),
                                  Positioned(
                                    right: 12,
                                    top: 0,
                                    bottom: 0,
                                    child: Center(child: Text("E")),
                                  ),
                                  Positioned(
                                    bottom: 12,
                                    left: 0,
                                    right: 0,
                                    child: Center(child: Text("S")),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          /// 🕋 KAABA → ALWAYS MOVES TO REAL WEST
                          Transform.rotate(
                            angle: westAngle,
                            child: Transform.translate(
                              offset: const Offset(0, -120),
                              child: Image.asset(
                                "assets/images/kaaba_arrow.png",
                                width: 70,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),
                    Text(
                      "West = ${(270 - heading).toStringAsFixed(1)}°",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
