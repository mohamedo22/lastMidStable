import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:your_mediator/Features/Home/Peresintation/Pages/home_screen.dart';
import 'package:your_mediator/Features/addFlat/models/add_flat_model.dart';
import 'package:your_mediator/Features/addFlat/presentation/Providers/flat_provider.dart';
import 'package:your_mediator/Features/addFlat/presentation/widgets/customAddFlatWidget.dart';

class AddFlatTab extends StatefulWidget {
  const AddFlatTab({super.key});

  @override
  _AddFlatTabState createState() => _AddFlatTabState();
}

class _AddFlatTabState extends State<AddFlatTab> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final TextEditingController price = TextEditingController();
  final TextEditingController numberOfBedrooms = TextEditingController();
  final TextEditingController numberOfBathRooms = TextEditingController();
  final TextEditingController floorNumber = TextEditingController();
  final TextEditingController flatGovernorate = TextEditingController();
  final TextEditingController flatCity = TextEditingController();
  final TextEditingController flatAddress = TextEditingController();
  final TextEditingController details = TextEditingController();

  List<File> _images = [];
  List<File> _flatDocs = [];
  
  // Form steps
  final List<String> _steps = [
    "Basic Information",
    "Location Details",
    "Media & Documents",
    "Final Details"
  ];

  // Pick Images
  Future<void> _pickImages() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      setState(() {
        _images = images.map((image) => File(image.path)).toList();
      });
    }
  }

  // Pick Documents (PDFs)
  Future<void> _pickDocuments() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx'],
      allowMultiple: true,
    );

    if (result != null) {
      setState(() {
        _flatDocs = result.files.map((file) => File(file.path!)).toList();
      });
    }
  }

  // Submit Flat Details
  Future<void> _submitFlat(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please complete all required fields")),
      );
      return;
    }

    if (_images.isEmpty || _flatDocs.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please upload images and documents")),
      );
      return;
    }

    final flat = AddFlatModel(
      flatPrice: int.tryParse(price.text) ?? 0,
      flatBathrooms: int.tryParse(numberOfBathRooms.text) ?? 0,
      flatBedrooms: int.tryParse(numberOfBedrooms.text) ?? 0,
      floorNumber: int.tryParse(floorNumber.text) ?? 0,
      flatAddress: flatAddress.text,
      flatGovernorate: flatGovernorate.text,
      flatCity: flatCity.text,
      flatDetails: details.text,
    );

    final provider = Provider.of<AddFlatProvider>(context, listen: false);
    
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
              ),
              SizedBox(height: 20),
              Text("Uploading your property...", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text("Please wait while we process your information"),
            ],
          ),
        );
      },
    );
    
    final success = await provider.addFlat(flat, _images, _flatDocs);
    
    // Close loading dialog
    Navigator.pop(context);

    if (success) {
      // Show success dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 28),
                SizedBox(width: 10),
                Text("Success", style: TextStyle(color: Colors.green)),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Your property has been successfully added!",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                CircleAvatar(
                  backgroundColor: Colors.green.withOpacity(0.1),
                  radius: 40,
                  child: Icon(
                    Icons.home,
                    color: Colors.green,
                    size: 50,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Your property is now pending approval from our administration team.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[700], fontSize: 14),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _clearForm();
                  Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    "Back to Home",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(provider.error ?? "Failed to add flat"),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  // Clear Form
  void _clearForm() {
    price.clear();
    numberOfBedrooms.clear();
    numberOfBathRooms.clear();
    floorNumber.clear();
    flatGovernorate.clear();
    flatCity.clear();
    flatAddress.clear();
    details.clear();
    setState(() {
      _images.clear();
      _flatDocs.clear();
      _currentPage = 0;
      _pageController.jumpToPage(0);
    });
  }
  
  void _nextPage() {
    if (_currentPage < _steps.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
  
  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddFlatProvider>(context);
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            // Stepper header
            _buildStepperHeader(),
            
            // Form content
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  // Page 1: Basic Information
                  _buildBasicInfoPage(),
                  
                  // Page 2: Location Details
                  _buildLocationPage(),
                  
                  // Page 3: Media & Documents
                  _buildMediaPage(),
                  
                  // Page 4: Final Details
                  _buildFinalDetailsPage(),
                ],
              ),
            ),
            
            // Navigation buttons
            _buildNavButtons(provider),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStepperHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Add Your Property",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(height: 5),
          Text(
            "Step ${_currentPage + 1} of ${_steps.length}: ${_steps[_currentPage]}",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 15),
          Row(
            children: List.generate(
              _steps.length,
              (index) => Expanded(
                child: Container(
                  height: 4,
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: index <= _currentPage
                        ? Theme.of(context).primaryColor
                        : Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildBasicInfoPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("Property Details"),
          _buildInfoCard(
            child: Column(
              children: [
                _buildFormRow(
                  icon: Icons.price_change,
                  label: "Price (LE)",
                  field: Customaddflatwidget(
                    icn: const Icon(Icons.price_change),
                    txt: "Enter property price",
                    controller: price,
                    keyboardType: TextInputType.number,
                  ),
                ),
                _buildDivider(),
                _buildFormRow(
                  icon: Icons.bed,
                  label: "Bedrooms",
                  field: Customaddflatwidget(
                    icn: const Icon(Icons.bed),
                    txt: "Number of bedrooms",
                    controller: numberOfBedrooms,
                    keyboardType: TextInputType.number,
                  ),
                ),
                _buildDivider(),
                _buildFormRow(
                  icon: Icons.bathtub,
                  label: "Bathrooms",
                  field: Customaddflatwidget(
                    icn: const Icon(Icons.bathtub),
                    txt: "Number of bathrooms",
                    controller: numberOfBathRooms,
                    keyboardType: TextInputType.number,
                  ),
                ),
                _buildDivider(),
                _buildFormRow(
                  icon: Icons.home,
                  label: "Floor",
                  field: Customaddflatwidget(
                    icn: const Icon(Icons.home),
                    txt: "Floor number",
                    controller: floorNumber,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          _buildTip(
            "Tip: Providing accurate details helps potential buyers find your property more easily.",
          ),
        ],
      ),
    );
  }
  
  Widget _buildLocationPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("Location Information"),
          _buildInfoCard(
            child: Column(
              children: [
                _buildFormRow(
                  icon: Icons.map,
                  label: "Governorate",
                  field: Customaddflatwidget(
                    icn: const Icon(Icons.location_city),
                    txt: "Enter governorate",
                    controller: flatGovernorate,
                  ),
                ),
                _buildDivider(),
                _buildFormRow(
                  icon: Icons.location_city,
                  label: "City",
                  field: Customaddflatwidget(
                    icn: const Icon(Icons.location_on),
                    txt: "Enter city",
                    controller: flatCity,
                  ),
                ),
                _buildDivider(),
                _buildFormRow(
                  icon: Icons.pin_drop,
                  label: "Address",
                  field: Customaddflatwidget(
                    icn: const Icon(Icons.location_on_outlined),
                    txt: "Enter full address",
                    controller: flatAddress,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          _buildLocationMap(),
          SizedBox(height: 20),
          _buildTip(
            "Tip: A detailed address increases the chances of interested buyers contacting you.",
          ),
        ],
      ),
    );
  }
  
  Widget _buildMediaPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("Photos & Documents"),
          
          // Images section
          Container(
            margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.photo_library, color: Theme.of(context).primaryColor),
                        SizedBox(width: 10),
                        Text(
                          "Property Photos",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    TextButton.icon(
                      icon: Icon(Icons.add_photo_alternate),
                      label: Text("Add"),
                      onPressed: _pickImages,
                      style: TextButton.styleFrom(
                        foregroundColor: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                _images.isEmpty
                    ? Container(
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.photo_camera, size: 40, color: Colors.grey),
                              SizedBox(height: 10),
                              Text(
                                "Tap to add photos",
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ],
                          ),
                        ),
                      )
                    : _imagesPreview(),
              ],
            ),
          ),
          
          // Documents section
          Container(
            margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.file_copy, color: Theme.of(context).primaryColor),
                        SizedBox(width: 10),
                        Text(
                          "Property Documents",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    TextButton.icon(
                      icon: Icon(Icons.upload_file),
                      label: Text("Upload"),
                      onPressed: _pickDocuments,
                      style: TextButton.styleFrom(
                        foregroundColor: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                _flatDocs.isEmpty
                    ? Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.upload_file, size: 30, color: Colors.grey),
                              SizedBox(height: 10),
                              Text(
                                "Tap to upload documents",
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ],
                          ),
                        ),
                      )
                    : _documentsPreview(),
              ],
            ),
          ),
          
          _buildTip(
            "Tip: High-quality images and complete documentation increase the chances of your property being approved quickly.",
          ),
        ],
      ),
    );
  }
  
  Widget _buildFinalDetailsPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("Additional Details"),
          
          // Details section
          Container(
            margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.description, color: Theme.of(context).primaryColor),
                    SizedBox(width: 10),
                    Text(
                      "Property Description",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: details,
                  decoration: InputDecoration(
                    hintText: "Describe your property with details about condition, features, etc.",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                  maxLines: 6,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter property details";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          
          // Preview section
          _buildPropertyPreview(),
          
          SizedBox(height: 20),
          _buildTip(
            "Tip: A detailed description helps potential buyers understand what makes your property special.",
          ),
        ],
      ),
    );
  }
  
  Widget _buildPropertyPreview() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.preview, color: Theme.of(context).primaryColor),
              SizedBox(width: 10),
              Text(
                "Property Preview",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          // Basic info preview
          if (price.text.isNotEmpty)
            _buildPreviewItem("Price", "${price.text} LE"),
          if (numberOfBedrooms.text.isNotEmpty)
            _buildPreviewItem("Bedrooms", numberOfBedrooms.text),
          if (numberOfBathRooms.text.isNotEmpty)
            _buildPreviewItem("Bathrooms", numberOfBathRooms.text),
          if (floorNumber.text.isNotEmpty)
            _buildPreviewItem("Floor", floorNumber.text),
          
          // Location preview
          if (flatAddress.text.isNotEmpty)
            _buildPreviewItem("Location", "${flatCity.text}, ${flatGovernorate.text}"),
          
          // Media preview
          _buildPreviewItem("Photos", "${_images.length} photos uploaded"),
          _buildPreviewItem("Documents", "${_flatDocs.length} documents uploaded"),
        ],
      ),
    );
  }
  
  Widget _buildPreviewItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              "$label:",
              style: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildLocationMap() {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage("assets/images/map_placeholder.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on, color: Theme.of(context).primaryColor, size: 40),
            SizedBox(height: 10),
            Text(
              "Map Location",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "Coming soon",
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildNavButtons(AddFlatProvider provider) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (_currentPage > 0)
            Expanded(
              child: ElevatedButton.icon(
                icon: Icon(Icons.arrow_back),
                label: Text("Previous"),
                onPressed: _previousPage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          if (_currentPage > 0) SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: ElevatedButton.icon(
              icon: Icon(
                _currentPage < _steps.length - 1
                    ? Icons.arrow_forward
                    : Icons.check_circle,
              ),
              label: Text(
                _currentPage < _steps.length - 1 ? "Next" : "Submit",
              ),
              onPressed: provider.isLoading
                  ? null
                  : () {
                      if (_currentPage < _steps.length - 1) {
                        _nextPage();
                      } else {
                        _submitFlat(context);
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
  
  Widget _buildInfoCard({required Widget child}) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
  
  Widget _buildFormRow({
    required IconData icon,
    required String label,
    required Widget field,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: Theme.of(context).primaryColor),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 5),
                field,
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildDivider() {
    return Divider(height: 1, thickness: 1, color: Colors.grey[200]);
  }
  
  Widget _buildTip(String text) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue[100]!),
      ),
      child: Row(
        children: [
          Icon(Icons.lightbulb_outline, color: Colors.blue[700]),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: Colors.blue[700], fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // Preview for Uploaded Images
  Widget _imagesPreview() {
    return Container(
      height: 130,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        itemCount: _images.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  _images[index],
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _images.removeAt(index);
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.close, color: Colors.white, size: 14),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Preview for Uploaded Documents
  Widget _documentsPreview() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _flatDocs.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 8),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                Icons.picture_as_pdf,
                color: Colors.red[700],
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  _flatDocs[index].path.split('/').last,
                  style: TextStyle(fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                icon: Icon(Icons.close, size: 16),
                onPressed: () {
                  setState(() {
                    _flatDocs.removeAt(index);
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
}