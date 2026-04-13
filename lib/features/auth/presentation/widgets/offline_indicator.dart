// lib/widgets/offline_indicator.dart
import 'package:flutter/material.dart';

class OfflineIndicator extends StatelessWidget {
  final bool isOffline;
  final String? message;
  
  const OfflineIndicator({
    super.key,
    required this.isOffline,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    if (!isOffline) return const SizedBox.shrink();
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.amber.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.offline_bolt_rounded,
            color: Colors.amber,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message ?? 'You are offline. Some features may be limited.',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.amber,
              ),
            ),
          ),
        ],
      ),
    );
  }
}