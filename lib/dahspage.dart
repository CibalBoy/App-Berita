import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:app_berita/homepage.dart';
import 'package:app_berita/newsdetail.dart';
import 'package:app_berita/createpage.dart';
import 'package:app_berita/editpage.dart';
import 'package:http/http.dart' as http;

class DahsPage extends StatefulWidget {
  final String nama;
  final String password;
  const DahsPage({super.key, required this.nama, required this.password});

  @override
  State<DahsPage> createState() => _DahspageState();
}

class _DahspageState extends State<DahsPage> { 
  Future _onDelete(String id) async {
    try{
       return await http.delete(Uri.parse(url+"/"+id),
      body: {
        "id" : id,
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, 
          MaterialPageRoute(builder: (context) => CreatePage(nama: widget.nama, password: widget.password))
          );
        },
        ),
      appBar: AppBar(
        leading: Icon(Icons.list),
        title: Center(child: Text('Dashboard, Hi ${widget.nama}')),
        actions: [
          GestureDetector(
            // onTap: () {
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
            // },
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Icon(Icons.logout),
              ),
          )
        ],
      ),
      body:FutureBuilder(
        future: fetchNews(), 
        builder: (context, Snapshot){
          if(Snapshot.hasData){
            return ListView.builder(
              itemCount: Snapshot.data['data'].length,
              itemBuilder: (context, index){
                return Container(
                  height: 180,
                  child: Card(
                    elevation: 5,
                    child: Row(
                      children: [
                        Container(
                          height: 120,
                          padding: EdgeInsets.all(10),
                          child: Image.network(urlm + '/img/' + Snapshot.data['data'][index]['gambar']),
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                       MaterialPageRoute(builder: (context)=> NewsDetail(news : Snapshot.data['data'][index]))
                                       );
                                    },
                                    child: Text(Snapshot.data['data'][index]['judul'], 
                                    style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                  Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(Snapshot.data['data'][index]['isi'], maxLines: 6,
                                   style: TextStyle(fontSize: 10.0)),
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, 
                                         MaterialPageRoute(builder: (context)=> 
                                         Editpage(
                                          nama: widget.nama,
                                          password: widget.password,
                                          id: Snapshot.data['data'][index]['id']
                                          )),
                                        );
                                      },
                                      child: Icon(Icons.edit)
                                      ),
                                      IconButton(
                                      onPressed: (){
                                        showDialog(context: context,
                                        builder: (BuildContext context){
                                          return AlertDialog(
                                            content: Text("Apakah anda ingin menghapus berita ini..?"),
                                            actions: <Widget>[
                                              ElevatedButton(
                                                onPressed: () => Navigator.of(context).pop(),
                                              child: Icon(Icons.cancel)),
                                              ElevatedButton(
                                                onPressed: () => _onDelete(Snapshot.data['data']['index']['id']), 
                                                child: Icon(Icons.check_circle))
                                            ],
                                          );
                                        }
                                        );
                                      }, 
                                      icon: Icon(Icons.delete)
                                      ), 
                                    //Icon(Icons.delete),
                                  ],
                                )
                              ],
                            ),
                          )
                          )
                      ],
                    ),
                  ),
                );
              }
              );
        }else{
          return const Text('Data Error');
          }
        }
      )  
      //ListView(
       // children: <Widget>[
         // Text('Nama : ${widget.nama}'),
          //Text('Password : ${widget.password}'),
        //],
      //),
    );
  }
}