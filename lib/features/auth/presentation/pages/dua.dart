// lib/screens/dua_screen.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:hummraah/core/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/dua_model.dart';
// import '../utils/colors.dart';

// class DuaModel {
//   final String id;
//   final String title;
//   final String arabicText;
//   final String translation;
//   final String transliteration;
//   final String audioUrl;
//   final bool isCustom;

//   DuaModel({
//     required this.id,
//     required this.title,
//     required this.arabicText,
//     required this.translation,
//     required this.transliteration,
//     required this.audioUrl,
//     this.isCustom = false,
//   });

//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'title': title,
//     'arabicText': arabicText,
//     'translation': translation,
//     'transliteration': transliteration,
//     'audioUrl': audioUrl,
//     'isCustom': isCustom,
//   };

//   factory DuaModel.fromJson(Map<String, dynamic> json) => DuaModel(
//     id: json['id'],
//     title: json['title'],
//     arabicText: json['arabicText'],
//     translation: json['translation'],
//     transliteration: json['transliteration'],
//     audioUrl: json['audioUrl'],
//     isCustom: json['isCustom'] ?? false,
//   );
// }

class DuaScreenmain extends StatefulWidget {
  const DuaScreenmain({super.key});

  @override
  State<DuaScreenmain> createState() => _DuaScreenmainState();
}

