import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final TextEditingController _groupNameController = TextEditingController();
  File? _groupImage;

  final List<Map<String, dynamic>> _contacts = [
    {'name': 'Ali', 'selected': false},
    {'name': 'Mona', 'selected': false},
    {'name': 'Youssef', 'selected': false},
    {'name': 'Sara', 'selected': false},
  ];

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _groupImage = File(picked.path);
      });
    }
  }

  void _createGroup() {
    final name = _groupNameController.text.trim();
    final selectedMembers = _contacts.where((c) => c['selected']).toList();

    if (name.isEmpty || selectedMembers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a group name and select members')),
      );
      return;
    }

    // Navigate or save to backend
    Navigator.pushNamed(context, '/group-info');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Group'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 45,
                backgroundColor: Colors.deepPurple.shade100,
                backgroundImage:
                _groupImage != null ? FileImage(_groupImage!) : null,
                child: _groupImage == null
                    ? const Icon(Icons.camera_alt, size: 30, color: Colors.white70)
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _groupNameController,
              decoration: InputDecoration(
                labelText: 'Group Name',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Select Members', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: _contacts.length,
                itemBuilder: (context, index) {
                  final contact = _contacts[index];
                  return CheckboxListTile(
                    title: Text(contact['name']),
                    value: contact['selected'],
                    onChanged: (bool? value) {
                      setState(() {
                        contact['selected'] = value ?? false;
                      });
                    },
                  );
                },
              ),
            ),
            ElevatedButton.icon(
              onPressed: _createGroup,
              icon: const Icon(Icons.check),
              label: const Text('Create Group'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
