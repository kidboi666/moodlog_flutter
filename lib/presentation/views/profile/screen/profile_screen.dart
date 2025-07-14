import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('프로필 설정'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('사용자 이름'),
            subtitle: Text('현재 사용자명'),
            trailing: Icon(Icons.edit),
          ),
          ListTile(
            title: Text('이메일'),
            subtitle: Text('user@example.com'),
            trailing: Icon(Icons.edit),
          ),
          // 추가 설정 항목들...
        ],
      ),
    );
  }
}
