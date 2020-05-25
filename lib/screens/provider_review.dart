import 'package:flutter/material.dart';
//
import 'package:Eventory/util/providers_data.dart'; //reference
//
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Eventory/flutter_rating_bar.dart';


class NewReview extends StatefulWidget {
  @override
  _NewReviewState createState() => _NewReviewState();
}

class _NewReviewState extends State<NewReview> {

  TextEditingController _ratingControl = TextEditingController();
  TextEditingController _reviewControl = TextEditingController();

  double _rating;
  int _ratingBarMode = 1;

  bool _isVertical = false;
  IconData _selectedIcon;

  String rating, review;

  @override
  void dispose(){
    _ratingControl.dispose();
    _reviewControl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _ratingControl.text = "3.0";
    _reviewControl.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Adding Review for",
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            tooltip: "Back",
            icon: Icon(
              Icons.clear,
              color: Theme.of(context).accentColor,
            ),
            onPressed: ()=>Navigator.pop(context),
          ),
        ],
      ),

      body: 
      Padding(
        padding: EdgeInsets.fromLTRB(10.0,0,10.0,130),
        child:
        ListView(
          children: <Widget>[
            SizedBox(height: 10.0),

            Padding(
            padding: EdgeInsets.only(bottom: 2.0, top: 8.0),
            child: Text(
              "${suppliers[1]['name']} (${suppliers[1]['scategory']})",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w900,
              ),
              maxLines: 2,
            ),
          ),

          SizedBox(height: 5.0),
          Divider(),

            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  _ratingBar(_ratingBarMode), //default sample rating
                  SizedBox(
                    height: 20.0,
                  ),
                  _rating != null
                      ? Text(
                          "Rating: $_rating",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      : Container(),

                  SizedBox(
                    height: 20.0,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ],
              ),
            ),

          ],
          ),
      ),

bottomSheet:
        Card(
        elevation: 4.0,
        child: Container(

          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(

                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  child:
                  
                  TextField(
                  controller: _reviewControl,
                  onChanged: (value){
                    debugPrint('review: $value');
                    review = value; //SEND THIS DATA
                    debugPrint(review);
                },
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(color: Colors.grey[200],),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[200],),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: "Enter your review here",
                      prefixIcon: Icon(
                        FontAwesomeIcons.pen,
                        color: Theme.of(context).accentColor,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                      ),
                    ),
                    maxLines: 1,
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.fromLTRB(10,5,5,5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                      ],
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.fromLTRB(5,5,10,5),
                    width: 150.0,
                    height: 50.0,
                    child: FlatButton(
                      color: Theme.of(context).accentColor,
                      child: Text(
                        "Send".toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: ()=>Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
          height: 130,
        ),
      ),
    );
  }

Widget _ratingBar(int mode) {
        return RatingBar(
          initialRating: 2,
          minRating: 1,
          direction: _isVertical ? Axis.vertical : Axis.horizontal,
          allowHalfRating: true,
          unratedColor: Colors.yellow.withAlpha(50),
          itemCount: 5,
          itemSize: 50.0,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            _selectedIcon ?? Icons.star,
            color: Colors.yellow,
          ),
          onRatingUpdate: (rating) {
            setState(() {
              _rating = rating; //SEND THIS DATA
              print(rating);
            });
          },
        );
    }

}

