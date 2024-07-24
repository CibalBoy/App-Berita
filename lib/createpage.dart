import 'dart:convert';
// import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'package:app_berita/dahspage.dart';
import 'package:flutter/material.dart';
import 'package:app_berita/homepage.dart';
import 'package:http/http.dart' as http;

class CreatePage extends StatefulWidget {
  final String nama;
  final String password;
  const CreatePage({super.key, required this.nama, required this.password});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final judulController = TextEditingController();
  final isiController = TextEditingController();
  final gambarController = TextEditingController();

final _formkey = GlobalKey<FormState>();

Future _OnSubmit() async{
  try{
    return await http.post(
      Uri.parse(url),
      body: {
        "judul": judulController.text,
        "isi": isiController.text,
        "gambar": gambarController.text,
      }
      ).then((value){
        var data = jsonDecode(value.body);
        print(data["message"]);
      
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
         DahsPage(nama: widget.nama, password: widget.password))
        );  
      });
    }catch(e){
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Berita'),
      ),
      body: Form(
        key: _formkey,
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                'judul',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
                ),
                SizedBox(height: 5),
                TextFormField(
                  controller: judulController,
                  decoration: InputDecoration(
                    hintText: "Masukkan Judul Berita",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0)
                    )
                  ),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Judul Berita Harus Diisi';
                    } 
                    return null;
                  },
                ),
                SizedBox(height: 10.0),
              //
              Text(
                'Isi Berita',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
                ),
                SizedBox(height: 5),
                TextFormField(
                  controller: isiController,
                  minLines: 5,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: "Masukkan Isi Berita",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0)
                    )
                  ),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Isi Berita Harus Diisi';
                    } 
                    return null;
                  },
                ),
                SizedBox(height: 10.0),
                //

              Text(
                'Gambar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
                ),
                SizedBox(height: 5),
                TextFormField(
                  controller: gambarController,
                  decoration: InputDecoration(
                    hintText: "Masukkan Gambar Berita",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0)
                    )
                  ),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Gambar Berita Harus Diisi';
                    } 
                    return null;
                  },
                ),
                SizedBox(height: 10.0), 

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)
                    )
                  ),
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: (){
                    //validasi
                      if(_formkey.currentState!.validate()){
                        _OnSubmit();
                      }
                  }
                ) 
            ],
          ),
        )
       ),
    );
 }
}