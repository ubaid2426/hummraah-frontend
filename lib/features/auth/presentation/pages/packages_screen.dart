// lib/features/auth/presentation/screens/packages_screen.dart
import 'package:flutter/material.dart';
import '../../../../core/data/packages_data.dart';
import '../../data/models/package_model.dart';
import '../widgets/package_card.dart';

class PackagesScreen extends StatefulWidget {
  const PackagesScreen({super.key});

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> packageTypes = [
    'All',
    'Premium',
    'Economy',
    'Family',
    'Individual',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: packageTypes.length, vsync: this);
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
        title: Text(
          'Umrah Packages',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: isTablet ? 28 : 20,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: const Color(0xFF2C5F2D),
              unselectedLabelColor: Colors.grey,
              indicatorColor: const Color(0xFFE6B566),
              indicatorWeight: 3,
              labelStyle: TextStyle(
                fontSize: isTablet ? 16 : 14,
                fontWeight: FontWeight.w600,
              ),
              tabs: packageTypes.map((type) => Tab(text: type)).toList(),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: packageTypes.map((type) {
          return PackageList(type: type == 'All' ? null : type);
        }).toList(),
      ),
    );
  }
}

class PackageList extends StatelessWidget {
  final String? type;
  const PackageList({super.key, this.type});

  @override
  Widget build(BuildContext context) {
    List<PackageModel> packages = type == null
        ? allPackages
        : allPackages.where((p) => p.type == type).toList();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: packages.length,
      itemBuilder: (context, index) {
        return PackageCard(package: packages[index]);
      },
    );
  }
}