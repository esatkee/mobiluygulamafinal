import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'base_page.dart';
import '../widgets/custom_drawer.dart';
import '../constants/constants.dart';
import '../constants/texts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _birthDateController;
  late TextEditingController _locationController;
  late TextEditingController _birthLocationController;
  late TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    _nameController = TextEditingController(text: user?.displayName ?? '');
    _birthDateController = TextEditingController();
    _locationController = TextEditingController();
    _birthLocationController = TextEditingController();
    _bioController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _birthDateController.dispose();
    _locationController.dispose();
    _birthLocationController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _birthDateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return BasePage(
      title: AppTexts.profile,
      drawer: DrawerMenu(onAddNote: null),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: AppConstants.avatarRadius,
                      backgroundImage: user?.photoURL != null
                          ? NetworkImage(user!.photoURL!)
                          : const AssetImage(AppConstants.defaultAvatarPath) as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppConstants.primaryColor,
                          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt, color: Colors.white),
                          onPressed: () {
                            // TODO: Implement image picker
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppConstants.largePadding),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: AppTexts.fullName,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppTexts.nameRequired;
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppConstants.defaultPadding),
              TextFormField(
                controller: _birthDateController,
                decoration: InputDecoration(
                  labelText: AppTexts.birthDate,
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                readOnly: true,
              ),
              const SizedBox(height: AppConstants.defaultPadding),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: AppTexts.location,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: AppConstants.defaultPadding),
              TextFormField(
                controller: _birthLocationController,
                decoration: InputDecoration(
                  labelText: AppTexts.birthLocation,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: AppConstants.defaultPadding),
              TextFormField(
                controller: _bioController,
                decoration: InputDecoration(
                  labelText: AppTexts.about,
                  border: const OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: AppConstants.largePadding),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // TODO: Implement save functionality
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(AppTexts.profileUpdateSuccess)),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: AppConstants.buttonHeight / 2),
                  ),
                  child: Text(AppTexts.save),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 