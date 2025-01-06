import 'package:eagri_pro/core/constants/color_constants.dart';
import 'package:flutter/material.dart';

class HeaderCustom extends StatelessWidget {
  final Widget? child;
  final String? title;
  final String? description;
  const HeaderCustom({
    super.key,
    this.child,
    this.title,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: ColorConstants.primaryColor,
          // image: const DecorationImage(
          //   image: AssetImage('assets/images/login_bg.jpg'),
          //   fit: BoxFit.cover,
          // )
        ),
        child: Stack(
          clipBehavior: Clip.none,
          fit: StackFit.expand,
          children: [
            Positioned(
              top: -20,
              left: -20,
              child: CustomPaint(
                painter: CirclePainter(),
              ),
            ),
            Positioned(
              right: 80,
              bottom: 80,
              child: CustomPaint(
                painter: CirclePainter(),
              ),
            ),
            if (child == null)
              Container(
                margin: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      title!.toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              color: Colors.white, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 10),
                    Text(description ?? "Description",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color:
                                    const Color(0xFFFAFAF9).withOpacity(0.5))),
                    // const SizedBox(height: 30),
                  ],
                ),
              ),
            child ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Applique le flou gaussien avec ImageFilter.blur
    final paint = Paint()
      ..color = ColorConstants.secondaryColor
      ..maskFilter =
          MaskFilter.blur(BlurStyle.normal, convertRadiusToSigma(57.78));

    // Dessiner le cercle avec les coordonnées données
    canvas.drawCircle(const Offset(50, 50), 60, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  // Convertir le rayon pour l'appliquer dans MaskFilter
  double convertRadiusToSigma(double radius) {
    return radius * 0.57735 + 0.5;
  }
}
