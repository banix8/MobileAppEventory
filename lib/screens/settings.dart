import 'package:flutter/material.dart';
//
import 'package:Eventory/util/const.dart'; //reference
//
import 'package:provider/provider.dart';
import 'package:Eventory/providers/app_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
//
import 'package:share/share.dart'; //destinations
import 'package:Eventory/screens/splash.dart';


class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  String name = ''; //added by Jhunes
  bool isLoggedIn = false; //added by Jhunes

  Future<Null> logout() async { //added by Jhunes
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('accountID', null);

    setState(() {
      name = '';
      isLoggedIn = false;
      return;
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0,0,10.0,0),

        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                
              // Text(
              //   "  Settings".toUpperCase(),
              //   style: TextStyle(
              //     fontSize: 16.0,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),

              //   FlatButton(
              //     child:
              //     IconButton(
              //   icon: Icon(
              //     Icons.settings,
              //     size: 20.0,
              //   ),
              //   onPressed: (){
              //     //CRUD function here
              //   },
              // ),
              //     onPressed: (){
              //     //CRUD function here
              //     }
              //   ),
              ],
             ),
            
              ListTile(
              title: Text(
                "Dark Theme",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),

              trailing: Switch(
                value: Provider.of<AppProvider>(context).theme == Constants.lightTheme
                    ? false
                    : true,
                onChanged: (v) async{
                  if (v) {
                    Provider.of<AppProvider>(context, listen: false)
                        .setTheme(Constants.darkTheme, "dark");
                  } else {
                    Provider.of<AppProvider>(context, listen: false)
                        .setTheme(Constants.lightTheme, "light");
                  }
                },
                activeColor: Theme.of(context).accentColor,
              ),
            ),

            Divider(),

            ListTile(
              title: Text(
                "Share EVENTory",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),

              trailing:
                  IconButton(
                      icon: Icon(
                        Icons.share,
                        color: Theme.of(context).accentColor,
                      ),
              onPressed: (){
                  final RenderBox box = context.findRenderObject();
                  Share.share("I found this app called EVENTory. I've been using it to find available Event Suppliers for my events. Give it a try: Download EVENTory on Google Play: https://play.google.com/store/apps/details?id=eventory.diyeventplanning",
                      subject:"Find Event Suppliers in CDO via EVENTory",
                      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
                },
              )
            ),

            Divider(),

            ListTile(
              title: Text(
                "Logout",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),

              trailing:
                  IconButton(
                      icon: Icon(
                        Icons.exit_to_app,
                        color: Theme.of(context).accentColor,
                      ),
                      onPressed: () {
                        logout(); //added by Jhunes
                        Navigator.of(context).push(
                        MaterialPageRoute(
                        builder: (BuildContext context){
                        return SplashScreen();
                    },
                  ),
                );
                      },
                    ),
            ),

            Divider(),

          ],
        ),
      ),
    );
  }
}