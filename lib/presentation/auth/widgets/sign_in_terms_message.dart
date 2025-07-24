import 'package:flutter/material.dart';

class SignInTermsMessage extends StatelessWidget {
  const SignInTermsMessage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: "계속 함으로써 ",
        style: textTheme.bodySmall,
        children: [
          TextSpan(
            text: "이용약관",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: "과 "),
          TextSpan(
            text: "개인정보처리방침",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: "에 동의합니다."),
        ],
      ),
    );
  }
}
