import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hummraah/core/utils/colors.dart';
import 'package:hummraah/features/auth/presentation/pages/home/home_screen.dart';
import 'package:hummraah/features/auth/presentation/pages/services_screen.dart';
import 'package:hummraah/features/auth/presentation/widgets/ziyarah_planner.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key});

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  String _appVersion = "Loading...";
  
  @override
  void initState() {
    super.initState();
    _loadAppVersion();
  }

  Future<void> _loadAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = "Version ${packageInfo.version}";
    });
  }

  Future<void> _shareApp() async {
    const String appLink = "https://play.google.com/store/apps/details?id=com.example.hummraah"; // Replace with your actual app link
    
    await Share.share(
      "Check out this amazing app! Download it now: $appLink",
      subject: "Hummraah App - Your Umrah Companion",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 230, 226, 226),
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryGreen, AppColors.primaryGreen],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
            ),
            child: Row(
              children: [
                Container(
                  height: 280,
                  width: 270,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/logo/logo.png',
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                const ManyOption(
                  menuTitle: "Home",
                  fontawesome: FontAwesomeIcons.home,
                  navigateTo: HomeScreen(),
                ),
                const DonationMenu(
                  menuTitle: 'Your Umraah Jorney',
                  subOptions: [
                    "Pre-Umraah Preparation",
                    "Travel & Logistics",
                    "Umraah Ritual Guidance",
                    "Ziyarah Planner",
                    "During Stay Services",
                    "Return and follow-up",
                  ],
                  fontawesome: FontAwesomeIcons.layerGroup,
                ),
                const DonationMenu(
                  menuTitle: 'Quick Services',
                  subOptions: [
                    "Flights",
                    "Hotels",
                    "Visa",
                    "Transport",
                    "Packages",
                    "Assistance",
                  ],
                  fontawesome: FontAwesomeIcons.layerGroup,
                ),
                const DonationMenu(
                  menuTitle: 'Religious Tools',
                  subOptions: [
                    "Prayer Times",
                    "Duas",
                    "Umraah Guide",
                    "Tawaf Counter",
                    "Miqaat Locator",
                  ],
                  fontawesome: FontAwesomeIcons.layerGroup,
                ),
                const ManyOption(
                  menuTitle: "Ziyarah Planner",
                  fontawesome: FontAwesomeIcons.car,
                  navigateTo: ZiyarahPlanner(),
                ),
                const ManyOption(
                  menuTitle: "Local Services",
                  fontawesome: FontAwesomeIcons.rightToBracket,
                  navigateTo: ServicesScreen(),
                ),
                const SizedBox(height: 20), // Add some spacing
                
                // Share Button and Version in a Container
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Share Button
                        ElevatedButton.icon(
                          onPressed: _shareApp,
                          icon: const Icon(Icons.share, size: 20),
                          label: const Text(
                            "Share App",
                            style: TextStyle(fontSize: 16),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryGreen,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                          ),
                        ),
                        const SizedBox(height: 12),
                        
                        // Version Container
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.info_outline,
                                size: 14,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(width: 6),
                              Text(
                                _appVersion,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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

class ManyOption extends StatelessWidget {
  final String menuTitle;
  final IconData fontawesome;
  final Widget navigateTo;
  
  const ManyOption({
    super.key,
    required this.menuTitle,
    required this.fontawesome,
    required this.navigateTo,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        fontawesome,
        size: 18,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      title: Text(
        menuTitle,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 15,
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => navigateTo,
          ),
        );
      },
    );
  }
}

class DonationMenu extends StatefulWidget {
  final String menuTitle;
  final List<String> subOptions;
  final IconData fontawesome;
  
  const DonationMenu({
    super.key,
    required this.menuTitle,
    required this.subOptions,
    required this.fontawesome,
  });

  @override
  State<DonationMenu> createState() => _DonationMenuState();
}

class _DonationMenuState extends State<DonationMenu> {
  bool _isExpanded = false;
  
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
        side: BorderSide.none,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
        side: BorderSide.none,
      ),
      showTrailingIcon: false,
      initiallyExpanded: _isExpanded,
      onExpansionChanged: (bool expanded) {
        setState(() {
          _isExpanded = expanded;
        });
      },
      title: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        color: _isExpanded
            ? AppColors.primaryGreen
            : const Color.fromARGB(255, 230, 226, 226),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 16),
            Icon(
              widget.fontawesome,
              size: 18,
              color: _isExpanded
                  ? const Color.fromARGB(255, 247, 247, 247)
                  : const Color.fromARGB(255, 12, 12, 12),
            ),
            const SizedBox(width: 20),
            Text(
              widget.menuTitle,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: _isExpanded ? Colors.white : Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Icon(
              _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: _isExpanded ? Colors.white : Colors.black87,
              size: 24,
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
      children: widget.subOptions.map((option) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
          child: ListTile(
            title: Text(
              option,
              style: const TextStyle(fontSize: 14),
            ),
            onTap: () {
              // Handle sub-option tap
              Navigator.pop(context); // Close drawer
              // Add your navigation logic here based on the option
              switch (option) {
                case 'Pre-Umraah Preparation':
                  // Navigate to Pre-Umraah Preparation screen
                  break;
                case 'Travel & Logistics':
                  // Navigate to Travel & Logistics screen
                  break;
                // Add other cases...
                default:
                  // Handle default case
                  break;
              }
            },
          ),
        );
      }).toList(),
    );
  }
}