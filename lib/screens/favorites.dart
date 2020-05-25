import 'package:flutter/material.dart';
//
import 'package:Eventory/util/providers_data.dart'; //reference
//
import 'package:Eventory/widgets/favorites_format.dart'; //format


class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> with AutomaticKeepAliveClientMixin<FavoriteScreen>{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0,0,10.0,0),
        child:
        
        ListView(
          children: <Widget>[

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "My Favorites",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            
          SizedBox(height: 5.0),
        
          Container(
              height: 500.0,
              child:
          ListView.builder(
            itemCount: suppliers == null ? 0 :suppliers.length,
            itemBuilder: (BuildContext context, int index) {
              Map supplier = suppliers[index];
              return CartItem (
                img: supplier['img'],
                name: supplier['name'],
                scategory: supplier['scategory'],
                dateAdded: 'March 17, 2020',
              );
              },
            ),          
          ),
        ],
      ),
    ),
  );
}

  @override
  bool get wantKeepAlive => true;
}
