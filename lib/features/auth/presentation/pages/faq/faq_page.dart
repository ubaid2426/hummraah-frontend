import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/utils/colors.dart';
// import '../../core/theme/colors.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> allFaqs = [
    {
      "q": "How long does the Umrah Visa processing take?",
      "a":
          "Usually, it takes 3 to 5 working days after submitting all required documents.",
    },
    {
      "q": "What is included in the package price?",
      "a":
          "Visa, hotel accommodation, and transport. Flights & food can be added.",
    },
    {
      "q": "What are the cancellation policies?",
      "a": "15 days before travel: 50% refund. Within 7 days: non-refundable.",
    },
    {
      "q": "Hotels near Haram available?",
      "a": "Yes, elderly-friendly hotels within 200 meters or shuttle service.",
    },
    {
      "q": "Payment options?",
      "a": "Bank transfer, card, or cash. Installments for advance bookings.",
    },
  ];

  List<Map<String, String>> displayedFaqs = [];

  @override
  void initState() {
    super.initState();
    displayedFaqs = allFaqs;
  }

  void _runFilter(String keyword) {
    setState(() {
      displayedFaqs = keyword.isEmpty
          ? allFaqs
          : allFaqs
                .where(
                  (f) => f['q']!.toLowerCase().contains(keyword.toLowerCase()),
                )
                .toList();
    });
  }

  Future<void> _openWhatsApp() async {
    final uri = Uri.parse("https://wa.me/923001234567");
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        title: const Text("Help & Support"),
        centerTitle: true,
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: AppColors.white,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            decoration: BoxDecoration(
              color: AppColors.primaryGreen,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: _runFilter,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.white,
                hintText: "Search FAQ...",
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.primaryGreen,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: displayedFaqs.length,
              itemBuilder: (_, i) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadowBlack.withOpacity(0.05),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: ExpansionTile(
                    maintainState: true,
                    iconColor: AppColors.primaryGold,
                    collapsedIconColor: AppColors.greyText,
                    title: Text(
                      displayedFaqs[i]['q']!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryGreen,
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          displayedFaqs[i]['a']!,
                          style: TextStyle(
                            height: 1.5,
                            color: AppColors.greyText,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.white,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Still need help?\nChat with our team",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkText,
                    ),
                  ),
                ),
                SizedBox(
                  width: 130, // ✅ fixed width
                  height: 45,
                  child: ElevatedButton.icon(
                    onPressed: _openWhatsApp,
                    icon: const Icon(Icons.chat),
                    label: const Text("Chat Now"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGold,
                      foregroundColor: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
