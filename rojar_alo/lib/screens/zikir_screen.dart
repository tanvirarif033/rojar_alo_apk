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

    _scaleAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeOut);

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

    if (soundOn) {
      await _player.play(
        AssetSource("sounds/tap.mp3"),
        volume: 1.0,
      );
    }

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
      body: Stack(
        children: [
          /// 🌙 FULL SCREEN BACKGROUND IMAGE (CLEAR)
          Positioned.fill(
            child: Image.asset(
              "assets/images/islamic_bg3.png",
              fit: BoxFit.cover,
            ),
          ),

          /// ================= MAIN UI =================
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// 🕌 TITLE
                    const Text(
                      "তাসবিহ কাউন্টার",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// 🔢 COUNT BOX
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 44,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
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

                    /// 🔊 SOUND & 📳 VIBRATION
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _ToggleButton(
                          icon: Icons.volume_up,
                          label: "শব্দ",
                          isOn: soundOn,
                          onTap: () =>
                              setState(() => soundOn = !soundOn),
                        ),
                        const SizedBox(width: 16),
                        _ToggleButton(
                          icon: Icons.vibration,
                          label: "ভাইব্রেশন",
                          isOn: vibrateOn,
                          onTap: () =>
                              setState(() => vibrateOn = !vibrateOn),
                        ),
                      ],
                    ),

                    const SizedBox(height: 36),

                    /// 🟢 TASBIH BUTTON
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
                              "চাপুন",
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

                    /// 🔁 RESET BUTTON
                    GestureDetector(
                      onTap: _reset,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 26,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
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
                            Icon(Icons.restart_alt_rounded,
                                color: Colors.white, size: 20),
                            SizedBox(width: 8),
                            Text(
                              "রিসেট করুন",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ================= TOGGLE BUTTON =================
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
