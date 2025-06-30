import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ContactDialog extends StatelessWidget {
  const ContactDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('문의하기'),
      content: const Text('이메일: support@yourapp.com\n전화: 02-1234-5678'),
      actions: [
        TextButton(onPressed: () => context.pop(), child: const Text('확인')),
      ],
    );
  }
}
