// lib/widgets/dua_card.dart
import 'package:flutter/material.dart';
import '../../../../core/utils/colors.dart';
import '../../data/models/dua_model.dart';
// import '../models/dua_model.dart';
// import '../utils/colors.dart';

class DuaCard extends StatelessWidget {
  final DuaModel dua;
  const DuaCard({super.key, required this.dua});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.menu_book_rounded,
                  color: AppColors.primaryGreen,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dua.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      dua.category,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              if (dua.isOffline)
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.offline_bolt_rounded,
                    color: Colors.green,
                    size: 14,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            dua.arabicText,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 20,
              fontFamily: 'Amiri',
              height: 1.8,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            dua.translation,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[700],
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.volume_up_rounded,
                      size: 20,
                      color: AppColors.primaryGreen,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.bookmark_border_rounded,
                      size: 20,
                      color: AppColors.primaryGold,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.share_rounded,
                      size: 20,
                      color: Colors.grey[600],
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primaryGold.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Read ${dua.times}x',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.primaryGold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}