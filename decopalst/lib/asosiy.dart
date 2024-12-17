import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MaterialApp(home: PostApiPage()));
}

class PostApiPage extends StatefulWidget {
  @override
  _PostApiPageState createState() => _PostApiPageState();
}

class _PostApiPageState extends State<PostApiPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomiController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _eniController = TextEditingController();
  final TextEditingController _uzunligiController = TextEditingController();
  final TextEditingController _catController = TextEditingController();
  final TextEditingController _storeController = TextEditingController();

  File? _image;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  List<Map<String, dynamic>> data = [];
  bool isLoading = true;

  // Fetch Data from API
  Future<void> fetchData() async {
    try {
      final response =
          await http.get(Uri.parse("https://dash.vips.uz/api/49/7281/78440"));
      if (response.statusCode == 200) {
        final List<dynamic> fetchedData = jsonDecode(response.body);
        setState(() {
          data = fetchedData.cast<Map<String, dynamic>>();
          isLoading = false;
        });
      } else {
        throw Exception("Ma'lumotlar topilmadi");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Xatolik: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> del(String id) async {
    final String url = 'https://dash.vips.uz/api-del/49/7281/78440?id=$id';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'apipassword': '1234',
          // 'where': "id:$id",
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        print('Response: $responseData');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ma`lumot ochirildi')),
        );
        fetchData(); // Ma'lumotlarni yangilash
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Xatolik: ${response.statusCode}')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tarmoq xatosi yuz berdi')),
      );
    }
  }

   //update function
   Future<void> upData(String id, String nomi, String model, String eni,String uzunligi, String categoryid,String storeid ) async {
    final String url = 'https://dash.vips.uz/api-up/49/7281/78440';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'apipassword': '1234',
          'nomi': nomi,
          'model': model,
          'eni': eni,
          'uzunligi':uzunligi,
          'categoryid':categoryid,
          'storeid':storeid,
          'where': "id:$id",
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        print('Response: $responseData');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Malumot muvaffaqiyatli yangilandi!')),
        );
        fetchData(); // Ma'lumotlarni yangilash
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Xatolik: ${response.statusCode}')), 
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tarmoq xatosi yuz berdi')),
      );
    }
  }


   void showEditDialog(Map<String, dynamic> item) {
    
    TextEditingController nameController = TextEditingController(text: item["nomi"]);
    TextEditingController infoController = TextEditingController(text: item["model"]);
    TextEditingController narxiController = TextEditingController(text: item["eni"]);
     TextEditingController werController = TextEditingController(text: item["uzunligi"]);
      TextEditingController kerController = TextEditingController(text: item["categoryid"]);
       TextEditingController cerController = TextEditingController(text: item["stoer"]);
    

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Ma'lumotlarni o'zgartirish"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: "nomi"),
                ),
                TextField(
                  controller: infoController,
                  decoration: InputDecoration(labelText: "model"),
                ),
                TextField(
                  controller: narxiController,
                  decoration: InputDecoration(labelText: "eni"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: werController,
                  decoration: InputDecoration(labelText: "uzunligi"),
                  keyboardType: TextInputType.number,
                ),
             
             TextField(
                  controller: kerController,
                  decoration: InputDecoration(labelText: "categoryid"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: cerController,
                  decoration: InputDecoration(labelText: "storeid"),
                  keyboardType: TextInputType.number,
                ),
               SizedBox(height: 10),
                      GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          width: 100,
                          height: 100,
                          color: Colors.grey[300],
                          child: _image == null
                              ? Icon(Icons.camera_alt, size: 40)
                              : Image.file(_image!, fit: BoxFit.cover),
                        ),
                      ),
             
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Bekor qilish"),
            ),
            TextButton(
              onPressed: () {
                upData(
                  item["id"],
                  nameController.text,
                  infoController.text,
                  narxiController.text,
                   werController.text,
                  kerController.text,
                   cerController.text,
                 
                );
                Navigator.of(context).pop();
              },
              child: Text("Saqlash"),
            ),
          ],
        );
      },
    );
  }


  // Post Data Function
  Future<void> postData(String nomi, String model, String eni, String uzunligi,
      String categoryId, String storeId) async {
    final String url = 'https://dash.vips.uz/api-in/49/7281/78440';
    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['apipassword'] = '1234';
      request.fields['nomi'] = nomi;
      request.fields['model'] = model;
      request.fields['eni'] = eni;
      request.fields['uzunligi'] = uzunligi;
      request.fields['categoryid'] = categoryId;
      request.fields['do`konnomi'] = storeId;

      if (_image != null) {
        request.files
            .add(await http.MultipartFile.fromPath('image', _image!.path));
      }

      final response = await request.send();
      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data posted successfully!')),
        );
        fetchData(); // Refresh data
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to post data: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void showDeleteDialog(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Bu elementni o`chirasizmi?"),
          content: Text("Ushbu elementning ID si: $id"),
          actions: [
            TextButton(
              onPressed: () {
               del(id);
                print(id);
                Navigator.of(context).pop();
              },
              child: Text("Delete", style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  Widget buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value == null || value.isEmpty ? 'Iltimos, $label kiriting' : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Goods')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    elevation: 3,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 30,
                        child:
                        
                         Icon(Icons.shopping_bag),
                      ),
                      title: Text("Nomi: ${data[index]["nomi"]}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Model: ${data[index]["model"]}"),
                          Text("Eni: ${data[index]["eni"]}"),
                          Text("Uzunligi: ${data[index]["uzunligi"]}"),
                            Text("categorysi: ${data[index]["categoryid"]}"),
                              Text("store: ${data[index]["store"]}"),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.delete, color: const Color.fromARGB(255, 224, 203, 170)),
                            onPressed: () => showDeleteDialog(data[index]['id']),
                          ),
                                                   
                           IconButton(
                            icon: Icon(Icons.edit, color: const Color.fromARGB(255, 216, 200, 158)),
                            onPressed: (){
                               showEditDialog(data[index]);
                            }
                                                         ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Mahsulot qo'shish"),
              content: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      buildTextField(_nomiController, 'Nomi'),
                      buildTextField(_modelController, 'Model'),
                      buildTextField(_eniController, 'Eni'),
                      buildTextField(_uzunligiController, 'Uzunligi'),
                      buildTextField(_catController, 'Category ID'),
                      buildTextField(_storeController, 'Store ID'),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          width: 100,
                          height: 100,
                          color: Colors.grey[300],
                          child: _image == null
                              ? Icon(Icons.camera_alt, size: 40)
                              : Image.file(_image!, fit: BoxFit.cover),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await postData(
                        _nomiController.text,
                        _modelController.text,
                        _eniController.text,
                        _uzunligiController.text,
                        _catController.text,
                        _storeController.text,
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Add"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel"),
                ),
              ],
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
