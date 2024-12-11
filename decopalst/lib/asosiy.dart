import 'package:decopalst/document.dart';
import 'package:decopalst/icomning%20new.dart';
import 'package:decopalst/new%20incoming.dart';
import 'package:decopalst/scan.dart';
import 'package:decopalst/store.dart';
import 'package:decopalst/supliers.dart';
import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:image_picker/image_picker.dart'; // Image picker uchun
import 'dart:io'; // Foydalaniladigan rasmni olish uchun

void main() {
  runApp(ScreenMain());
}

class ScreenMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WELCOME, main store',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> items = [
    {'icon': Icons.production_quantity_limits, 'label': 'Goods', 'screen': Screen2()},
    {'icon': Icons.document_scanner, 'label': 'Documents', 'screen': docsex()},
    {'icon': Icons.qr_code, 'label': 'Scan barcode', 'screen':qrcode() },
     {'icon': Icons.store, 'label': 'Select store', 'screen': stres()},
     {'icon': Icons.person_3_outlined, 'label': 'Suppliers', 'screen': subperson()},
     {'icon': Icons.store, 'label': 'Stores', 'screen': MyWidget()},
     {'icon': Icons.add_box, 'label': 'New Incoming', 'screen': emki()},
  ];

  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "WELCOME, main store",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color.fromARGB(205, 255, 255, 255),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.apps_outage, color: Colors.black),
            onSelected: (String value) {
              if (value == 'hide') {
                setState(() {
                  isVisible = !isVisible;
                });
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'hide',
                child: Text(isVisible ? 'Hide Items' : 'Show Items'),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueGrey[100]),
              child: Text(
                'Menu',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            ...items.map((item) {
              return ListTile(
                leading: Icon(item['icon']),
                title: Text(item['label']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => item['screen']),
                  );
                },
              );
            }).toList(),
          ],
        ),
      ),
      body:Padding(
        padding: const EdgeInsets.all(10.0),
        child: Wrap(
          spacing: 20, // Horizontal space between items
          runSpacing: 20, // Vertical space between lines
          children: items.map((item) {
            return Visibility(
              visible: isVisible, // Ensure visibility is controlled
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => item['screen']),
                  );
                },
                child: Container(
                  width: 200,
                  height: 200,
                  child: buildClayContainer(
                    icon: item['icon'],
                    label: item['label'],
                    baseColor: Colors.blueGrey[100]!,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
    
  }

  Widget buildClayContainer({
    required IconData icon,
    required String label,
    required Color baseColor,
  }) {
    return ClayContainer(
      color: baseColor,
      borderRadius: 20,
      depth: 30,
      spread: 15,
      curveType: CurveType.concave,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.black),
          SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

        ],
      ),
    );

    
  }
}

// Goods Page


class Screen2 extends StatefulWidget {
  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  bool _isSearching = false;
  TextEditingController _searchController = TextEditingController(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Goods'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
              });
            },
            icon: Icon(Icons.search),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: _isSearching
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                          },
                        ),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRESuKuskirZztnNWl6Km3EFNW5c6ug9c1Ebg&s"),
            ),
            Text(
              'Add your goods',
              style: TextStyle(fontSize: 24, color: Color.fromARGB(255, 188, 184, 184)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 239, 154, 51),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CVV()), // Make sure CVV is a defined widget.
          );
        },
        child: Icon(Icons.add_box),
      ),
    );
  }
}

// Add Product Page
class CVV extends StatefulWidget {
  @override
  _CVVState createState() => _CVVState();
}

class _CVVState extends State<CVV> {
  String selectedCategory = '';
  final TextEditingController nameController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController widthController = TextEditingController();
  final TextEditingController lengthController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Add Product',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Category',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: ['Panels', 'Rebresties', 'Accessories', 'natyajnoy']
                  .map((category) => GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = category;
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: selectedCategory == category
                                  ? Color.fromARGB(255, 241, 167, 39)
                                  : const Color.fromARGB(255, 219, 215, 215),
                              width: selectedCategory == category ? 3 : 1,
                            ),
                            color: selectedCategory == category
                                ? Color.fromARGB(255, 240, 186, 77)
                                : Colors.white,
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Text(
                            category,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ))
                  .toList(),
            ),
            SizedBox(height: 20),
            if (selectedCategory.isNotEmpty)
              Expanded(
                child: SingleChildScrollView(scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Product Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: modelController,
                        decoration: InputDecoration(
                          labelText: 'Product Model',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: widthController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Width',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: lengthController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Length',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: quantityController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Quantity',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Price',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text('Product Image'),
                      GestureDetector(
  onTap: _pickImage,
  child: Container(
    height: 200,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(10),
    ),
    child: _image == null
        ? Center(
            child: IconButton(
              onPressed: _pickImage, // Open gallery when the icon is pressed
              icon: Icon(Icons.photo),
            ),
          )
        : Image.file(_image!),
  ),
),

                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                           
                            ),
                            child: Text('Cancel'),
                          ),
                          SizedBox(width: 20,),
                          ElevatedButton(
                            onPressed: () {
                              // Save logic goes here
                            },
                            child: Text('Save'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            else
              Center(child: Text('Please select a category')),
          ],
        ),
      ),
    );
  }
}
