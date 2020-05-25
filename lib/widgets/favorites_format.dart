import 'package:flutter/material.dart';
import 'package:Eventory/screens/provider_info.dart';

class CartItem extends StatelessWidget {
  final String name;
  final String img;
  final String scategory;
  final String dateAdded;

  CartItem({
    Key key,
    @required this.name,
    @required this.img,
    @required this.scategory,
    @required this.dateAdded, category})
      :super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: InkWell(
        onTap: (){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context){
                return SupplierInfo();
              },
            ),
          );
        },
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 0.0, right: 10.0),
              child: Container(
                height: MediaQuery.of(context).size.width/3.5,
                width: MediaQuery.of(context).size.width/3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    "$img",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
              
                Text(
                  "$name",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              
                Text(
                  "$scategory",
                  style: TextStyle(
                    fontSize: 12.0,
              ),
              maxLines: 2,
            ),
                SizedBox(height: 10.0),
                
                Row(
                  children: <Widget>[
                    Text(
                      "Date Added: " + dateAdded, //must change
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
              ],

            ),
          ],
        ),
      ),
    );
  }
}
