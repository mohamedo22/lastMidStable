import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:your_mediator/Features/Admin/Models/SocialHouseAdminModel.dart';
import 'package:your_mediator/Features/Admin/Presentation/Providers/SocialHouseAdminProvider.dart';

class UpdateSocialHouseScreen extends StatefulWidget {
  static const String routeName = "UpdateSocialHouseScreen";

  final SocialHouseAdminModel socialHouse;

  UpdateSocialHouseScreen({required this.socialHouse});

  @override
  _UpdateSocialHouseScreenState createState() => _UpdateSocialHouseScreenState();
}

class _UpdateSocialHouseScreenState extends State<UpdateSocialHouseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _addressController = TextEditingController();
  final _categoryController = TextEditingController();
  final _termsController = TextEditingController();

  List<File> _selectedImages = [];
  List<File> _selectedDocuments = [];
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.socialHouse.title;
    _descriptionController.text = widget.socialHouse.description;
    _addressController.text = widget.socialHouse.address;
    _categoryController.text = widget.socialHouse.category;
    _termsController.text = widget.socialHouse.terms;
  }

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

  // Handle updating Social House
  Future<void> _updateSocialHouse() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final provider = Provider.of<SocialHouseAdminProvider>(context, listen: false);
      await provider.updateSocialHouse(
        socialHouseID: widget.socialHouse.socialHouseId,
        title: _titleController.text,
        description: _descriptionController.text,
        address: _addressController.text,
        category: _categoryController.text,
        terms: _termsController.text,
        imageFiles: _selectedImages,
        documentFiles: _selectedDocuments,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Social House updated successfully')),
      );

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Update Social House')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(controller: _titleController, decoration: InputDecoration(labelText: 'Title', border: OutlineInputBorder())),
                SizedBox(height: 16),
                TextField(controller: _descriptionController, decoration: InputDecoration(labelText: 'Description', border: OutlineInputBorder())),
                SizedBox(height: 16),
                TextField(controller: _addressController, decoration: InputDecoration(labelText: 'Address', border: OutlineInputBorder())),
                SizedBox(height: 16),
                TextField(controller: _categoryController, decoration: InputDecoration(labelText: 'Category', border: OutlineInputBorder())),
                SizedBox(height: 16),
                TextField(controller: _termsController, decoration: InputDecoration(labelText: 'Terms', border: OutlineInputBorder())),
                SizedBox(height: 16),

                // Image Picker UI
                Text('Select Images', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                    ? Text('No images selected', style: TextStyle(color: Colors.red))
                    : Wrap(
                  spacing: 8,
                  children: _selectedImages.map((image) {
                    return Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image.file(image, height: 100, width: 100, fit: BoxFit.cover),
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
                Text('Select Documents', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                ElevatedButton.icon(
                  icon: Icon(Icons.attach_file),
                  label: Text('Pick Documents'),
                  onPressed: _pickDocuments,
                ),
                SizedBox(height: 10),
                _selectedDocuments.isEmpty
                    ? Text('No documents selected', style: TextStyle(color: Colors.red))
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

                _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                  onPressed: _updateSocialHouse,
                  child: Text('Update Social House'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}