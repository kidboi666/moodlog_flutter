import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../viewmodel/profile_viewmodel.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('프로필 설정'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Consumer<ProfileViewModel>(
        builder: (_, viewModel, _) => Column(
          children: [
            ListTile(
              title: Text('유저 ID', style: textTheme.titleMedium),
              subtitle: Text(viewModel.user?.uid ?? ''),
            ),
            ListTile(
              title: Text('닉네임 변경', style: textTheme.titleMedium),
              subtitle: Text(viewModel.user?.displayName ?? ''),
              trailing: Icon(Icons.edit),
            ),
            ListTile(
              title: Text('시작일', style: textTheme.titleMedium),
              subtitle: Text(
                viewModel.user?.metadata.creationTime.toString() ?? '',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
