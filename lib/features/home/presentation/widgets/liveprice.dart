import 'package:flutter/material.dart';

class LivePriceCard extends StatelessWidget {
  final String goldPrice;
  final String silverPrice;
  final String goldChange;
  final String silverChange;

  const LivePriceCard({
    super.key,
    required this.goldPrice,
    required this.silverPrice,
    required this.goldChange,
    required this.silverChange,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 10),
      child: Material(
        color: Colors.transparent,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Main container
            Container(
              constraints: const BoxConstraints(maxWidth: 350),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Live Price",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.red),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.newspaper, size: 16, color: Colors.red),
                            SizedBox(width: 4),
                            Text(
                              "International Gold News",
                              style: TextStyle(fontSize: 12, color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Gold Rate",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(
                              "Rs $goldPrice",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            const Text("Per Tola",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12)),
                            const SizedBox(height: 8),
                            Image.asset("assets/image/gold.png", height: 40),
                            const SizedBox(height: 4),
                            Text(
                              "▲ $goldChange",
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          width: 1, height: 100, color: Colors.grey.shade300),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Silver Rate",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(
                              "Rs $silverPrice",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                            const Text("Per Tola",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12)),
                            const SizedBox(height: 8),
                            Image.asset("assets/image/silver.png", height: 40),
                            const SizedBox(height: 4),
                            Text(
                              "▼ $silverChange",
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Arrow positioned to top right of container
            Positioned(
              top: -10,
              right: 30,
              child: CustomPaint(
                size: const Size(20, 10),
                painter: _ArrowPainter(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color.fromARGB(255, 255, 255, 255);
    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
