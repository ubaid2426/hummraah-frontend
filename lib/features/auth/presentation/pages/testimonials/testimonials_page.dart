import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/utils/colors.dart';
// import '../../core/theme/colors.dart';

class TestimonialsScreen extends StatelessWidget {
  const TestimonialsScreen({super.key});
  Future<void> _launchVideo(BuildContext context, String urlString) async {
    try {
      final Uri url = Uri.parse(urlString);
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Could not open video: $e"),
          backgroundColor: AppColors.errorRed,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> testimonials = [
      {
        "name": "Ahmed Ali & Family",
        "location": "Lahore, Pakistan",
        "rating": 5,
        "date": "12 Oct 2024",
        "text":
            "Mashallah, bohot behtareen intezam tha. Mere walid ke liye wheelchair aur hotel ki nazdeeki bohot mufeed rahi.",
        "hasVideo": true,
        "videoUrl": "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
      },
      {
        "name": "Mrs. Farida Khan",
        "location": "London, UK",
        "rating": 5,
        "date": "05 Sep 2024",
        "text":
            "As a first-time traveler, I was nervous, but the guide provided by the team was exceptional. Everything was transparent.",
        "hasVideo": false,
      },
      {
        "name": "Kamran Siddiqui",
        "location": "Karachi, Pakistan",
        "rating": 4,
        "date": "20 Aug 2024",
        "text":
            "Visa processing was very fast. Hotels were clean. Transport was slightly delayed but overall a spiritual journey.",
        "hasVideo": true,
        "videoUrl": "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        title: const Text(
          "Pilgrim Stories",
          style: TextStyle(color: AppColors.white),
        ),
        backgroundColor: AppColors.primaryGreen,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.white),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: testimonials.length,
        itemBuilder: (context, index) {
          final t = testimonials[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowBlack.withOpacity(0.05),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: AppColors.primaryGreen.withOpacity(
                          0.1,
                        ),
                        child: Text(
                          t['name'][0],
                          style: TextStyle(
                            color: AppColors.primaryGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              t['name'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: AppColors.darkText,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 12,
                                  color: AppColors.darkText,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  t['location'],
                                  style: TextStyle(
                                    color: AppColors.darkText,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _buildStarRating(t['rating']),
                          const SizedBox(height: 4),
                          Text(
                            t['date'],
                            style: TextStyle(
                              color: AppColors.darkText,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const Divider(height: 1, color: AppColors.borderGrey),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Verified Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryGold.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.verified,
                              size: 14,
                              color: AppColors.primaryGold,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "Verified Pilgrim",
                              style: TextStyle(
                                color: AppColors.primaryGold,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "\"${t['text']}\"",
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.5,
                          color: AppColors.darkText,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                if (t['hasVideo']) ...[
                  GestureDetector(
                    onTap: () {
                      if (t['videoUrl'] != null) {
                        _launchVideo(context, t['videoUrl']);
                      }
                    },
                    child: Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.shadowBlack.withOpacity(0.9),
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(15),
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Opacity(
                            opacity: 0.6,
                            child: Icon(
                              Icons.videocam,
                              size: 80,
                              color: AppColors.white.withOpacity(0.1),
                            ),
                          ),
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: AppColors.primaryGold.withOpacity(0.8),
                            child: const Icon(
                              Icons.play_arrow,
                              color: AppColors.white,
                              size: 30,
                            ),
                          ),
                          const Positioned(
                            bottom: 10,
                            right: 15,
                            child: Text(
                              "Watch Video Review",
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ] else
                  const SizedBox(height: 8),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStarRating(int rating) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: AppColors.primaryGold,
          size: 16,
        );
      }),
    );
  }
}
