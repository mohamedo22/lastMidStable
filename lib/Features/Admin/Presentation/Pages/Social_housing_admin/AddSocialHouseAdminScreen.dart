import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart'; // For document picking
import 'package:your_mediator/Features/Admin/Services/SocialHouseAdminService.dart';
import 'package:your_mediator/Features/Admin/Models/SocialHouseAdminModel.dart';

class AddSocialHouseAdminScreen extends StatefulWidget {
  @override
  _AddSocialHouseAdminScreenState createState() =>
      _AddSocialHouseAdminScreenState();
}

class _AddSocialHouseAdminScreenState extends State<AddSocialHouseAdminScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _addressController = TextEditingController();
  final _categoryController = TextEditingController();
  final _termsController = TextEditingController();

  List<File> _selectedImages = [];
  List<File> _selectedDocuments = [];
  final ImagePicker _picker = ImagePicker();
  final SocialHouseAdminService _socialHouseService = SocialHouseAdminService();
  bool _isLoading = false;

  // Pick images from Gallery or Camera
  // Pick images from Gallery
  Future<void> _pickImages() async {
    try {
      final List<XFile>? images = await _picker.pickMultiImage();
      if (images != null) {
        setState(() {
          _selectedImages.addAll(images.map((image) => File(image.path)).toList());
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick images: $e')),
      );
    }
  }

// Pick image from Camera
  Future<void> _pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        setState(() {
          _selectedImages.add(File(image.path));
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image from camera: $e')),
      );
    }
  }

  // Pick documents (PDFs)
  Future<void> _pickDocuments() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: true,
      );

      if (result != null) {
        setState(() {
          _selectedDocuments.addAll(result.files.map((file) => File(file.path!)).toList());
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick documents: $e')),
      );
    }
  }

  // Remove selected image
  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  // Remove selected document
  void _removeDocument(int index) {
    setState(() {
      _selectedDocuments.removeAt(index);
    });
  }

  // Handle adding Social House
  Future<void> _addSocialHouse() async {
    if (_selectedImages.isEmpty || _selectedDocuments.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select at least one image and one document')),
      );
      return;
    }

    if (_titleController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _addressController.text.isEmpty ||
        _categoryController.text.isEmpty ||
        _termsController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _socialHouseService.addSocialHouse(
        title: _titleController.text,
        description: _descriptionController.text,
        address: _addressController.text,
        category: _categoryController.text,
        terms: _termsController.text,
        imageFiles: _selectedImages,
        documentFiles: _selectedDocuments,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Social House added successfully')),
      );

      // Clear the form and go back
      _clearForm();
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Clear the form
  void _clearForm() {
    _titleController.clear();
    _descriptionController.clear();
    _addressController.clear();
    _categoryController.clear();
    _termsController.clear();
    setState(() {
      _selectedImages.clear();
      _selectedDocuments.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Add Social House')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Field
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Description Field
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Address Field
              TextField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Category Field
              TextField(
                controller: _categoryController,
                decoration: InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Terms Field
              TextField(
                controller: _termsController,
                decoration: InputDecoration(
                  labelText: 'Terms',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Image Picker UI
              Text(
                'Select Images',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  ElevatedButton.icon(
                    icon: Icon(Icons.image),
                    label: Text('Gallery'),
                    onPressed: _pickImages, // Call the updated method
                  ),
                  SizedBox(width: 10),
                  ElevatedButton.icon(
                    icon: Icon(Icons.camera),
                    label: Text('Camera'),
                    onPressed: _pickImageFromCamera, // Call the new method
                  ),
                ],
              ),
              SizedBox(height: 10),
              _selectedImages.isEmpty
                  ? Text(
                'No images selected',
                style: TextStyle(color: Colors.red),
              )
                  : Wrap(
                spacing: 8,
                children: _selectedImages.map((image) {
                  return Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image.file(
                        image,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                      IconButton(
                        icon: Icon(Icons.cancel, color: Colors.red),
                        onPressed: () => _removeImage(_selectedImages.indexOf(image)),
                      ),
                    ],
                  );
                }).toList(),
              ),
              SizedBox(height: 20),

              // Document Picker UI
              Text(
                'Select Documents',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                icon: Icon(Icons.attach_file),
                label: Text('Pick Documents'),
                onPressed: _pickDocuments,
              ),
              SizedBox(height: 10),
              _selectedDocuments.isEmpty
                  ? Text(
                'No documents selected',
                style: TextStyle(color: Colors.red),
              )
                  : Wrap(
                spacing: 8,
                children: _selectedDocuments.map((doc) {
                  return Chip(
                    label: Text('Document ${_selectedDocuments.indexOf(doc) + 1}'),
                    deleteIcon: Icon(Icons.cancel, color: Colors.red),
                    onDeleted: () => _removeDocument(_selectedDocuments.indexOf(doc)),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),

              // Submit Button
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                onPressed: _addSocialHouse,
                child: Text('Add Social House'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}