import 'package:flutter/material.dart';

class OnboardingWelcomePageView extends StatelessWidget {
  final bool isActive;
  final String title;
  final String description;
  final String image;
  final Color? titleColor;
  final Color? descriptionColor;

  const OnboardingWelcomePageView({
    super.key,
    required this.isActive,
    required this.title,
    required this.description,
    required this.image,
    this.titleColor,
    this.descriptionColor,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AnimatedOpacity(
            opacity: isActive ? 1.0 : 0.7,
            duration: const Duration(milliseconds: 500),
            child: AnimatedScale(
              scale: isActive ? 1.0 : 0.9,
              duration: const Duration(milliseconds: 500),
              child: Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(image, fit: BoxFit.cover),
                ),
              ),
            ),
          ),

          const SizedBox(height: 60),

          AnimatedSlide(
            offset: isActive ? Offset.zero : const Offset(0, 0.2),
            duration: const Duration(milliseconds: 600),
            child: AnimatedOpacity(
              opacity: isActive ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 600),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: titleColor ?? const Color(0xFF2D3748),
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          AnimatedSlide(
            offset: isActive ? Offset.zero : const Offset(0, 0.3),
            duration: const Duration(milliseconds: 700),
            child: AnimatedOpacity(
              opacity: isActive ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 700),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: descriptionColor ?? const Color(0xFF718096),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  height: 1.6,
                ),
              ),
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
    ;
  }
}
