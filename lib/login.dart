import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_berita/dahspage.dart';

class Login extends StatelessWidget {
  //const Login({super.key});
  final myUsernameController = TextEditingController();
  final myPasswordController = TextEditingController();
  late String nUsername, nPassword;

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Login Page"))
        ),
        body: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  //cek data field jika kosong
                  validator: (value){
                    if(value!.isEmpty){
                      return "Username di isi dong";
                    }
                    return null;
                  },
                  controller: myUsernameController,
                  decoration: InputDecoration(
                    hintText: 'Input Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                  SizedBox(height: 10.0),
                   TextFormField(
                  //cek data field jika kosong
                  validator: (value){
                    if(value!.isEmpty){
                      return "Password di isi dong";
                    }
                    return null;
                  },
                  maxLength: 16,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  obscureText: true,
                  controller: myPasswordController,
                  decoration: InputDecoration(
                    hintText: 'Input Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                SizedBox(height: 25.0),
                MaterialButton(
                  minWidth: 85.0,
                  height: 50.0,
                  color: Colors.green,
                  textColor: Colors.white,
                  onPressed: (){
                    //dapatkan value dari textformfield
                    nUsername = myUsernameController.text;
                    nPassword = myPasswordController.text;
            
                    if(_formkey.currentState!.validate()){
                      if(nUsername != 'admin'){
                        print("Username Salah");
                      }else if(nPassword.length <= 5){
                        print("Password Kurang dari 5 Karakter");
                      }else{
                        //aksi untuk menuju dashboard karena berhasil login
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_){
                            return DahsPage(nama: nUsername, password: nPassword);
                          })
                        );
                      }
                    }
                  },
                  child: Text('Submit'),
                )
              ],
            ),
          )
          ),
      );
  }
}