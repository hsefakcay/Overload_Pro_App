import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overload_pro_app/features/profile/bloc/profile_bloc.dart';
import 'package:overload_pro_app/features/profile/bloc/profile_event.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({
    super.key,
    this.initialName,
    this.initialWeight,
    this.initialHeight,
    this.initialPhotoUrl,
    this.initialTargetWeight,
  });
  final String? initialName;
  final double? initialWeight;
  final double? initialHeight;
  final String? initialPhotoUrl;
  final double? initialTargetWeight;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _weightController;
  late TextEditingController _heightController;
  late TextEditingController _targetWeightController;
  XFile? _pickedImage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName ?? '');
    _weightController = TextEditingController(text: widget.initialWeight?.toString() ?? '');
    _heightController = TextEditingController(text: widget.initialHeight?.toString() ?? '');
    _targetWeightController =
        TextEditingController(text: widget.initialTargetWeight?.toString() ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _targetWeightController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _pickedImage = picked;
      });
    }
  }

  void _saveProfile() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<ProfileBloc>().add(
            UpdateProfile(
              name: _nameController.text,
              height: double.tryParse(_heightController.text) ?? 0,
              targetWeight: double.tryParse(_targetWeightController.text) ?? 0,
            ),
          );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 48,
                    backgroundImage: _pickedImage != null
                        ? FileImage(File(_pickedImage!.path))
                        : (widget.initialPhotoUrl != null
                            ? NetworkImage(widget.initialPhotoUrl!)
                            : null) as ImageProvider?,
                    child: _pickedImage == null && widget.initialPhotoUrl == null
                        ? const Icon(Icons.person, size: 48)
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) => value == null || value.isEmpty ? 'Enter name' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _weightController,
                decoration: const InputDecoration(labelText: 'Weight (kg)'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'Enter weight' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _targetWeightController,
                decoration: const InputDecoration(labelText: 'Target Weight (kg)'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'Enter target weight' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _heightController,
                decoration: const InputDecoration(labelText: 'Height (cm)'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'Enter height' : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveProfile,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
