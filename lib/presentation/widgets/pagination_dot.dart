import 'package:flutter/material.dart';

class PaginationDot extends StatelessWidget {
  final int page;
  final int total;

  const PaginationDot({super.key, required this.page, required this.total});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        total,
        (index) => GestureDetector(
          onTap: () => print('탭 감지됨'),
          child: AnimatedContainer(
            margin: const EdgeInsets.symmetric(horizontal: 2.0),
            width: 8,
            height: 8,
            duration: const Duration(milliseconds: 400),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: index == page ? Colors.blue[400] : Colors.blue[100],
            ),
          ),
        ),
      ),
    );
  }
}
