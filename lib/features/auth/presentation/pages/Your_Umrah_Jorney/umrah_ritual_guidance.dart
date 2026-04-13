// lib/features/auth/presentation/screens/umrah_ritual_guidance_screen.dart
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
// import '../../../../core/utils/colors.dart';

class UmrahRitualGuidanceScreen extends StatefulWidget {
  const UmrahRitualGuidanceScreen({super.key});

  @override
  State<UmrahRitualGuidanceScreen> createState() =>
      _UmrahRitualGuidanceScreenState();
}

class _UmrahRitualGuidanceScreenState extends State<UmrahRitualGuidanceScreen> {
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
          'Umrah Rituals',
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
            // Header Image
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                // image: DecorationImage(
                //   // image: NetworkImage(
                //   //   // 'https://images.unsplash.com/photo-1566288623392-7367a8e7ace7?ixlib=rb-4.0.3',
                //   // ),
                //   fit: BoxFit.cover,
                // ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      const Color(0xFF2C5F2D).withOpacity(0.7),
                    ],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Step by Step Guide',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Learn the sacred rituals of Umrah',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
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
                  // Brief Explanation Cards
                  _buildBriefCard(
                    'Ihram',
                    'The sacred state of purity and intention. Wear special garments and make niyyah.',
                    Icons.man,
                    const Color(0xFF2C5F2D),
                  ),
                  _buildBriefCard(
                    'Tawaf',
                    'Circumambulation of Kaaba 7 times counter-clockwise, starting from Hajr-e-Aswad.',
                    Icons.rotate_right,
                    Colors.blue,
                  ),
                  _buildBriefCard(
                    'Sa\'i',
                    'Walking 7 times between Safa and Marwah hills, commemorating Hajar\'s search for water.',
                    Icons.directions_walk,
                    Colors.orange,
                  ),
                  _buildBriefCard(
                    'Halq/Taqsir',
                    'Shaving or trimming hair to signify completion of Umrah rituals.',
                    Icons.content_cut,
                    Colors.purple,
                  ),

                  const SizedBox(height: 20),

                  // Video Lessons Section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Video Lessons',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2C5F2D),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Select a lesson to watch detailed guidance',
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                        const SizedBox(height: 16),

                        // 11 Video Lesson Cards
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: List.generate(11, (index) {
                            return GestureDetector(
                              onTap: () {
                                _showVideoDialog(context, index + 1);
                              },
                              child: Container(
                                width: (screenWidth - 48) / 5,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 16,
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      const Color(0xFF2C5F2D).withOpacity(0.1),
                                      const Color(0xFF4CAF50).withOpacity(0.05),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: const Color(
                                      0xFF2C5F2D,
                                    ).withOpacity(0.2),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF2C5F2D),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text(
                                        '${index + 1}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Icon(
                                      Icons.play_circle_fill,
                                      color: Color(0xFF2C5F2D),
                                      size: 24,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      _getLessonTitle(index + 1),
                                      style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // PDF Resources
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'PDF Guides',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2C5F2D),
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildPDFItem(
                          'Complete Umrah Guide',
                          'Step by step rituals with duas',
                          'assets/pdfs/umrah_guide.pdf',
                        ),
                        _buildPDFItem(
                          'Essential Duas for Umrah',
                          'Arabic with translation',
                          'assets/pdfs/umrah_duas.pdf',
                        ),
                        _buildPDFItem(
                          'Tawaf & Sa\'i Guide',
                          'Detailed instructions',
                          'assets/pdfs/tawaf_sai.pdf',
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

  Widget _buildBriefCard(
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPDFItem(String title, String description, String path) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.picture_as_pdf,
              color: Colors.red,
              size: 30,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.download, color: Color(0xFF2C5F2D)),
            onPressed: () {
              // Handle PDF download
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Downloading $title...')));
            },
          ),
        ],
      ),
    );
  }

  String _getLessonTitle(int index) {
    const titles = [
      '1.Introduction',
      'Ihram Preparation',
      'Niyyah & Talbiyah',
      'Entering Masjid',
      'Tawaf Part 1',
      'Tawaf Part 2',
      'Maqam Ibrahim',
      'Zamzam Water',
      'Sa\'i Part 1',
      'Sa\'i Part 2',
      'Halq/Taqsir',
    ];
    return titles[index - 1];
  }

  void _showVideoDialog(BuildContext context, int lessonNumber) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(16),
        child: VideoPlayerDialog(lessonNumber: lessonNumber),
      ),
    );
  }
}

// Video Player Dialog
class VideoPlayerDialog extends StatefulWidget {
  final int lessonNumber;
  const VideoPlayerDialog({super.key, required this.lessonNumber});

  @override
  State<VideoPlayerDialog> createState() => _VideoPlayerDialogState();
}

class _VideoPlayerDialogState extends State<VideoPlayerDialog> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  static const videoFiles = [
    '1.Introduction',
    'ihram_preparation',
    'niyyah_talbiyah',
    'entering_masjid',
    'tawaf_part1',
    'tawaf_part2',
    'maqam_ibrahim',
    'zamzam_water',
    'sai_part1',
    'sai_part2',
    'halq_taqsir',
  ];
  @override
@override
void initState() {
  super.initState();

  String videoPath =
      'assets/videos/Umraah_Guidance/${videoFiles[widget.lessonNumber - 1]}.mp4';

  print("Video Path: $videoPath"); // Debug print

  _controller = VideoPlayerController.asset(videoPath);

  _initializeVideoPlayerFuture = _controller.initialize();
  _controller.setLooping(true);
  _controller.setVolume(1.0);

  print("Lesson Number: ${widget.lessonNumber}");
}

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Lesson ${widget.lessonNumber}: ${_getLessonTitle(widget.lessonNumber)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C5F2D),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 16),
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                ),
                onPressed: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.replay_10),
                onPressed: () {
                  final position = _controller.value.position;
                  _controller.seekTo(position - const Duration(seconds: 10));
                },
              ),
              IconButton(
                icon: const Icon(Icons.forward_10),
                onPressed: () {
                  final position = _controller.value.position;
                  _controller.seekTo(position + const Duration(seconds: 10));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getLessonTitle(int index) {
    const titles = [
      'Introduction',
      'Ihram Preparation',
      'Niyyah & Talbiyah',
      'Entering Masjid',
      'Tawaf Part 1',
      'Tawaf Part 2',
      'Maqam Ibrahim',
      'Zamzam Water',
      'Sa\'i Part 1',
      'Sa\'i Part 2',
      'Halq/Taqsir',
    ];
    return titles[index - 1];
  }
}
