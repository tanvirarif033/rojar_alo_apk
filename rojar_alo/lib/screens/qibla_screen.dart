import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:geolocator/geolocator.dart';

class QiblaScreen extends StatefulWidget {
  const QiblaScreen({super.key});

  @override
  State<QiblaScreen> createState() => _QiblaScreenState();
}

class _QiblaScreenState extends State<QiblaScreen>
    with SingleTickerProviderStateMixin {
  final StreamController<LocationStatus> _locationStream =
  StreamController<LocationStatus>.broadcast();

  late AnimationController _glowController;

  /// ±5 degree tolerance
  static const double alignmentTolerance = 5 * pi / 180;

  @override
  void initState() {
    super.initState();
    _initLocation();

    /// Glow animation (pulse)
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
      lowerBound: 0.7,
      upperBound: 1.1,
    );
  }

  @override
  void dispose() {
    _locationStream.close();
    _glowController.dispose();
    super.dispose();
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🌙 BACKGROUND
          Positioned.fill(
            child: Image.asset(
              "assets/images/islamic_bg3.png",
              fit: BoxFit.cover,
            ),
          ),

          StreamBuilder<LocationStatus>(
            stream: _locationStream.stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              }

              final status = snapshot.data!;

              if (!status.enabled) {
                return const Center(
                  child: Text(
                    "📍 লোকেশন সার্ভিস চালু করুন",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }

              if (status.status == LocationPermission.denied ||
                  status.status == LocationPermission.deniedForever) {
                return Center(
                  child: ElevatedButton(
                    onPressed: _initLocation,
                    child: const Text("লোকেশন অনুমতি দিন"),
                  ),
                );
              }

              return StreamBuilder<QiblahDirection>(
                stream: FlutterQiblah.qiblahStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child:
                      CircularProgressIndicator(color: Colors.white),
                    );
                  }

                  final qiblah = snapshot.data!;

                  /// 🔄 Dynamic angle calculation (device → kaaba)
                  final double angle =
                      (qiblah.qiblah - qiblah.direction) * pi / 180;

                  final bool isAligned =
                      angle.abs() <= alignmentTolerance;

                  /// 🔥 Control glow animation dynamically
                  if (isAligned && !_glowController.isAnimating) {
                    _glowController.repeat(reverse: true);
                  } else if (!isAligned &&
                      _glowController.isAnimating) {
                    _glowController.stop();
                    _glowController.reset();
                  }

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// 🧭 HEADER
                      const Text(
                        "কিবলার দিক",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 28),

                      /// 🧭 COMPASS
                      ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                              sigmaX: 8, sigmaY: 8),
                          child: Container(
                            width: 300,
                            height: 300,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.35),
                              border: Border.all(
                                color: isAligned
                                    ? Colors.greenAccent
                                    : Colors.white,
                                width: 3,
                              ),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                /// N
                                const Positioned(
                                  top: 12,
                                  child: Text(
                                    "N",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                /// 🕋 KAABA ARROW
                                Transform.rotate(
                                  angle: angle,
                                  child: Transform.translate(
                                    offset: const Offset(0, -115),
                                    child: ScaleTransition(
                                      scale: isAligned
                                          ? _glowController
                                          : const AlwaysStoppedAnimation(
                                          1),
                                      child: Container(
                                        decoration: isAligned
                                            ? BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors
                                                  .greenAccent
                                                  .withOpacity(
                                                  0.9),
                                              blurRadius: 30,
                                              spreadRadius: 8,
                                            ),
                                          ],
                                        )
                                            : null,
                                        child: Image.asset(
                                          "assets/images/kaaba_arrow.png",
                                          width: 70,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 26),

                      /// ✅ STATUS TEXT
                      Text(
                        isAligned
                            ? "🕋 কিবলার সাথে মিলেছে"
                            : "কিবলার দিকে ঘুরুন",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isAligned
                              ? Colors.greenAccent
                              : Colors.white,
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
