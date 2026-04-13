// lib/features/auth/presentation/screens/pre_umrah_preparation_screen.dart
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/utils/colors.dart';

class PreUmrahPreparationScreen extends StatefulWidget {
  const PreUmrahPreparationScreen({super.key});

  @override
  State<PreUmrahPreparationScreen> createState() => _PreUmrahPreparationScreenState();
}

class _PreUmrahPreparationScreenState extends State<PreUmrahPreparationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Pre-Umrah Preparation',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Colors.black87,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: AppColors.primaryGreen,
          unselectedLabelColor: Colors.grey,
          indicatorColor: AppColors.primaryGold,
          indicatorWeight: 3,
          tabs: const [
            Tab(text: 'Checklist'),
            Tab(text: 'Documents'),
            Tab(text: 'Health & Safety'),
            Tab(text: 'Spiritual Prep'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ChecklistTab(),
          DocumentsTab(),
          HealthSafetyTab(),
          SpiritualPrepTab(),
        ],
      ),
    );
  }
}

// Checklist Tab
class ChecklistTab extends StatefulWidget {
  const ChecklistTab({super.key});

  @override
  State<ChecklistTab> createState() => _ChecklistTabState();
}

class _ChecklistTabState extends State<ChecklistTab> {
  final Map<String, bool> checklistItems = {
    'Passport (valid for at least 6 months)': false,
    'Umrah visa (printed copy)': false,
    'Flight tickets (print & digital)': false,
    'Hotel confirmations': false,
    'Travel insurance documents': false,
    'Vaccination certificate (Meningitis)': false,
    'COVID-19 related documents': false,
    'Passport size photographs': false,
    'Emergency contacts list': false,
    'Credit cards & cash (SAR)': false,
    'Prayer mat (lightweight)': false,
    'Quran or digital device': false,
    'Ihram clothing (2 sets)': false,
    'Comfortable footwear': false,
    'Toiletries (travel size)': false,
    'Medications & first aid kit': false,
    'Umbrella for sun protection': false,
    'Water bottle': false,
    'Power bank & chargers': false,
    'Slippers for hotel use': false,
  };
 @override
  void initState() {
    super.initState();
    _loadChecklist();
  }
    /// 🔹 Load saved checklist from local storage
  Future<void> _loadChecklist() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      checklistItems.updateAll((key, value) {
        return prefs.getBool(key) ?? false;
      });
    });
  }

  /// 🔹 Save checklist item when changed
  Future<void> _saveChecklistItem(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }
  double get progressValue {
    int checkedCount = checklistItems.values.where((value) => value).length;
    return checkedCount / checklistItems.length;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Column(
      children: [
        // Progress Section
        Container(
          padding: EdgeInsets.all(isTablet ? 24 : 16),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Preparation Progress',
                    style: TextStyle(
                      fontSize: isTablet ? 18 : 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${(progressValue * 100).toStringAsFixed(0)}% Complete',
                    style: TextStyle(
                      fontSize: isTablet ? 16 : 14,
                      color: AppColors.primaryGreen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progressValue,
                  minHeight: 10,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryGreen),
                ),
              ),
            ],
          ),
        ),
        
        // Checklist Items
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(isTablet ? 20 : 16),
            itemCount: checklistItems.length,
            itemBuilder: (context, index) {
              String item = checklistItems.keys.elementAt(index);
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey[200]!,
                  ),
                ),
                child: CheckboxListTile(
                  title: Text(
                    item,
                    style: TextStyle(
                      fontSize: isTablet ? 16 : 14,
                      fontWeight: FontWeight.w500,
                      decoration: checklistItems[item]!
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: checklistItems[item]!
                          ? Colors.grey
                          : Colors.black87,
                    ),
                  ),
                  value: checklistItems[item],
                  onChanged: (bool? value) {
                    setState(() {
                      checklistItems[item] = value ?? false;
                    });
                       _saveChecklistItem(item, value ?? false);
                  },
                  activeColor: AppColors.primaryGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// Documents Tab
class DocumentsTab extends StatelessWidget {
  final List<Map<String, dynamic>> documents = [
    {
      'title': 'Passport',
      'description': 'Valid for at least 6 months from arrival',
      'icon': Icons.book,
      'color': Colors.blue,
      'status': 'Required',
    },
    {
      'title': 'Umrah Visa',
      'description': 'Multiple entry visa for pilgrimage',
      'icon': FontAwesomeIcons.ccVisa,
      'color': Colors.green,
      'status': 'Required',
    },
    {
      'title': 'Vaccination Certificate',
      'description': 'Meningitis vaccination required',
      'icon': Icons.health_and_safety,
      'color': Colors.orange,
      'status': 'Required',
    },
    {
      'title': 'Flight Tickets',
      'description': 'Round trip booking confirmation',
      'icon': Icons.flight,
      'color': Colors.purple,
      'status': 'Required',
    },
    {
      'title': 'Hotel Vouchers',
      'description': 'Makkah & Madinah accommodation',
      'icon': Icons.hotel,
      'color': Colors.teal,
      'status': 'Required',
    },
    {
      'title': 'Travel Insurance',
      'description': 'Coverage for medical and travel',
      'icon': Icons.health_and_safety,
      'color': Colors.red,
      'status': 'Recommended',
    },
    {
      'title': 'Emergency Contacts',
      'description': 'Local embassy and family contacts',
      'icon': Icons.contact_emergency,
      'color': Colors.amber,
      'status': 'Optional',
    },
  ];

   DocumentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return ListView.builder(
      padding: EdgeInsets.all(isTablet ? 20 : 16),
      itemCount: documents.length,
      itemBuilder: (context, index) {
        final doc = documents[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: doc['color'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    doc['icon'],
                    color: doc['color'],
                    size: isTablet ? 28 : 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AutoSizeText(
                            doc['title'],
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: isTablet ? 16 : 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: doc['status'] == 'Required'
                                  ? Colors.red.withOpacity(0.1)
                                  : doc['status'] == 'Recommended'
                                      ? Colors.orange.withOpacity(0.1)
                                      : Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: AutoSizeText(
                              doc['status'],
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: doc['status'] == 'Required'
                                    ? Colors.red
                                    : doc['status'] == 'Recommended'
                                        ? Colors.orange
                                        : Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        doc['description'],
                        style: TextStyle(
                          fontSize: isTablet ? 12 : 10,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.file_download_outlined,
                  color: AppColors.primaryGreen,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Health & Safety Tab
class HealthSafetyTab extends StatelessWidget {
  final List<Map<String, dynamic>> healthTips = [
    {
      'title': 'Required Vaccinations',
      'tips': [
        'Meningitis (ACWY) vaccine - mandatory',
        'Seasonal flu vaccine - recommended',
        'COVID-19 vaccination - recommended',
        'Hepatitis A & B - recommended',
      ],
      'icon': Icons.vaccines,
      'color': Colors.blue,
    },
    {
      'title': 'First Aid Kit Essentials',
      'tips': [
        'Pain relievers (Paracetamol, Ibuprofen)',
        'Antihistamines for allergies',
        'Digestive medications',
        'Bandages and antiseptic cream',
        'Thermometer',
        'Personal prescription medications',
      ],
      'icon': Icons.medical_services,
      'color': Colors.red,
    },
    {
      'title': 'Health Precautions',
      'tips': [
        'Stay hydrated - drink plenty of water',
        'Use sunscreen and umbrella',
        'Wear comfortable footwear',
        'Get adequate rest between rituals',
        'Maintain hand hygiene',
        'Wear mask in crowded areas',
      ],
      'icon': Icons.health_and_safety,
      'color': Colors.green,
    },
    {
      'title': 'Emergency Numbers',
      'tips': [
        'Emergency - 997',
        'Police - 999',
        'Ambulance - 997',
        'Your country\'s embassy',
      ],
      'icon': Icons.emergency,
      'color': Colors.orange,
    },
  ];

   HealthSafetyTab({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return ListView.builder(
      padding: EdgeInsets.all(isTablet ? 20 : 16),
      itemCount: healthTips.length,
      itemBuilder: (context, index) {
        final tip = healthTips[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ExpansionTile(
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: tip['color'].withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                tip['icon'],
                color: tip['color'],
                size: isTablet ? 24 : 20,
              ),
            ),
            title: Text(
              tip['title'],
              style: TextStyle(
                fontSize: isTablet ? 18 : 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: (tip['tips'] as List).map((item) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 18,
                            color: AppColors.primaryGreen,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              item,
                              style: TextStyle(
                                fontSize: isTablet ? 15 : 13,
                                color: Colors.grey[700],
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Spiritual Prep Tab
class SpiritualPrepTab extends StatelessWidget {
  final List<Map<String, dynamic>> spiritualItems = [
    {
      'title': 'Intention (Niyyah)',
      'content': 'Make sincere intention for Umrah seeking Allah\'s pleasure and forgiveness. Learn about the virtues and rewards of Umrah.',
      'icon': Icons.favorite,
    },
    {
      'title': 'Learn the Rituals',
      'content': 'Study the steps of Umrah: Ihram, Tawaf, Sa\'i, and Halq/Taqsir. Watch educational videos and read guides.',
      'icon': Icons.menu_book,
    },
    {
      'title': 'Important Duas',
      'content': 'Memorize key duas for Umrah: Dua for entering Ihram, during Tawaf, at Multazam, during Sa\'i, and at Rawdah.',
      'icon': Icons.handshake,
    },
    {
      'title': 'Quran Recitation',
      'content': 'Increase Quran recitation before travel. Set goals for completion and understanding of relevant surahs.',
      'icon': Icons.book,
    },
    {
      'title': 'Repentance & Forgiveness',
      'content': 'Seek forgiveness from Allah and from people you may have wronged. Clear your debts and responsibilities.',
      'icon': Icons.volunteer_activism,
    },
    {
      'title': 'Patience & Gratitude',
      'content': 'Prepare mentally for crowds and potential difficulties. Practice patience and maintain positive attitude.',
      'icon': Icons.self_improvement,
    },
  ];

   SpiritualPrepTab({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return ListView.builder(
      padding: EdgeInsets.all(isTablet ? 20 : 16),
      itemCount: spiritualItems.length,
      itemBuilder: (context, index) {
        final item = spiritualItems[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                AppColors.primaryGreen.withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.primaryGreen.withOpacity(0.1),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryGreen.withOpacity(0.05),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primaryGreen.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        item['icon'],
                        color: AppColors.primaryGreen,
                        size: isTablet ? 28 : 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        item['title'],
                        style: TextStyle(
                          fontSize: isTablet ? 18 : 16,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF2C5F2D),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  item['content'],
                  style: TextStyle(
                    fontSize: isTablet ? 15 : 13,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primaryGreen,
                    ),
                    child: const Text('Learn More →'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}