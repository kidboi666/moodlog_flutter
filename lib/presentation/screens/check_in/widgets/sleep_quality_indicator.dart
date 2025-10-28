import 'package:flutter/material.dart';

class SleepQualityIndicator extends StatelessWidget {
  final int quality;

  const SleepQualityIndicator({super.key, required this.quality});

  Color _getQualityColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    if (quality >= 4) {
      return Colors.green;
    } else if (quality >= 3) {
      return colorScheme.primary;
    } else {
      return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    final percentage = quality / 5.0;
    final color = _getQualityColor(context);

    return SizedBox(
      width: 120,
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 120,
            height: 120,
            child: CircularProgressIndicator(
              value: percentage,
              strokeWidth: 12,
              backgroundColor: color.withValues(alpha: 0.2),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$quality',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
              ),
              Text(
                '/ 5',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
