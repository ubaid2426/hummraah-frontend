import 'package:flutter/material.dart';
import '../../../../../core/utils/colors.dart';
// import '../../core/theme/co/lors.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primaryGreen,
        title: const Text("About Us", style: TextStyle(color: AppColors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primaryGreen,
                image: const DecorationImage(
                  image: NetworkImage(
                    "https://images.unsplash.com/photo-1542353436-312f0e1f67ff",
                  ),
                  fit: BoxFit.cover,
                  opacity: 0.3,
                ),
              ),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Serving Guests of Allah with Integrity & Care",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.backgroundLight,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Text(
                    "Who We Are",
                    style: TextStyle(
                      color: AppColors.primaryGold,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "We are a dedicated Umrah travel agency focused on providing hassle-free spiritual journeys for families and elderly pilgrims. Our mission is to handle the logistics so you can focus on Ibadah.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: AppColors.darkText,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: _buildInfoCard(
                      Icons.flag,
                      "Mission",
                      "To simplify Umrah travel for every Muslim.",
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _buildInfoCard(
                      Icons.visibility,
                      "Vision",
                      "To be the most trusted Islamic travel partner.",
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            Container(
              width: double.infinity,
              color: AppColors.lightGreyText,
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: [
                  Text(
                    "ACCREDITED & TRUSTED BY",
                    style: TextStyle(
                      color: AppColors.darkText,
                      letterSpacing: 2,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildBadge("Ministry of Hajj"),
                      const SizedBox(width: 20),
                      _buildBadge("IATA Certified"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String desc) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderGrey),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowBlack.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primaryGreen, size: 30),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            desc,
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.darkText, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryGold),
        borderRadius: BorderRadius.circular(20),
        color: AppColors.white,
      ),
      child: Row(
        children: [
          Icon(Icons.verified, color: AppColors.primaryGold, size: 18),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: AppColors.darkText,
            ),
          ),
        ],
      ),
    );
  }
}
