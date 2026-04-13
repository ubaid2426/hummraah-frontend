import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class BookYourUmrahScreen extends StatefulWidget {
  const BookYourUmrahScreen({super.key});

  @override
  State<BookYourUmrahScreen> createState() => _BookYourUmrahScreenState();
}

class _BookYourUmrahScreenState extends State<BookYourUmrahScreen> {
  // Data from JSON
  Map<String, dynamic> travelData = {};
  List<dynamic> airlines = [];
  List<dynamic> ziyaratPackages = [];

  // Form data
  DateTime? startDate;
  DateTime? endDate;
  String? stayDuration;
  int adults = 1;
  int children = 0;
  int infants = 0;

  String selectedPackageType = 'economy';
  String selectedHotelDistance = 'walking (within 500m)';
  String selectedRoomType = 'quad sharing';
  bool mealIncluded = false;
  bool transportFlightIncluded = false;
  String? selectedAirline;
  String selectedTransportType = 'shared bus';
  bool ziyaratIncluded = false;
  List<dynamic> selectedZiyaratPackages = [];

  // Airport selection
  String selectedDepartureAirport = '';
  String selectedDestinationAirport = '';

  // Package options with details
  final List<Map<String, dynamic>> packageTypes = [
    {
      'value': 'economy',
      'label': 'Economy',
      'icon': Icons.attach_money,
      'color': Colors.blue,
      'price': '',
      'features': ['Basic amenities', '3-star hotel', 'Shared transport'],
    },
    {
      'value': 'standard',
      'label': 'Standard',
      'icon': Icons.star,
      'color': Colors.green,
      'price': '',
      'features': [
        'Standard amenities',
        '4-star hotel',
        'Private transport',
        'Daily breakfast',
      ],
    },
    {
      'value': 'business',
      'label': 'Business',
      'icon': Icons.business_center,
      'color': Colors.orange,
      'price': '',
      'features': [
        'Premium amenities',
        '5-star hotel',
        'VIP transport',
        'All meals included',
      ],
    },
    {
      'value': 'vvip',
      'label': 'VVIP',
      'icon': Icons.workspace_premium,
      'color': Colors.red,
      'price': '',
      'features': [
        'Luxury amenities',
        '5-star deluxe hotel',
        'Luxury car',
        'All meals + VIP access',
      ],
    },
  ];

  final List<Map<String, dynamic>> hotelDistances = [
    {
      'value': 'walking (within 500m)',
      'label': 'Walking Distance',
      'icon': Icons.directions_walk,
      'color': Colors.green,
      'time': '< 5 mins',
    },
    {
      'value': '5min walk',
      'label': '5 Minutes Walk',
      'icon': Icons.timer,
      'color': Colors.lightGreen,
      'time': '5 mins',
    },
    {
      'value': '10min walk',
      'label': '10 Minutes Walk',
      'icon': Icons.timer,
      'color': Colors.amber,
      'time': '10 mins',
    },
    {
      'value': '15min drive',
      'label': '15 Minutes Drive',
      'icon': Icons.directions_car,
      'color': Colors.orange,
      'time': '15 mins',
    },
    {
      'value': '20min drive',
      'label': '20 Minutes Drive',
      'icon': Icons.directions_car,
      'color': Colors.red,
      'time': '20 mins',
    },
  ];

  final List<Map<String, dynamic>> roomTypes = [
    {
      'value': 'quad sharing',
      'label': 'Quad Sharing',
      'icon': Icons.people,
      'color': Colors.teal,
      'capacity': '4 persons',
      'price': '',
    },
    {
      'value': 'triple sharing',
      'label': 'Triple Sharing',
      'icon': Icons.people_outline,
      'color': Colors.cyan,
      'capacity': '3 persons',
      'price': '',
    },
    {
      'value': 'double room',
      'label': 'Double Room',
      'icon': Icons.bed,
      'color': Colors.blue,
      'capacity': '2 persons',
      'price': '',
    },
    {
      'value': 'single room',
      'label': 'Single Room',
      'icon': Icons.person,
      'color': Colors.indigo,
      'capacity': '1 person',
      'price': '',
    },
    {
      'value': 'suite room',
      'label': 'Suite Room',
      'icon': Icons.bedroom_parent,
      'color': Colors.purple,
      'capacity': '2-4 persons',
      'price': '',
    },
    {
      'value': 'deluxe room',
      'label': 'Deluxe Room',
      'icon': Icons.five_k,
      'color': Colors.pink,
      'capacity': '2 persons',
      'price': '',
    },
  ];

