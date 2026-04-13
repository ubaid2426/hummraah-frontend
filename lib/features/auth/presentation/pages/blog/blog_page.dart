import 'package:flutter/material.dart';

import '../../../../../core/utils/colors.dart';
// import '../../core/theme/colors.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> blogs = [
      {
        "title": "Complete Umrah Preparation Guide 2024",
        "category": "Preparation",
        "readTime": "8 min read",
        "desc":
            "Everything you need to pack, dua books, and physical preparation tips before you fly.",
        "date": "Oct 12, 2024",
        "imageUrl":
            "https://images.unsplash.com/photo-1565552629477-ff1459a52601?auto=format&fit=crop&q=80&w=800",
      },
      {
        "title": "Best Ziyarat Places in Madinah",
        "category": "History",
        "readTime": "6 min read",
        "desc":
            "A historical guide to Masjid Quba, Mount Uhud, and other sacred places you must visit.",
        "date": "Sep 28, 2024",
        "imageUrl":
            "https://images.unsplash.com/photo-1591604129939-f1efa4d9f7fa?auto=format&fit=crop&q=80&w=800",
      },
      {
        "title": "Tips for Traveling with Elderly Parents",
        "category": "Travel Tips",
        "readTime": "5 min read",
        "desc":
            "How to manage wheelchairs, medicines, and crowd navigation in Haram.",
        "date": "Sep 15, 2024",
        "imageUrl":
            "https://images.unsplash.com/photo-1532274402911-5a369e4c4bb5?auto=format&fit=crop&q=80&w=800",
      },
      {
        "title": "Understanding the Rules of Ihram",
        "category": "Fiqh & Rules",
        "readTime": "10 min read",
        "desc":
            "A detailed look at the Do's and Don'ts while in the state of Ihram.",
        "date": "Aug 30, 2024",
        "imageUrl":
            "https://images.unsplash.com/photo-1596726269668-36c2e8f1d821?auto=format&fit=crop&q=80&w=800",
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        title: const Text(
          "Travel Blog & Tips",
          style: TextStyle(color: AppColors.white),
        ),
        backgroundColor: AppColors.primaryGreen,
        iconTheme: const IconThemeData(color: AppColors.white),
        elevation: 0,
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
      ),
      body: Column(
        children: [
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: AppColors.pageBackground,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildCategoryChip("All", true),
                _buildCategoryChip("Preparation", false),
                _buildCategoryChip("History", false),
                _buildCategoryChip("Travel Tips", false),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: blogs.length,
              itemBuilder: (context, index) {
                final blog = blogs[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 20),
                  elevation: 3,
                  shadowColor: AppColors.shadowBlack,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(15),
                              ),
                              child: Image.network(
                                blog['imageUrl'],
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 180,
                                    color: AppColors.lightGreyText,
                                    child: const Center(
                                      child: Icon(Icons.broken_image),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              top: 12,
                              right: 12,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.white.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  blog['category'],
                                  style: TextStyle(
                                    color: AppColors.primaryGreen,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                blog['title'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: AppColors.darkText,
                                  height: 1.2,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                blog['desc'],
                                style: TextStyle(
                                  color: AppColors.darkText,
                                  fontSize: 14,
                                  height: 1.5,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    size: 14,
                                    color: AppColors.darkText,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    blog['date'],
                                    style: TextStyle(
                                      color: AppColors.darkText,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const Spacer(),
                                  Icon(
                                    Icons.access_time,
                                    size: 14,
                                    color: AppColors.primaryGold,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    blog['readTime'],
                                    style: TextStyle(
                                      color: AppColors.darkText,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Chip(
        label: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColors.white : AppColors.primaryGreen,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        backgroundColor: isSelected ? AppColors.primaryGreen : AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: AppColors.primaryGreen),
        ),
      ),
    );
  }
}
