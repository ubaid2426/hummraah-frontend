// lib/features/auth/presentation/screens/ihram_preparation_screen.dart
import 'package:flutter/material.dart';
// import '../../../../core/utils/colors.dart';

class IhramPreparationScreen extends StatelessWidget {
  const IhramPreparationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                ),
              ],
            ),
            child: const Icon(Icons.arrow_back_rounded, color: Colors.black87),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Ihram Preparation',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Color(0xFF2C5F2D),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Image
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1591604129939-f1efa4d9f7fa?ixlib=rb-4.0.3',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      const Color(0xFF2C5F2D).withOpacity(0.8),
                    ],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.man,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        '🕋 How to Prepare for Ihram',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Step by Step Guide',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Embarking on Umrah? Start your journey right with proper Ihram preparation:',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF2C5F2D),
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 24),
                        
                        // Step 1
                        _buildStepItem(
                          number: '1️⃣',
                          title: 'Make the Niyyah (intention)',
                          description: 'Make sincere intention in your heart for Umrah',
                          icon: Icons.favorite,
                          color: Colors.red,
                          isFirst: true,
                        ),
                        
                        // Step 2
                        _buildStepItem(
                          number: '2️⃣',
                          title: 'Take a bath 🛁',
                          description: 'Perform ghusl (ritual bath) for purification',
                          icon: Icons.bathroom,
                          color: Colors.blue,
                        ),
                        
                        // Step 3
                        _buildStepItem(
                          number: '3️⃣',
                          title: 'Wear the Ihram cloth',
                          description: 'Two white unstitched sheets for men, modest clothing for women',
                          icon: Icons.checkroom,
                          color: Colors.green,
                        ),
                        
                        // Step 4
                        _buildStepItem(
                          number: '4️⃣',
                          title: 'Perform Wudu',
                          description: 'Make ablution before prayers',
                          icon: Icons.water_drop,
                          color: Colors.lightBlue,
                        ),
                        
                        // Step 5
                        _buildStepItem(
                          number: '5️⃣',
                          title: 'Pray two Rakats 🙏',
                          description: 'Pray two rakats nafl and make dua',
                          icon: Icons.mosque,
                          color: Colors.amber,
                          isLast: true,
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Additional Tips
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFFE6B566).withOpacity(0.1),
                          const Color(0xFF2C5F2D).withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.info_outline, color: Color(0xFFE6B566)),
                            SizedBox(width: 8),
                            Text(
                              'Important Reminders',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2C5F2D),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildReminderItem('Men should not wear stitched clothing'),
                        _buildReminderItem('Women should not wear niqab or gloves'),
                        _buildReminderItem('Perfume is prohibited in Ihram'),
                        _buildReminderItem('Cutting nails or hair is not allowed'),
                        _buildReminderItem('Hunting or harming animals is forbidden'),
                        _buildReminderItem('Arguing or fighting is strictly prohibited'),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Dua Section
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFFE6B566).withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Talbiyah',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2C5F2D),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2C5F2D).withOpacity(0.05),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'لَبَّيْكَ اللَّهُمَّ لَبَّيْكَ، لَبَّيْكَ لا شَرِيكَ لَكَ لَبَّيْكَ، إِنَّ الْحَمْدَ وَالنِّعْمَةَ لَكَ وَالْمُلْكَ، لا شَرِيكَ لَكَ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              height: 1.8,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          '"Here I am, O Allah, here I am. Here I am, You have no partner, here I am. Verily all praise and blessings are Yours, and all sovereignty, You have no partner."',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepItem({
    required String number,
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            if (!isFirst)
              Container(
                height: 20,
                width: 2,
                color: Colors.grey[300],
              ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
                border: Border.all(color: color.withOpacity(0.3)),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            if (!isLast)
              Container(
                height: 40,
                width: 2,
                color: Colors.grey[300],
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$number $title',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2C5F2D),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReminderItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.circle,
            size: 6,
            color: Color(0xFFE6B566),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF2C5F2D),
              ),
            ),
          ),
        ],
      ),
    );
  }
}