  final List<Map<String, dynamic>> transportTypes = [
    {
      'value': 'shared bus',
      'label': 'Shared Bus',
      'icon': Icons.directions_bus,
      'color': Colors.blue,
      'price': 'Free',
      'description': 'Economical option with group transport',
    },
    {
      'value': 'private car',
      'label': 'Private Car',
      'icon': Icons.car_rental,
      'color': Colors.green,
      'price': '',
      'description': 'Private vehicle for your group',
    },
    {
      'value': 'luxury van',
      'label': 'Luxury Van',
      'icon': Icons.airport_shuttle,
      'color': Colors.orange,
      'price': '',
      'description': 'Premium comfort with extra space',
    },
  ];

  // Airport lists
  final List<Map<String, String>> pakistanAirports = [
    {
      'code': 'ISB',
      'name': 'Islamabad International Airport',
      'city': 'Islamabad',
      'image': '🇵🇰',
    },
    {
      'code': 'LHE',
      'name': 'Allama Iqbal International Airport',
      'city': 'Lahore',
      'image': '🇵🇰',
    },
    {
      'code': 'KHI',
      'name': 'Jinnah International Airport',
      'city': 'Karachi',
      'image': '🇵🇰',
    },
    {
      'code': 'PEW',
      'name': 'Bacha Khan International Airport',
      'city': 'Peshawar',
      'image': '🇵🇰',
    },
    {
      'code': 'UET',
      'name': 'Quetta International Airport',
      'city': 'Quetta',
      'image': '🇵🇰',
    },
    {
      'code': 'SKT',
      'name': 'Sialkot International Airport',
      'city': 'Sialkot',
      'image': '🇵🇰',
    },
    {
      'code': 'MUX',
      'name': 'Multan International Airport',
      'city': 'Multan',
      'image': '🇵🇰',
    },
  ];

