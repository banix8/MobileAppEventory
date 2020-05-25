import 'package:flutter/material.dart';
//
import 'package:image_picker_modern/image_picker_modern.dart';
//import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
 Profile({this.username});
  final String username;
  
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  
  final TextEditingController _fullnameControl = TextEditingController();
  final TextEditingController _emailControl = TextEditingController();
  final TextEditingController _phoneControl = TextEditingController();
  final TextEditingController _addressControl = TextEditingController();
  final TextEditingController _bioControl = TextEditingController();
  final TextEditingController _srateControl = TextEditingController();
  final TextEditingController _yearsxpControl = TextEditingController();
  final TextEditingController _fbpageControl = TextEditingController();
  
  String _picked = 'supplier';
  
  File _image;
  String fullname, email, phone, address, bio, srate, yearsxp, fbpage;
  String name = '';
  String emailAdd = '';


  Future getImage() async {
    var image = await
    ImagePicker.pickImage(source:
    ImageSource.gallery);
    
    setState(() {
      _image = image; //SEND DATA
    });
  }


  Future<String> getData() async {
    http.Response response = await http.get(
      Uri.encodeFull("http://192.168.1.9/eventory/REST_API/getdata.php"),
      headers: {
       "Accept": "application/json" 
      }
    );

    print(response.body);

     List data = json.decode(response.body);
    // print(data[0]["email"]);
    // print(data[0]["password"]);
    // print(data[0]["fullName"]);
    // print(data[0]["accountType"]);
    setState(() {
        name = data[0]['supplierPhone'];
        emailAdd = data[0]['supplierAddress'];
     
      });
  }

  void updateData() {
    var url = "http://192.168.1.9/eventory/REST_API/updateData.php";

    http.post(url, body: {
      "supplierPhone":_phoneControl.text,
      "supplierAddress":  _addressControl.text,
      "supplierBio": _bioControl .text, 
      "supplierRate": _srateControl.text,
      "supplierYears": _yearsxpControl.text,
       
    });
  }


