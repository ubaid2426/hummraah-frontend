// features/auth/presentation/pages/profile_screen.dart (updated)
import 'package:flutter/material.dart';
import 'package:hummraah/core/services/api/api_service.dart';
import 'package:hummraah/core/services/api/api_client.dart';
import 'package:hummraah/core/services/local_storage_service.dart';
import 'package:hummraah/features/auth/data/models/profile_model.dart';
import 'package:hummraah/features/auth/presentation/widgets/session_expired_dialog.dart';

class PersonalInformartion extends StatefulWidget {
  const PersonalInformartion({super.key});

  @override
  State<PersonalInformartion> createState() => _PersonalInformartionState();
}

class _PersonalInformartionState extends State<PersonalInformartion> {
  late ApiService _apiService;
  ProfileModel? _profile;
  bool _isLoading = true;
  bool _isEditing = false;
  bool _isSaving = false;
  String? _error;
  LocalStorageService? _storage;

  late TextEditingController _fullNameController;
  late TextEditingController _mobileNumberController;
  late TextEditingController _whatsappNumberController;
  late TextEditingController _addressController;
  late TextEditingController _emergencyNumberController;
  late TextEditingController _countryController;
  late TextEditingController _passportNumberController;
  late TextEditingController _passportExpiryDateController;

  @override
  void initState() {
    super.initState();
    _initStorageAndFetch();
  }

  Future<void> _initStorageAndFetch() async {
    _storage = await LocalStorageService.getInstance();
    _apiService = ApiService(ApiClient());
    _initControllers();
    await _checkTokenAndFetch();
  }

  Future<void> _checkTokenAndFetch() async {
    final token = await _storage!.getString('token');
    print('🔍 Profile Screen - Token check:');
    print('Token exists: ${token != null}');
    if (token != null) {
      print('Token preview: ${token.substring(0, token.length > 30 ? 30 : token.length)}...');
      print('Token length: ${token.length}');
    } else {
      print('❌ No token found!');
      if (mounted) {
        SessionExpiredDialog.show(context);
      }
      return;
    }
    
    _fetchProfile();
  }

  void _initControllers() {
    _fullNameController = TextEditingController();
    _mobileNumberController = TextEditingController();
    _whatsappNumberController = TextEditingController();
    _addressController = TextEditingController();
    _emergencyNumberController = TextEditingController();
    _countryController = TextEditingController();
    _passportNumberController = TextEditingController();
    _passportExpiryDateController = TextEditingController();
  }

  Future<void> _fetchProfile() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await _apiService.getProfile();
      print('✅ Profile Response: $response');
      
      final profile = ProfileModel.fromJson(response);
      
