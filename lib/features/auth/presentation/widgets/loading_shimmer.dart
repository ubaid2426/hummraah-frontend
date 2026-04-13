// lib/widgets/loading_shimmer.dart
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
// import 'package:shimmer/shimmer.dart';

class LoadingShimmer extends StatelessWidget {
  final Widget child;
  const LoadingShimmer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: child,
    );
  }
}

class PackageCardShimmer extends StatelessWidget {
  const PackageCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 200,
                  height: 20,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: 8),
                Container(
                  width: 100,
                  height: 16,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 20,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 60,
                      height: 20,
                      color: Colors.grey[300],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 100,
                          height: 16,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 4),
                        Container(
                          width: 80,
                          height: 24,
                          color: Colors.grey[300],
                        ),
                      ],
                    ),
                    Container(
                      width: 100,
                      height: 40,
                      color: Colors.grey[300],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}