//  var _categories = ["Caterer","DJ","Event Stylist","Host", "Makeup Artist","Entertainer","Photographer","Videographer"];

  @override
  Widget build(BuildContext context) {
    if (_picked == 'supplier') {
      return Scaffold(
        body: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child:
                   _image == null ? 
                    Image.asset(
                      "assets/cm4.jpeg", //GET IMAGE DATA
                      fit: BoxFit.cover,
                      width: 100.0,
                      height: 100.0,
                    ) :
                    Image.file(_image,
                      fit: BoxFit.cover,
                      width: 100.0,
                      height: 100.0,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "$name",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Event Service Provider",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        InkWell(
                          onTap: () {
                            getImage();
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (BuildContext context){
                            //       return JoinApp();
                            //     },
                            //   ),
                            // );
                          },
                          child: Text(
                            "Change Photo",
                            style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).accentColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    flex: 3,
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "  Account Information".toUpperCase(),
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FlatButton(
                      child:
                      Text ('Update'),
                      color: Colors.blueAccent,
                      onPressed: () {
                      updateData();
                      Toast.show("Profile Updated", context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                      //getData();
                      }
                      ),
                ],
              ),
              TextField(
                controller: _fullnameControl,
                onChanged: (value){
                  debugPrint('fullname: $value');
                  fullname = value; //SEND THIS DATA
                  debugPrint(fullname);
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: '$name',
                  labelStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                  hintText: 'Enter full name',
                  border: InputBorder.none,
                ),
              ),
              TextField(
                controller: _emailControl,
                onChanged: (value){
                  debugPrint('email: $value');
                  email = value; //SEND THIS DATA
                  debugPrint(email);
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  labelText: '$emailAdd',
                  labelStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                  hintText: 'email',
                  border: InputBorder.none,
                ),
              ),
              TextField(
                controller: _phoneControl,
                onChanged: (value){
                  debugPrint('phone: $value'); //SEND THIS DATA
                  phone = value;
                  debugPrint(phone);
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.phone),
                  labelText: 'Phone',
                  labelStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                  hintText: 'Enter phone number',
                  border: InputBorder.none,
                ),
              ),
              TextField(
                controller: _addressControl,
                onChanged: (value){
                  debugPrint('address: $value');
                  address = value; //SEND THIS DATA
                  debugPrint(address);
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.home),
                  labelText: 'Address',
                  labelStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                  hintText: 'Enter full address',
                  border: InputBorder.none,
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "  Service Information".toUpperCase(),
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FlatButton(
                      child:
                      Text (''),
                      onPressed: () {}
                      ),
                ],
              ),
              TextField(
                controller: _bioControl,
                onChanged: (value){
                  debugPrint('bio: $value');
                  bio = value; //SEND THIS DATA
                  debugPrint(bio);
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.subject),
                  labelText: 'Bio',
                  labelStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                  hintText: 'Tell more about yourself',
                  border: InputBorder.none,
                ),
              ),
              TextField(
                controller: _srateControl,
                onChanged: (value){
                  debugPrint('srate: $value');
                  srate = value; //SEND THIS DATA
                  debugPrint(srate);
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.local_offer),
                  labelText: 'Starting Rate',
                  labelStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                  hintText: 'Enter your starting rate (PHP)',
                  border: InputBorder.none,
                ),
              ),
              TextField(
                controller: _yearsxpControl,
                onChanged: (value){
                  debugPrint('yearsxp: $value');
                  yearsxp = value; //SEND THIS DATA
                  debugPrint(yearsxp);
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.hourglass_full),
                  labelText: 'Years of Experience',
                  labelStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                  hintText: 'Enter your years of experience',
                  border: InputBorder.none,
                ),
              ),
              TextField(
                controller: _fbpageControl,
                onChanged: (value){
                  debugPrint('fb page: $value');
                  fbpage = value; //SEND THIS DATA
                  debugPrint(fbpage);
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.web),
                  labelText: 'Facebook Page',
                  labelStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                  hintText: 'Enter your Facebook Page Name',
                  border: InputBorder.none,
                ),
              ),

              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "  Availability".toUpperCase(),
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FlatButton(
                      child:
                      Text (''),
                      onPressed: () {}
                      ),
                ],
              ),
              SizedBox(height: 30.0),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Image.asset(
                      "assets/cm4.jpeg",
                      fit: BoxFit.cover,
                      width: 100.0,
                      height: 100.0,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Neo Lamperouge",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Client",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                //insert UPLOAD PHOTO function
                              },
                              child: Text(
                                "Change Photo",
                                style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).accentColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    flex: 3,
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "  Account Information".toUpperCase(),
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FlatButton(
                      child:
                      Text (''),
                      onPressed: () {}
                      ),
                ],
              ),
              TextField(
                onChanged: (value){
                  debugPrint('full name: $value');
                  fullname = value; //SEND THIS DATA
                  debugPrint(fullname);
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: 'Full Name',
                  labelStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                  hintText: 'Enter full name',
                  border: InputBorder.none,
                ),
              ),
              TextField(
                onChanged: (value){
                  debugPrint('email: $value');
                  email = value; //SEND THIS DATA
                  debugPrint(email);
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                  hintText: 'Enter email address',
                  border: InputBorder.none,
                ),
              ),
              TextField(
                controller: _phoneControl,
                onChanged: (value){
                  debugPrint('phone: $value');
                  phone = value; //SEND THIS DATA
                  debugPrint(phone);
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.phone),
                  labelText: 'Phone',
                  labelStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                  hintText: 'Enter phone number',
                  border: InputBorder.none,
                ),
              ),
              TextField(
                controller: _addressControl,
                onChanged: (value){
                  debugPrint('address: $value');
                  address = value; //SEND THIS DATA
                  debugPrint(address);
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.home),
                  labelText: 'Address',
                  labelStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                  hintText: 'Enter full address',
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