      setState(() {
        _profile = profile;
        _updateControllers();
        _isLoading = false;
      });
    } catch (e) {
      print('❌ Error fetching profile: $e');
      
      if (e is ApiException) {
        if (e.statusCode == 401 || e.message.toLowerCase().contains('session expired')) {
          print('⚠️ Session expired, showing login dialog');
          if (mounted) {
            // Clear invalid token
            await _storage!.remove('token');
            SessionExpiredDialog.show(context);
          }
          return;
        }
      }
      
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _updateControllers() {
    if (_profile != null) {
      _fullNameController.text = _profile!.fullName;
      _mobileNumberController.text = _profile!.mobileNumber;
      _whatsappNumberController.text = _profile!.whatsappNumber ?? '';
      _addressController.text = _profile!.address;
      _emergencyNumberController.text = _profile!.emergencyNumber;
      _countryController.text = _profile!.country;
      _passportNumberController.text = _profile!.passportNumber ?? '';
      _passportExpiryDateController.text = _profile!.passportExpiryDate ?? '';
    }
  }

  Future<void> _updateProfile() async {
    setState(() {
      _isSaving = true;
    });

    try {
      final updatedData = {
        'fullName': _fullNameController.text,
        'mobileNumber': _mobileNumberController.text,
        'whatsappNumber': _whatsappNumberController.text.isEmpty ? null : _whatsappNumberController.text,
        'address': _addressController.text,
        'emergencyNumber': _emergencyNumberController.text,
        'country': _countryController.text,
        'passportNumber': _passportNumberController.text.isEmpty ? null : _passportNumberController.text,
        'passportExpiryDate': _passportExpiryDateController.text.isEmpty ? null : _passportExpiryDateController.text,
      };

      final response = await _apiService.updateProfile(updatedData);
      print('✅ Update Response: $response');
      
      final updatedProfile = ProfileModel.fromJson(response);
      
      setState(() {
        _profile = updatedProfile;
        _isEditing = false;
        _isSaving = false;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print('❌ Error updating profile: $e');
      
      setState(() {
        _isSaving = false;
      });
      
      if (e is ApiException && (e.statusCode == 401 || e.message.toLowerCase().contains('session expired'))) {
        if (mounted) {
          await _storage!.remove('token');
          SessionExpiredDialog.show(context);
        }
        return;
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating profile: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2035),
    );
    if (picked != null) {
      setState(() {
        _passportExpiryDateController.text = picked.toIso8601String().split('T')[0];
      });
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _mobileNumberController.dispose();
    _whatsappNumberController.dispose();
    _addressController.dispose();
    _emergencyNumberController.dispose();
    _countryController.dispose();
    _passportNumberController.dispose();
    _passportExpiryDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        actions: [
          if (!_isLoading && !_isEditing)
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () {
                setState(() {
                  _isEditing = true;
                });
              },
            ),
          if (_isEditing)
            TextButton(
              onPressed: _isSaving ? null : _updateProfile,
              child: _isSaving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text(
                      'Save',
                      style: TextStyle(
                        color: Color(0xFF2E7D32),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          if (_isEditing)
            TextButton(
              onPressed: () {
                setState(() {
                  _isEditing = false;
                  _updateControllers();
                });
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 64, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(_error!),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _fetchProfile,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF2E7D32), Color(0xFF1B5E20)],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.person,
                                size: 60,
                                color: Color(0xFF2E7D32),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _profile?.fullName ?? '',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _profile?.email ?? '',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      if (!_isEditing)
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              _isEditing = true;
                            });
                          },
                          icon: const Icon(Icons.edit),
                          label: const Text('Edit Profile'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2E7D32),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      
                      const SizedBox(height: 24),
                      
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Personal Information',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              _buildInfoField(
                                label: 'Full Name',
                                icon: Icons.person_outline,
                                controller: _fullNameController,
                                enabled: _isEditing,
                              ),
                              const SizedBox(height: 16),
                              _buildInfoField(
                                label: 'Mobile Number',
                                icon: Icons.phone_android_outlined,
                                controller: _mobileNumberController,
                                enabled: _isEditing,
                                keyboardType: TextInputType.phone,
                              ),
                              const SizedBox(height: 16),
                              _buildInfoField(
                                label: 'WhatsApp Number',
                                icon: Icons.message_outlined,
                                controller: _whatsappNumberController,
                                enabled: _isEditing,
                                keyboardType: TextInputType.phone,
                              ),
                              const SizedBox(height: 16),
                              _buildInfoField(
                                label: 'Address',
                                icon: Icons.location_on_outlined,
                                controller: _addressController,
                                enabled: _isEditing,
                                maxLines: 2,
                              ),
                              const SizedBox(height: 16),
                              _buildInfoField(
                                label: 'Emergency Contact',
                                icon: Icons.emergency_outlined,
                                controller: _emergencyNumberController,
                                enabled: _isEditing,
                                keyboardType: TextInputType.phone,
                              ),
                              const SizedBox(height: 16),
                              _buildInfoField(
                                label: 'Country',
                                icon: Icons.public,
                                controller: _countryController,
                                enabled: _isEditing,
                              ),
                              const SizedBox(height: 16),
                              _buildInfoField(
                                label: 'Passport Number',
                                icon: Icons.airplane_ticket_outlined,
                                controller: _passportNumberController,
                                enabled: _isEditing,
                              ),
                              const SizedBox(height: 16),
                              _buildDateField(
                                label: 'Passport Expiry Date',
                                icon: Icons.calendar_today_outlined,
                                controller: _passportExpiryDateController,
                                enabled: _isEditing,
                                onTap: _isEditing ? _selectDate : null,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
    );
  }

  Widget _buildInfoField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    required bool enabled,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: enabled ? Colors.white : Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: enabled ? const Color(0xFF2E7D32).withOpacity(0.3) : Colors.transparent,
        ),
      ),
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        keyboardType: keyboardType,
        maxLines: maxLines,
        style: TextStyle(
          color: enabled ? Colors.black : Colors.grey[600],
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: enabled ? const Color(0xFF2E7D32) : Colors.grey[600],
          ),
          prefixIcon: Icon(icon, color: enabled ? const Color(0xFF2E7D32) : Colors.grey[600]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: enabled ? Colors.white : Colors.grey[50],
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildDateField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    required bool enabled,
    required VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: enabled ? Colors.white : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: enabled ? const Color(0xFF2E7D32).withOpacity(0.3) : Colors.transparent,
          ),
        ),
        child: TextFormField(
          controller: controller,
          enabled: false,
          style: TextStyle(
            color: enabled ? Colors.black : Colors.grey[600],
          ),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              color: enabled ? const Color(0xFF2E7D32) : Colors.grey[600],
            ),
            prefixIcon: Icon(icon, color: enabled ? const Color(0xFF2E7D32) : Colors.grey[600]),
            suffixIcon: enabled ? const Icon(Icons.calendar_today, size: 20) : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: enabled ? Colors.white : Colors.grey[50],
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ),
    );
  }
}