class _DuaScreenmainState extends State<DuaScreenmain>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<DuaModel> _duas = [];
  List<DuaModel> _customDuas = [];
  final AudioPlayer _audioPlayer = AudioPlayer();
  String _playingId = '';
  bool _isPlaying = false;

  final List<String> _categories = [
    'All Duas',
    'Before Umrah',
    'During Tawaf',
    'During Sa\'i',
    'Custom Duas',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
    _loadDuas();
    _loadCustomDuas();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadDuas() async {
    // Predefined duas
    _duas = [
      DuaModel(
        id: '1',
        title: 'Dua for Entering Masjid',
        titleArabic: 'دعاء دخول المسجد',
        titleUrdu: 'مسجد میں داخل ہونے کی دعا',
        arabicText: 'اللَّهُمَّ افْتَحْ لِي أَبْوَابَ رَحْمَتِكَ',
        translation: 'O Allah, open for me the doors of Your mercy',
        transliteration: 'Allahumma iftah li abwaba rahmatik',
        urduTranslation: 'اے اللہ! میرے لیے اپنی رحمت کے دروازے کھول دے',
        audioUrl: '',
        category: 'Masjid',
        isOffline: true,
        times: 1,
        reference: 'Sahih Muslim',
      ),

      DuaModel(
        id: '2',
        title: 'Dua at Seeing Kaaba',
        titleArabic: 'دعاء عند رؤية الكعبة',
        titleUrdu: 'کعبہ کو دیکھنے کی دعا',
        arabicText: 'اللَّهُمَّ زِدْ هَذَا الْبَيْتَ تَشْرِيفًا وَتَعْظِيمًا',
        translation: 'O Allah, increase this House in honor and veneration',
        transliteration: 'Allahumma zid hadhal bayta tashrifan wa ta\'ziman',
        urduTranslation: 'اے اللہ! اس گھر کی عزت اور عظمت میں اضافہ فرما',
        audioUrl: '',
        category: 'Hajj/Umrah',
        isOffline: true,
        times: 1,
        reference: 'Hadith',
      ),

      DuaModel(
        id: '3',
        title: 'Dua for Tawaf',
        titleArabic: 'دعاء الطواف',
        titleUrdu: 'طواف کی دعا',
        arabicText:
            'رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الْآخِرَةِ حَسَنَةً',
        translation:
            'Our Lord, give us in this world good and in the Hereafter good',
        transliteration:
            'Rabbana atina fid dunya hasanatan wa fil akhirati hasanatan',
        urduTranslation: 'اے ہمارے رب! ہمیں دنیا اور آخرت میں بھلائی عطا فرما',
        audioUrl: '',
        category: 'Tawaf',
        isOffline: true,
        times: 7,
        reference: 'Quran 2:201',
      ),

      DuaModel(
        id: '4',
        title: 'Dua for Drinking Zamzam',
        titleArabic: 'دعاء شرب زمزم',
        titleUrdu: 'زمزم پینے کی دعا',
        arabicText:
            'اللَّهُمَّ إِنِّي أَسْأَلُكَ عِلْمًا نَافِعًا وَرِزْقًا وَاسِعًا',
        translation:
            'O Allah, I ask You for beneficial knowledge and abundant provision',
        transliteration:
            'Allahumma inni as’aluka ilman nafi’an wa rizqan wasi’an',
        urduTranslation:
            'اے اللہ! میں تجھ سے نفع دینے والا علم اور کشادہ رزق مانگتا ہوں',
        audioUrl: '',
        category: 'Zamzam',
        isOffline: true,
        times: 1,
        reference: 'Ibn Majah',
      ),

      DuaModel(
        id: '5',
        title: 'Dua for Safa & Marwah',
        titleArabic: 'دعاء الصفا والمروة',
        titleUrdu: 'صفا اور مروہ کی دعا',
        arabicText: 'إِنَّ الصَّفَا وَالْمَرْوَةَ مِن شَعَائِرِ اللَّهِ',
        translation: 'Indeed, Safa and Marwah are among the symbols of Allah',
        transliteration: 'Inna as-safa wal marwata min sha’a’irillah',
        urduTranslation: 'بیشک صفا اور مروہ اللہ کی نشانیوں میں سے ہیں',
        audioUrl: '',
        category: 'Sa’i',
        isOffline: true,
        times: 7,
        reference: 'Quran 2:158',
      ),
    ];
    setState(() {});
  }

  Future<void> _loadCustomDuas() async {
    final prefs = await SharedPreferences.getInstance();
    final customDuasJson = prefs.getString('custom_duas');
    if (customDuasJson != null) {
      List<dynamic> decoded = json.decode(customDuasJson);
      _customDuas = decoded.map((d) => DuaModel.fromJson(d)).toList();
      setState(() {});
    }
  }

  Future<void> _saveCustomDuas() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = json.encode(_customDuas.map((d) => d.toJson()).toList());
    await prefs.setString('custom_duas', encoded);
  }

  Future<void> _addCustomDua() async {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController arabicController = TextEditingController();
    final TextEditingController translationController = TextEditingController();
    final TextEditingController transliterationController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Your Own Dua'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: arabicController,
                decoration: const InputDecoration(labelText: 'Arabic Text'),
                maxLines: 3,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: translationController,
                decoration: const InputDecoration(labelText: 'Translation'),
                maxLines: 2,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: transliterationController,
                decoration: const InputDecoration(labelText: 'Transliteration'),
                maxLines: 2,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                final newDua = DuaModel(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  title: titleController.text,
                  titleArabic: titleController.text, // or separate controller
                  titleUrdu: titleController.text, // optional
                  arabicText: arabicController.text,
                  translation: translationController.text,
                  transliteration: transliterationController.text,
                  urduTranslation: translationController.text,
                  audioUrl: '',
                  category: 'Custom',
                  isOffline: true,
                  times: 1,
                  reference: 'User Added',
                  isCustom: true,
                );
                _customDuas.add(newDua);
                _saveCustomDuas();
                setState(() {});
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryGreen,
            ),
            child: const Text('Add Dua'),
          ),
        ],
      ),
    );
  }

  Future<void> _playAudio(String audioUrl, String id) async {
    if (_playingId == id && _isPlaying) {
      await _audioPlayer.pause();
      setState(() {
        _isPlaying = false;
      });
    } else {
      // For demo, use a local asset or network audio
      // await _audioPlayer.play(UrlSource(audioUrl));
      // For demo purposes, we'll simulate audio
      setState(() {
        _playingId = id;
        _isPlaying = true;
      });
    }
  }

  void _deleteCustomDua(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Dua'),
        content: const Text('Are you sure you want to delete this dua?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              _customDuas.removeWhere((d) => d.id == id);
              _saveCustomDuas();
              setState(() {});
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Duas & Supplications'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: _categories.map((cat) => Tab(text: cat)).toList(),
          labelColor: AppColors.primaryGreen,
          unselectedLabelColor: Colors.grey,
          indicatorColor: AppColors.primaryGold,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded),
            onPressed: _addCustomDua,
            tooltip: 'Add Custom Dua',
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDuaList(_duas + _customDuas),
          _buildDuaList(
            _duas
                .where(
                  (d) =>
                      d.title.contains('Entering') || d.title.contains('Umrah'),
                )
                .toList(),
          ),
          _buildDuaList(_duas.where((d) => d.title.contains('Tawaf')).toList()),
          _buildDuaList(_duas.where((d) => d.title.contains('Sa\'i')).toList()),
          _buildDuaList(_customDuas, showDelete: true),
        ],
      ),
    );
  }

  Widget _buildDuaList(List<DuaModel> duas, {bool showDelete = false}) {
    if (duas.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.menu_book_rounded, size: 80, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text(
              'No duas added yet',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            if (showDelete)
              ElevatedButton(
                onPressed: _addCustomDua,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryGreen,
                ),
                child: const Text('Add Your First Dua'),
              ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: duas.length,
      itemBuilder: (context, index) {
        final dua = duas[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
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
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primaryGreen.withOpacity(0.05),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.primaryGreen.withOpacity(0.1),
                        shape: BoxShape.circle,
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
                          if (dua.isCustom)
                            Container(
                              margin: const EdgeInsets.only(top: 4),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryGold.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                'Custom',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xFFE6B566),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (showDelete)
                      IconButton(
                        icon: const Icon(
                          Icons.delete_outline_rounded,
                          color: Colors.red,
                        ),
                        onPressed: () => _deleteCustomDua(dua.id),
                      ),
                  ],
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (dua.arabicText.isNotEmpty)
                      Text(
                        dua.arabicText,
                        style: const TextStyle(
                          fontSize: 22,
                          fontFamily: 'Amiri',
                          height: 1.8,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    if (dua.arabicText.isNotEmpty) const SizedBox(height: 16),
                    if (dua.transliteration.isNotEmpty)
                      Text(
                        dua.transliteration,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[700],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    if (dua.transliteration.isNotEmpty)
                      const SizedBox(height: 12),
                    if (dua.translation.isNotEmpty)
                      Text(
                        dua.translation,
                        style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                      ),
                    const SizedBox(height: 16),

                    // Audio Controls
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => _playAudio(dua.audioUrl, dua.id),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: _playingId == dua.id && _isPlaying
                                  ? AppColors.primaryGreen
                                  : AppColors.primaryGreen.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  _playingId == dua.id && _isPlaying
                                      ? Icons.pause_rounded
                                      : Icons.play_arrow_rounded,
                                  color: _playingId == dua.id && _isPlaying
                                      ? Colors.white
                                      : AppColors.primaryGreen,
                                  size: 18,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _playingId == dua.id && _isPlaying
                                      ? 'Pause'
                                      : 'Listen',
                                  style: TextStyle(
                                    color: _playingId == dua.id && _isPlaying
                                        ? Colors.white
                                        : AppColors.primaryGreen,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () {
                            // Share functionality
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.primaryGold.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.share_rounded,
                              color: AppColors.primaryGold,
                              size: 18,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryGold.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Text(
                            'Read 1x',
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFFE6B566),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
