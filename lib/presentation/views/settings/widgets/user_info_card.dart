import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserInfoCard extends StatelessWidget {
  final User? user;

  const UserInfoCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '로그인 정보',
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          if (user == null)
            Text('로그인 정보가 없습니다.', style: textTheme.bodyMedium)
          else ...[
            _buildUserInfoRow(
              context,
              icon: Icons.person_outline,
              label: '상태',
              value: user!.isAnonymous ? '익명 로그인' : '로그인',
            ),
            const SizedBox(height: 8),
            _buildUserInfoRow(
              context,
              icon: Icons.fingerprint,
              label: 'UID',
              value: user!.uid,
              isSelectable: true,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildUserInfoRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    bool isSelectable = false,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Icon(icon, size: 18, color: textTheme.bodySmall?.color),
        const SizedBox(width: 8),
        Text('$label:', style: textTheme.bodyMedium),
        const SizedBox(width: 8),
        Expanded(
          child: isSelectable
              ? SelectableText(
                  value,
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                )
              : Text(
                  value,
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
        ),
      ],
    );
  }
}
