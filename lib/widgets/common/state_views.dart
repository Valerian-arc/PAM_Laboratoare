import 'package:flutter/material.dart';

/// Shown while a page's data is loading.
class LoadingView extends StatelessWidget {
  final Color color;
  final String message;

  const LoadingView({
    super.key,
    required this.color,
    this.message = 'Loading…',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 34,
            height: 34,
            child: CircularProgressIndicator(strokeWidth: 3, color: color),
          ),
          const SizedBox(height: 14),
          Text(
            message,
            style: const TextStyle(color: Color(0xFF858597), fontSize: 14),
          ),
        ],
      ),
    );
  }
}

/// Shown when loading failed, with a retry button.
class ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  final Color color;

  const ErrorView({
    super.key,
    required this.message,
    required this.onRetry,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cloud_off_rounded, size: 48, color: color),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Color(0xFF858597), fontSize: 14),
            ),
            const SizedBox(height: 18),
            FilledButton.icon(
              style: FilledButton.styleFrom(backgroundColor: color),
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}