  final List<Map<String, String>> saudiAirports = [
    {
      'code': 'JED',
      'name': 'King Abdulaziz International Airport',
      'city': 'Jeddah',
      'image': '🇸🇦',
    },
    {
      'code': 'MED',
      'name': 'Prince Mohammad bin Abdulaziz Airport',
      'city': 'Madinah',
      'image': '🇸🇦',
    },
    {
      'code': 'RUH',
      'name': 'King Khalid International Airport',
      'city': 'Riyadh',
      'image': '🇸🇦',
    },
    {
      'code': 'DMM',
      'name': 'King Fahd International Airport',
      'city': 'Dammam',
      'image': '🇸🇦',
    },
  ];

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    try {
      String travelJsonString = await rootBundle.loadString(
        'assets/json/travel_data.json',
      );
      Map<String, dynamic> travelJson = json.decode(travelJsonString);

      String airlinesJsonString = await rootBundle.loadString(
        'assets/json/airlines.json',
      );
      List<dynamic> airlinesJson = json.decode(airlinesJsonString);

      String ziyaratJsonString = await rootBundle.loadString(
        'assets/json/ziyarat.json',
      );
      List<dynamic> ziyaratJson = json.decode(ziyaratJsonString);

      setState(() {
        travelData = travelJson;
        airlines = airlinesJson;
        ziyaratPackages = ziyaratJson;
      });
    } catch (e) {
      print('Error loading JSON: $e');
    }
  }

  void showSelectionModal({
    required String title,
    required String subtitle,
    required List<Map<String, dynamic>> items,
    required String currentValue,
    required Function(String) onSelected,
    required IconData headerIcon,
    required Color headerColor,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateModal) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 4,
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: headerColor.withOpacity(0.1),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: headerColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Icon(headerIcon, color: headerColor, size: 28),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: headerColor,
                                ),
                              ),
                              Text(
                                subtitle,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                          color: headerColor,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        final isSelected = currentValue == item['value'];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            gradient: isSelected
                                ? LinearGradient(
                                    colors: [
                                      headerColor.withOpacity(0.1),
                                      Colors.white,
                                    ],
                                  )
                                : null,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: isSelected
                                  ? headerColor
                                  : Colors.grey.shade300,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: ListTile(
                            onTap: () {
                              onSelected(item['value']);
                              Navigator.pop(context);
                            },
                            leading: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color:
                                    (item['color'] as Color?)?.withOpacity(
                                      0.2,
                                    ) ??
                                    headerColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                item['icon'],
                                color: item['color'] ?? headerColor,
                                size: 24,
                              ),
                            ),
                            title: Text(
                              item['label'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: isSelected ? headerColor : Colors.black,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (item.containsKey('price'))
                                  Text(
                                    'Price: ${item['price']}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                if (item.containsKey('capacity'))
                                  Text(
                                    'Capacity: ${item['capacity']}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                if (item.containsKey('time'))
                                  Text(
                                    'Time: ${item['time']}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                if (item.containsKey('description'))
                                  Text(
                                    item['description'],
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                if (item.containsKey('features'))
                                  ...(item['features'] as List)
                                      .map(
                                        (feature) => Padding(
                                          padding: const EdgeInsets.only(
                                            top: 4,
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.check_circle,
                                                size: 12,
                                                color: Colors.green,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                feature,
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.grey.shade600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                      .toList(),
                              ],
                            ),
                            trailing: isSelected
                                ? Icon(
                                    Icons.check_circle,
                                    color: headerColor,
                                    size: 28,
                                  )
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void showAirlineSelectionModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateModal) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 4,
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(
                            Icons.airplanemode_active,
                            color: Colors.blue,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Select Airline',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              Text(
                                'Choose your preferred airline',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: airlines.length,
                      itemBuilder: (context, index) {
                        final airline = airlines[index];
                        final isSelected = selectedAirline == airline['name'];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            gradient: isSelected
                                ? LinearGradient(
                                    colors: [
                                      Colors.blue.withOpacity(0.1),
                                      Colors.white,
                                    ],
                                  )
                                : null,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.blue
                                  : Colors.grey.shade300,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: ListTile(
                            onTap: () {
                              setState(() {
                                selectedAirline = airline['name'];
                              });
                              Navigator.pop(context);
                            },
                            leading: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                airline['code'] ??
                                    airline['name'].toString().substring(0, 2),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            title: Text(
                              airline['name'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: isSelected ? Colors.blue : Colors.black,
                              ),
                            ),
                            trailing: isSelected
                                ? const Icon(
                                    Icons.check_circle,
                                    color: Colors.blue,
                                    size: 28,
                                  )
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void showSuccessModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green.shade50,
                ),
                child: Icon(
                  Icons.check_circle,
                  color: Colors.green.shade600,
                  size: 70,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Booking Submitted Successfully!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                'Your Umrah package has been booked',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.teal.shade50, Colors.teal.shade100],
                  ),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.teal.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Booking Summary',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    const Divider(),
                    const SizedBox(height: 8),
                    _buildSummaryRow(
                      Icons.flight_takeoff,
                      'Departure',
                      travelData['departure_city'] ?? 'Not selected',
                    ),
                    _buildSummaryRow(
                      Icons.flight_land,
                      'Destination',
                      travelData['destination_city'] ?? 'Not selected',
                    ),
                    _buildSummaryRow(
                      Icons.people,
                      'Pilgrims',
                      '$adults Adults, $children Children',
                    ),
                    _buildSummaryRow(
                      Icons.card_travel,
                      'Package',
                      selectedPackageType.toUpperCase(),
                    ),
                    _buildSummaryRow(
                      Icons.bed,
                      'Room Type',
                      selectedRoomType.toUpperCase(),
                    ),
                    _buildSummaryRow(
                      Icons.hotel,
                      'Stay',
                      stayDuration ?? 'Not selected',
                    ),
                    if (transportFlightIncluded)
                      _buildSummaryRow(
                        Icons.flight,
                        'Airline',
                        selectedAirline ?? 'Not selected',
                      ),
                    _buildSummaryRow(
                      Icons.directions_bus,
                      'Transport',
                      selectedTransportType.toUpperCase(),
                    ),
                    if (ziyaratIncluded)
                      _buildSummaryRow(
                        Icons.temple_hindu,
                        'Ziyarat',
                        '${selectedZiyaratPackages.length} packages selected',
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal.shade700,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Close',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.teal.shade600),
          const SizedBox(width: 12),
          Text(
            '$label:',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  void showAirportSelectionModal(bool isDeparture) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final airports = isDeparture ? pakistanAirports : saudiAirports;
        final title = isDeparture
            ? 'Select Departure Airport'
            : 'Select Destination Airport';
        final subtitle = isDeparture
            ? 'Choose your departure city in Pakistan'
            : 'Choose your destination in Saudi Arabia';
        final icon = isDeparture ? Icons.flight_takeoff : Icons.flight_land;
        final color = isDeparture ? Colors.orange : Colors.green;

        return StatefulBuilder(
          builder: (context, setStateModal) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 4,
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Icon(icon, color: color, size: 28),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: color,
                                ),
                              ),
                              Text(
                                subtitle,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                          color: color,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: airports.length,
                      itemBuilder: (context, index) {
                        final airport = airports[index];
                        final isSelected = isDeparture
                            ? selectedDepartureAirport == airport['code']
                            : selectedDestinationAirport == airport['code'];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            gradient: isSelected
                                ? LinearGradient(
                                    colors: [
                                      color.withOpacity(0.1),
                                      Colors.white,
                                    ],
                                  )
                                : null,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: isSelected ? color : Colors.grey.shade300,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: ListTile(
                            onTap: () {
                              setState(() {
                                if (isDeparture) {
                                  selectedDepartureAirport = airport['code']!;
                                  travelData['departure_city'] =
                                      '${airport['city']} (${airport['code']})';
                                } else {
                                  selectedDestinationAirport = airport['code']!;
                                  travelData['destination_city'] =
                                      '${airport['city']} (${airport['code']})';
                                }
                              });
                              Navigator.pop(context);
                            },
                            leading: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: color.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                airport['image']!,
                                style: const TextStyle(fontSize: 24),
                              ),
                            ),
                            title: Text(
                              airport['name']!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: isSelected ? color : Colors.black,
                              ),
                            ),
                            subtitle: Text(
                              '${airport['city']} • ${airport['code']}',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            trailing: isSelected
                                ? Icon(
                                    Icons.check_circle,
                                    color: color,
                                    size: 28,
                                  )
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void showDateSelectionModal(bool isStartDate) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        DateTime tempDate = isStartDate
            ? (startDate ?? DateTime.now())
            : (endDate ?? startDate ?? DateTime.now());

        return StatefulBuilder(
          builder: (context, setStateModal) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 4,
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.teal.shade100,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Icon(
                            Icons.calendar_today,
                            color: Colors.teal.shade800,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isStartDate
                                    ? 'Select Start Date'
                                    : 'Select End Date',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal,
                                ),
                              ),
                              Text(
                                isStartDate
                                    ? 'Choose your journey start date'
                                    : 'Choose your journey end date',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: CalendarDatePicker(
                      initialDate: tempDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                      onDateChanged: (date) {
                        setStateModal(() {
                          tempDate = date;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.grey,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Cancel'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (isStartDate) {
                                  startDate = tempDate;
                                } else {
                                  endDate = tempDate;
                                }
                                calculateDuration();
                              });
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal.shade700,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Confirm'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void showZiyaratSelectionModal() {
    List<dynamic> tempSelected = List.from(selectedZiyaratPackages);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateModal) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 4,
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.purple.shade100,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Icon(
                            Icons.temple_hindu,
                            color: Colors.purple.shade800,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Select Ziyarat Packages',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple,
                                ),
                              ),
                              Text(
                                'Choose the spiritual sites you want to visit',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                          color: Colors.purple,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: ziyaratPackages.length,
                      itemBuilder: (context, index) {
                        final package = ziyaratPackages[index];
                        final isSelected = tempSelected.contains(package);

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            gradient: isSelected
                                ? LinearGradient(
                                    colors: [
                                      Colors.purple.shade50,
                                      Colors.white,
                                    ],
                                  )
                                : null,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.purple
                                  : Colors.grey.shade300,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: CheckboxListTile(
                            contentPadding: const EdgeInsets.all(12),
                            title: Text(
                              package['name'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: isSelected
                                    ? Colors.purple
                                    : Colors.black,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(package['description'] ?? ''),
                                const SizedBox(height: 4),
                                Text(
                                  '\$${package['price']} per person',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal.shade600,
                                  ),
                                ),
                              ],
                            ),
                            value: isSelected,
                            onChanged: (bool? value) {
                              setStateModal(() {
                                if (value == true) {
                                  tempSelected.add(package);
                                } else {
                                  tempSelected.remove(package);
                                }
                              });
                            },
                            activeColor: Colors.purple,
                            controlAffinity: ListTileControlAffinity.trailing,
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.grey,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Cancel'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                selectedZiyaratPackages = tempSelected;
                              });
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple.shade700,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Apply'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Book Your Umrah',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal.shade700, Colors.teal.shade900],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.teal.shade50, Colors.teal.shade100, Colors.white],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.teal.shade700, Colors.teal.shade900],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal.shade200,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
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
                        Icons.umbrella,
                        color: Colors.teal,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 15),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Spiritual Journey of a Lifetime',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1,
                            ),
                          ),
                          Text(
                            'Trusted by 10,000+ Pilgrims • 4.9 Rating',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.mosque,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      buildSectionCard(
                        icon: Icons.flight_takeoff,
                        title: 'Travel Details',
                        color: Colors.blue,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () => showAirportSelectionModal(true),
                              child: buildInfoRow(
                                Icons.flight_takeoff,
                                'Departure Airport',
                                travelData['departure_city']?.isNotEmpty == true
                                    ? travelData['departure_city']!
                                    : 'Tap to select',
                                Colors.orange,
                                isClickable: true,
                              ),
                            ),
                            const SizedBox(height: 12),
                            GestureDetector(
                              onTap: () => showAirportSelectionModal(false),
                              child: buildInfoRow(
                                Icons.flight_land,
                                'Destination Airport',
                                travelData['destination_city']?.isNotEmpty ==
                                        true
                                    ? travelData['destination_city']!
                                    : 'Tap to select',
                                Colors.green,
                                isClickable: true,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => showDateSelectionModal(true),
                                    child: buildDatePickerCard(
                                      'Start Date',
                                      startDate,
                                      Icons.calendar_today,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => showDateSelectionModal(false),
                                    child: buildDatePickerCard(
                                      'End Date',
                                      endDate,
                                      Icons.calendar_today,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            if (stayDuration != null)
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.teal.shade100,
                                      Colors.teal.shade50,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.teal.shade300,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.hotel, color: Colors.teal),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        'Stay Duration: $stayDuration',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.teal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      buildSectionCard(
                        icon: Icons.people,
                        title: 'Pilgrim Information',
                        color: Colors.purple,
                        child: Column(
                          children: [
                            ResponsiveCounterRow(
                              label: 'Adults (12+ yrs)',
                              icon: Icons.person,
                              value: adults,
                              onChanged: (v) => setState(() => adults = v),
                            ),
                            const SizedBox(height: 12),
                            ResponsiveCounterRow(
                              label: 'Children (2-11 yrs)',
                              icon: Icons.child_care,
                              value: children,
                              onChanged: (v) => setState(() => children = v),
                            ),
                            const SizedBox(height: 12),
                            ResponsiveCounterRow(
                              label: 'Infants (0-2 yrs)',
                              icon: Icons.baby_changing_station,
                              value: infants,
                              onChanged: (v) => setState(() => infants = v),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      buildSectionCard(
                        icon: Icons.card_travel,
                        title: 'Package Preference',
                        color: Colors.orange,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () => showSelectionModal(
                                title: 'Select Package Type',
                                subtitle: 'Choose your preferred package',
                                items: packageTypes,
                                currentValue: selectedPackageType,
                                onSelected: (value) =>
                                    setState(() => selectedPackageType = value),
                                headerIcon: Icons.card_travel,
                                headerColor: Colors.orange,
                              ),
                              child: buildSelectionRow(
                                'Package Type',
                                Icons.card_travel,
                                packageTypes.firstWhere(
                                  (item) =>
                                      item['value'] == selectedPackageType,
                                )['label'],
                                Colors.orange,
                              ),
                            ),
                            const SizedBox(height: 16),
                            GestureDetector(
                              onTap: () => showSelectionModal(
                                title: 'Select Hotel Distance',
                                subtitle: 'How far from Haram?',
                                items: hotelDistances,
                                currentValue: selectedHotelDistance,
                                onSelected: (value) => setState(
                                  () => selectedHotelDistance = value,
                                ),
                                headerIcon: Icons.location_on,
                                headerColor: Colors.red,
                              ),
                              child: buildSelectionRow(
                                'Hotel Distance',
                                Icons.location_on,
                                hotelDistances.firstWhere(
                                  (item) =>
                                      item['value'] == selectedHotelDistance,
                                )['label'],
                                Colors.red,
                              ),
                            ),
                            const SizedBox(height: 16),
                            GestureDetector(
                              onTap: () => showSelectionModal(
                                title: 'Select Room Type',
                                subtitle: 'Choose your accommodation',
                                items: roomTypes,
                                currentValue: selectedRoomType,
                                onSelected: (value) =>
                                    setState(() => selectedRoomType = value),
                                headerIcon: Icons.bed,
                                headerColor: Colors.pink,
                              ),
                              child: buildSelectionRow(
                                'Room Type',
                                Icons.bed,
                                roomTypes.firstWhere(
                                  (item) => item['value'] == selectedRoomType,
                                )['label'],
                                Colors.pink,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: SwitchListTile(
                                contentPadding: EdgeInsets.zero,
                                title: const Text(
                                  'Meal Included',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                secondary: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.teal.shade100,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.restaurant,
                                    color: Colors.teal,
                                  ),
                                ),
                                value: mealIncluded,
                                onChanged: (value) =>
                                    setState(() => mealIncluded = value),
                                activeColor: Colors.teal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      buildSectionCard(
                        icon: Icons.directions_bus,
                        title: 'Transport & Flight',
                        color: Colors.green,
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: SwitchListTile(
                                contentPadding: EdgeInsets.zero,
                                title: const Text(
                                  'Include Flight?',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                secondary: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade100,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.flight,
                                    color: Colors.blue,
                                  ),
                                ),
                                value: transportFlightIncluded,
                                onChanged: (value) => setState(
                                  () => transportFlightIncluded = value,
                                ),
                                activeColor: Colors.blue,
                              ),
                            ),
                            if (transportFlightIncluded &&
                                airlines.isNotEmpty) ...[
                              const SizedBox(height: 16),
                              GestureDetector(
                                onTap: () => showAirlineSelectionModal(),
                                child: buildSelectionRow(
                                  'Preferred Airline',
                                  Icons.airplanemode_active,
                                  selectedAirline ?? 'Tap to select',
                                  Colors.blue,
                                ),
                              ),
                            ],
                            const SizedBox(height: 16),
                            GestureDetector(
                              onTap: () => showSelectionModal(
                                title: 'Select Transport Type',
                                subtitle: 'Choose your transportation',
                                items: transportTypes,
                                currentValue: selectedTransportType,
                                onSelected: (value) => setState(
                                  () => selectedTransportType = value,
                                ),
                                headerIcon: Icons.directions_bus,
                                headerColor: Colors.green,
                              ),
                              child: buildSelectionRow(
                                'Transport Type',
                                Icons.directions_bus,
                                transportTypes.firstWhere(
                                  (item) =>
                                      item['value'] == selectedTransportType,
                                )['label'],
                                Colors.green,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: SwitchListTile(
                                contentPadding: EdgeInsets.zero,
                                title: const Text(
                                  'Include Ziyarat?',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                secondary: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.purple.shade100,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.temple_hindu,
                                    color: Colors.purple,
                                  ),
                                ),
                                value: ziyaratIncluded,
                                onChanged: (value) {
                                  setState(() {
                                    ziyaratIncluded = value;
                                    if (value && ziyaratPackages.isNotEmpty) {
                                      showZiyaratSelectionModal();
                                    }
                                  });
                                },
                                activeColor: Colors.purple,
                              ),
                            ),
                            if (ziyaratIncluded &&
                                selectedZiyaratPackages.isNotEmpty) ...[
                              const SizedBox(height: 12),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.purple.shade50,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.check_circle,
                                      color: Colors.purple,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        '${selectedZiyaratPackages.length} package(s) selected',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.purple,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          showZiyaratSelectionModal(),
                                      child: const Text('Change'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (selectedDepartureAirport.isEmpty ||
                                selectedDestinationAirport.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Please select departure and destination airports',
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }
                            if (startDate == null || endDate == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Please select start and end dates',
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }
                            showSuccessModal();
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: Colors.teal.shade700,
                            foregroundColor: Colors.white,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.check_circle, size: 24),
                              const SizedBox(width: 10),
                              Text(
                                'Submit Booking',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void calculateDuration() {
    if (startDate != null && endDate != null) {
      int days = endDate!.difference(startDate!).inDays;
      setState(() {
        stayDuration = '$days days ${days > 1 ? 'nights' : 'night'}';
      });
    }
  }

  Widget buildSectionCard({
    required IconData icon,
    required String title,
    required Color color,
    required Widget child,
  }) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, color.withOpacity(0.05)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: color, size: 28),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
              const Divider(height: 24, thickness: 1),
              child,
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSelectionRow(
    String label,
    IconData icon,
    String value,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.5), width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: color, size: 16),
        ],
      ),
    );
  }

  Widget buildInfoRow(
    IconData icon,
    String label,
    String value,
    Color iconColor, {
    bool isClickable = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isClickable ? iconColor : Colors.grey.shade200,
          width: isClickable ? 1.5 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isClickable && value == 'Tap to select'
                        ? iconColor
                        : Colors.black,
                  ),
                ),
              ],
            ),
          ),
          if (isClickable)
            Icon(Icons.arrow_forward_ios, color: iconColor, size: 16),
        ],
      ),
    );
  }

  Widget buildDatePickerCard(String label, DateTime? date, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: Colors.teal),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            date == null
                ? 'Select Date'
                : '${date.day}/${date.month}/${date.year}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: date == null ? Colors.grey : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

// Responsive counter row widget to fix overflow
class ResponsiveCounterRow extends StatelessWidget {
  final String label;
  final IconData icon;
  final int value;
  final Function(int) onChanged;

  const ResponsiveCounterRow({
    super.key,
    required this.label,
    required this.icon,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: Colors.purple, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: () => value > 0 ? onChanged(value - 1) : null,
                color: Colors.purple,
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.all(4),
                iconSize: 24,
              ),
              SizedBox(
                width: 35,
                child: Text(
                  '$value',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                onPressed: () => onChanged(value + 1),
                color: Colors.purple,
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.all(4),
                iconSize: 24,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
