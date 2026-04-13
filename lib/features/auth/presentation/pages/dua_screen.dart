// lib/screens/dua_screen.dart
import 'package:flutter/material.dart';
import '../../../../core/data/dua_data.dart';
import '../../data/models/dua_model.dart';
import '../widgets/dua_card.dart';
// import '../data/dua_data.dart';

class DuaScreen extends StatelessWidget {
  const DuaScreen({super.key});

  final List<String> categories = const [
    'All Duas',
    'Before Umrah',
    'During Tawaf',
    'During Sa\'i',
    'At Kaaba',
    'At Rawdah',
    'Travel Duas',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Duas & Supplications'),
          bottom: TabBar(
            isScrollable: true,
            tabs: categories.map((cat) => Tab(text: cat)).toList(),
            labelColor: const Color(0xFF2C5F2D),
            unselectedLabelColor: Colors.grey,
            indicatorColor: const Color(0xFFE6B566),
          ),
        ),
        body: TabBarView(
          children: categories.map((cat) {
            return DuaList(category: cat == 'All Duas' ? null : cat);
          }).toList(),
        ),
      ),
    );
  }
}

class DuaList extends StatelessWidget {
  final String? category;
  const DuaList({super.key, this.category});

  @override
  Widget build(BuildContext context) {
    List<DuaModel> duas = category == null 
        ? allDuas 
        : allDuas.where((d) => d.category == category).toList();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: duas.length,
      itemBuilder: (context, index) {
        return DuaCard(dua: duas[index]);
      },
    );
  }
}