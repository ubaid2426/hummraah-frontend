import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../book_your_umrah.dart';

class HeaderSection extends StatefulWidget {
  final Function(int) onLinkTap;

  const HeaderSection({super.key, required this.onLinkTap});

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  int _selectedTab = 0;
  int _travelers = 2;
  String _travelClass = "Business";
  DateTimeRange _dateRange = DateTimeRange(
    start: DateTime.now().add(const Duration(days: 1)),
    end: DateTime.now().add(const Duration(days: 10)),
  );

  String _formatDate(DateTime date) {
    const List<String> months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    return "${date.day.toString().padLeft(2, '0')} ${months[date.month - 1]}, ${date.year}";
  }

  void _pickTravelers() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Select Travelers",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  final count = index + 1;
                  return ListTile(
                    leading: const Icon(Icons.person, color: Color(0xFF004D40)),
                    title: Text("$count Person(s)"),
                    onTap: () {
                      setState(() => _travelers = count);
                      Navigator.pop(context);
                    },
                    selected: _travelers == count,
                    selectedTileColor: const Color(0xFF004D40).withOpacity(0.1),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void _pickClass() {
    final List<String> classes = [
      "Economy",
      "Business",
      "First Class",
      "Royal",
    ];
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Select Class",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ...classes.map(
              (c) => ListTile(
                leading: const Icon(
                  Icons.airline_seat_recline_extra_rounded,
                  color: Color(0xFF004D40),
                ),
                title: Text(c),
                onTap: () {
                  setState(() => _travelClass = c);
                  Navigator.pop(context);
                },
                trailing: _travelClass == c
                    ? const Icon(Icons.check_circle, color: Color(0xFF004D40))
                    : null,
              ),
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }

  Future<void> _pickDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      initialDateRange: _dateRange,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xFF004D40),
            colorScheme: const ColorScheme.light(primary: Color(0xFF004D40)),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _dateRange = picked;
      });
    }
  }

  void _showAwesomeModal() {
    String selectedTabName = "";
    switch (_selectedTab) {
      case 0:
        selectedTabName = "Umrah";
        break;
      case 1:
        selectedTabName = "Hajj";
        break;
      case 2:
        selectedTabName = "Noble Rawdah";
        break;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.6),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (BuildContext context) {
        return AwesomeBookingModal(
          travelers: _travelers,
          travelClass: _travelClass,
          checkInDate: _dateRange.start,
          checkOutDate: _dateRange.end,
          selectedTab: selectedTabName,
          formatDate: _formatDate,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Container(
      height: 350,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tabs
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F7F9),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Row(
              children: [
                _buildTabBtn("Umrah", 0),
                _buildTabBtn("Hajj", 1),
                _buildTabBtn("Noble Rawdah", 2),
              ],
            ),
          ),
          const SizedBox(height: 25),

          // Travelers and Class Row
          Row(
            children: [
              _buildInputItem(
                icon: Icons.person_outline_rounded,
                label: "Travelers",
                value: "$_travelers Person(s)",
                onTap: _pickTravelers,
              ),
              const SizedBox(width: 15),
              _buildInputItem(
                icon: Icons.airline_seat_recline_extra_rounded,
                label: "Class",
                value: _travelClass,
                onTap: _pickClass,
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Check-In and Check-Out Row
          Row(
            children: [
              _buildInputItem(
                icon: Icons.calendar_today_rounded,
                label: "Check-In",
                value: _formatDate(_dateRange.start),
                onTap: _pickDateRange,
              ),
              const SizedBox(width: 15),
              _buildInputItem(
                icon: Icons.calendar_today_rounded,
                label: "Check-Out",
                value: _formatDate(_dateRange.end),
                onTap: _pickDateRange,
              ),
            ],
          ),
          const SizedBox(height: 30),

          // Search Button
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: _showAwesomeModal,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF004D40),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text(
                "Search Package",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBtn(String title, int index) {
    bool isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF004D40) : Colors.transparent,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[600],
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputItem({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey[200]!, width: 1.5),
                ),
              ),
              child: Row(
                children: [
                  Icon(icon, size: 20, color: const Color(0xFF004D40)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 18,
                    color: Colors.grey[400],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Awesome Booking Modal
class AwesomeBookingModal extends StatefulWidget {
  final int travelers;
  final String travelClass;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final String selectedTab;
  final String Function(DateTime) formatDate;

  const AwesomeBookingModal({
    super.key,
    required this.travelers,
    required this.travelClass,
    required this.checkInDate,
    required this.checkOutDate,
    required this.selectedTab,
    required this.formatDate,
  });

  @override
  State<AwesomeBookingModal> createState() => _AwesomeBookingModalState();
}

class _AwesomeBookingModalState extends State<AwesomeBookingModal>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _slideAnimation = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _calculatePrice() {
    int basePrice = 49999;

    if (widget.selectedTab == "Hajj") basePrice = 84999;
    if (widget.selectedTab == "Noble Rawdah") basePrice = 64999;

    if (widget.travelClass == "Business") basePrice = (basePrice * 1.8).toInt();
    if (widget.travelClass == "First Class") basePrice = basePrice * 3;
    if (widget.travelClass == "Royal") basePrice = basePrice * 5;

    basePrice = basePrice * widget.travelers;

    final formatter = NumberFormat('#,###', 'en_US');
    return 'Rs. ${formatter.format(basePrice)}';
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            0,
            _slideAnimation.value * MediaQuery.of(context).size.height,
          ),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Drag Handle
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    width: 50,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),

                  // Close Button
                  Padding(
                    padding: const EdgeInsets.only(right: 16, top: 8),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            size: 20,
                            color: Color(0xFF004D40),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Title Section
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const Text(
                          "And Umrah Journey",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF004D40),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF004D40).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            widget.selectedTab,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF004D40),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Tabs (Static display)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F7F9),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Row(
                      children: [
                        _buildModalTab("Umrah", widget.selectedTab == "Umrah"),
                        _buildModalTab("Hajj", widget.selectedTab == "Hajj"),
                        _buildModalTab(
                          "Noble Rawdah",
                          widget.selectedTab == "Noble Rawdah",
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Info Cards
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        // Travelers Card
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF004D40).withOpacity(0.05),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Icon(
                                  Icons.person_outline,
                                  size: 24,
                                  color: Color(0xFF004D40),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Travelers",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "${widget.travelers} Person(s)",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  widget.travelClass,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF004D40),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Dates Card
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF004D40).withOpacity(0.05),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Icon(
                                  Icons.calendar_today,
                                  size: 24,
                                  color: Color(0xFF004D40),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Check-In",
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            widget.formatDate(
                                              widget.checkInDate,
                                            ),
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 30,
                                      height: 1,
                                      color: Colors.grey[300],
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          const Text(
                                            "Check-Out",
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            widget.formatDate(
                                              widget.checkOutDate,
                                            ),
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black87,
                                            ),
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
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Price Section
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFF004D40),
                          const Color(0xFF00695C),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF004D40).withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Total Package Price",
                          style: TextStyle(fontSize: 13, color: Colors.white70),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _calculatePrice(),
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "per person • all inclusive",
                            style: TextStyle(fontSize: 11, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Features
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: [
                        _buildFeatureChip(Icons.hotel, "Hotel"),
                        _buildFeatureChip(Icons.restaurant, "Meals"),
                        _buildFeatureChip(Icons.directions_bus, "Transport"),
                        _buildFeatureChip(Icons.assignment, "Visa"),
                        _buildFeatureChip(Icons.medical_services, "Insurance"),
                        _buildFeatureChip(Icons.support_agent, "Support"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Action Buttons
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF004D40),
                              side: const BorderSide(
                                color: Color(0xFF004D40),
                                width: 1.5,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: const Text(
                              "Cancel",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "✨ Booking confirmed for ${widget.selectedTab} Package!",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: const Color(0xFF004D40),
                                  behavior: SnackBarBehavior.floating,
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BookYourUmrahScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF004D40),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              "Book Now",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildModalTab(String title, bool isSelected) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF004D40) : Colors.transparent,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[600],
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureChip(IconData icon, String label) {
    return Container(
      // height: 500,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: const Color(0xFF004D40)),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF004D40),
            ),
          ),
        ],
      ),
    );
  }
}

class SmilePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = const Color(0xFFFFC107)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    var path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(size.width * 0.5, size.height + 5, size.width, -2);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
