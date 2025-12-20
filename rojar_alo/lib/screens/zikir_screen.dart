import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class ZikirScreen extends StatefulWidget {
  const ZikirScreen({super.key});

  @override
  State<ZikirScreen> createState() => _ZikirScreenState();
}

class _ZikirScreenState extends State<ZikirScreen>
    with SingleTickerProviderStateMixin {
  int count = 0;

  bool soundOn = true;
  bool vibrateOn = true;

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late AudioPlayer _player;

  @override
  void initState() {
    super.initState();

    _player = AudioPlayer();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.9,
      upperBound: 1.0,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _player.dispose();
    super.dispose();
  }

  void _increment() async {
    _controller.reverse().then((_) => _controller.forward());
    setState(() => count++);

    // 🔊 Sound
    if (soundOn) {
      await _player.play(
        AssetSource("sounds/tap.mp3"),
        volume: 1.0,
      );
    }

    // 📳 Vibration
    if (vibrateOn) {
      HapticFeedback.mediumImpact();
    }
  }

  void _reset() {
    setState(() => count = 0);
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// ================= TITLE =================
            const Text(
              "Tasbih Counter",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20),
              ),
            ),

            const SizedBox(height: 24),

            /// ================= COUNT =================
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 40,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.95),
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.15),
                    blurRadius: 18,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Text(
                "$count",
                style: const TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
              ),
            ),

            const SizedBox(height: 28),

            /// ================= SOUND & VIBRATION TOGGLES =================
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ToggleButton(
                  icon: Icons.volume_up,
                  label: "Sound",
                  isOn: soundOn,
                  onTap: () => setState(() => soundOn = !soundOn),
                ),
                const SizedBox(width: 16),
                _ToggleButton(
                  icon: Icons.vibration,
                  label: "Vibrate",
                  isOn: vibrateOn,
                  onTap: () => setState(() => vibrateOn = !vibrateOn),
                ),
              ],
            ),

            const SizedBox(height: 36),

            /// ================= TASBIH BUTTON =================
            ScaleTransition(
              scale: _scaleAnimation,
              child: GestureDetector(
                onTap: _increment,
                child: Container(
                  height: 170,
                  width: 170,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF2E7D32),
                        Color(0xFF1B5E20),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.45),
                        blurRadius: 22,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      "TAP",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            /// ================= RESET =================
            GestureDetector(
              onTap: _reset,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 26,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFFF6F61),
                      Color(0xFFD32F2F),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.redAccent.withOpacity(0.45),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.restart_alt_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Reset Counter",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

/// ================= TOGGLE BUTTON WIDGET =================
class _ToggleButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isOn;
  final VoidCallback onTap;

  const _ToggleButton({
    required this.icon,
    required this.label,
    required this.isOn,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isOn ? Colors.green : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isOn
              ? [
            BoxShadow(
              color: Colors.green.withOpacity(.4),
              blurRadius: 10,
            ),
          ]
              : [],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isOn ? Colors.white : Colors.black54,
              size: 18,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isOn ? Colors.white : Colors.black54,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
