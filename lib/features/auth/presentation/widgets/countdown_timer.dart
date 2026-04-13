// lib/widgets/countdown_timer.dart
import 'package:flutter/material.dart';
import 'dart:async';

class CountdownTimer extends StatefulWidget {
  final DateTime targetDate;
  final VoidCallback? onComplete;
  
  const CountdownTimer({
    super.key,
    required this.targetDate,
    this.onComplete,
  });

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  late Duration _duration;

  @override
  void initState() {
    super.initState();
    _duration = widget.targetDate.difference(DateTime.now());
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _duration = widget.targetDate.difference(DateTime.now());
      });
      if (_duration.isNegative) {
        _timer.cancel();
        widget.onComplete?.call();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String days = _duration.inDays.toString().padLeft(2, '0');
    String hours = (_duration.inHours % 24).toString().padLeft(2, '0');
    String minutes = (_duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (_duration.inSeconds % 60).toString().padLeft(2, '0');

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF2C5F2D),
            Color(0xFF4CAF50),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text(
            'Your Umrah Begins in',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTimeBlock(days, 'Days'),
              _buildSeparator(),
              _buildTimeBlock(hours, 'Hours'),
              _buildSeparator(),
              _buildTimeBlock(minutes, 'Mins'),
              _buildSeparator(),
              _buildTimeBlock(seconds, 'Secs'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeBlock(String value, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildSeparator() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        ':',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}