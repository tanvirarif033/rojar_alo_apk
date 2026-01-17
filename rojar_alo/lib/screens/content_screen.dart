import 'dart:ui';
import 'package:flutter/material.dart';

class ContentScreen extends StatefulWidget {
  final String title;
  final String content;

  const ContentScreen({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  double _fontSize = 16.5;
  bool _isNightMode = false;

  void _zoomIn() {
    setState(() {
      if (_fontSize < 26) _fontSize += 1.5;
    });
  }

  void _zoomOut() {
    setState(() {
      if (_fontSize > 12) _fontSize -= 1.5;
    });
  }

  void _toggleNightMode() {
    setState(() => _isNightMode = !_isNightMode);
  }

  @override
  Widget build(BuildContext context) {
    final Color textColor =
    _isNightMode ? Colors.white : Colors.black;

    return Scaffold(
      body: Stack(
        children: [
          // 🌙 BACKGROUND IMAGE
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/islamic_bg3.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 🌙 OVERLAY (DARKER IN NIGHT MODE)
          Container(
            color: _isNightMode
                ? Colors.black.withOpacity(0.55)
                : Colors.black.withOpacity(0.12),
          ),

          // 🔹 MAIN CONTENT
          Column(
            children: [
              /// ================= HEADER =================
              Container(
                padding: const EdgeInsets.fromLTRB(16, 48, 16, 20),
                decoration: BoxDecoration(
                  color: _isNightMode
                      ? Colors.black.withOpacity(0.45)
                      : Colors.green.shade900.withOpacity(0.75),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(28),
                    bottomRight: Radius.circular(28),
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Text(
                        widget.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        _isNightMode
                            ? Icons.light_mode
                            : Icons.dark_mode,
                        color: Colors.white,
                      ),
                      onPressed: _toggleNightMode,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              /// ================= ZOOM CONTROLS =================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: BackdropFilter(
                      filter:
                      ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: Container(
                        color: Colors.white.withOpacity(0.25),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove,
                                  color: textColor),
                              onPressed: _zoomOut,
                            ),
                            Text(
                              _fontSize.toInt().toString(),
                              style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.add,
                                  color: textColor),
                              onPressed: _zoomIn,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              /// ================= TEXT OVER BACKGROUND =================
              Expanded(
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: BackdropFilter(
                      filter:
                      ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        color: _isNightMode
                            ? Colors.black.withOpacity(0.15)
                            : Colors.white.withOpacity(0.35),
                        child: SingleChildScrollView(
                          physics:
                          const BouncingScrollPhysics(),
                          child: SelectableText(
                            widget.content,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: _fontSize,
                              height: 1.8,
                              color: textColor, // ✅ KEY CHANGE
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}
