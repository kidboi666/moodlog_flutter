import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class MarkdownButtonSection extends StatelessWidget {
  final Function toggleAttribute;
  final Map<String, bool> currentFormattingStates;
  final Function insertLink;

  const MarkdownButtonSection({
    super.key,
    required this.toggleAttribute,
    required this.currentFormattingStates,
    required this.insertLink,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildMarkdownButton(
          context,
          icon: Icons.format_bold,
          onPressed: () => toggleAttribute(Attribute.bold),
          formatType: 'bold',
        ),
        _buildMarkdownButton(
          context,
          icon: Icons.format_italic,
          onPressed: () => toggleAttribute(Attribute.italic),
          formatType: 'italic',
        ),
        _buildMarkdownButton(
          context,
          icon: Icons.format_underlined,
          onPressed: () => toggleAttribute(Attribute.underline),
          formatType: 'underline',
        ),
        _buildMarkdownButton(
          context,
          icon: Icons.format_strikethrough,
          onPressed: () => toggleAttribute(Attribute.strikeThrough),
          formatType: 'strikeThrough',
        ),
        _buildMarkdownButton(
          context,
          icon: Icons.format_list_bulleted,
          onPressed: () => toggleAttribute(Attribute.ul),
          formatType: 'ul',
        ),
        _buildMarkdownButton(
          context,
          icon: Icons.format_list_numbered,
          onPressed: () => toggleAttribute(Attribute.ol),
          formatType: 'ol',
        ),
        _buildMarkdownButton(
          context,
          icon: Icons.format_quote,
          onPressed: () => toggleAttribute(Attribute.blockQuote),
          formatType: 'blockQuote',
        ),
        _buildMarkdownButton(
          context,
          icon: Icons.link,
          onPressed: () => insertLink(),
          formatType: 'link',
        ),
      ],
    );
  }

  Widget _buildMarkdownButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onPressed,
    required String formatType,
  }) {
    final isActive = currentFormattingStates[formatType] ?? false;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: isActive ? colorScheme.primaryContainer : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: isActive ? colorScheme.onPrimaryContainer : null,
        ),
      ),
    );
  }
}
