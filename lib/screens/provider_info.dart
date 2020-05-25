import 'package:flutter/material.dart';
//
import 'package:Eventory/util/review_data.dart'; //references
import 'package:Eventory/util/const.dart';
import 'package:Eventory/util/providers_data.dart';
//
import 'package:Eventory/widgets/smooth_star_rating.dart'; //format
//
import 'package:Eventory/services/calls_and_messages_service.dart';
import 'package:Eventory/services/service_locator.dart';
import 'package:table_calendar/table_calendar.dart';
//
import 'package:Eventory/screens/provider_review.dart';
import 'package:intl/intl.dart'; //destination


void supplierinfo() {
  setupLocator();
  runApp(SupplierInfo());
}

class SupplierInfo extends StatefulWidget {
  @override
  _SupplierInfoState createState() => _SupplierInfoState();
}

class _SupplierInfoState extends State<SupplierInfo> {

  final _scaffoldKey = GlobalKey<ScaffoldState>(); //snackbar
  bool _isFav = false;
  DateTime dateAdded;
  String favoriteAdded;

  Map<DateTime, List> _events; //date of event, description
  CalendarController _calendarController;

  final CallsAndMessagesService _service = locator<CallsAndMessagesService>();
  final String number = "09203521547";
  
  @override
  void initState() {
    super.initState();
    setState(() {
    _isFav = false;
    });
  
    _events = {
      DateTime(2020, 3, 17): ['Booked'], //data
      DateTime(2020, 3, 20): ['Booked'],
      DateTime(2020, 3, 28): ['Booked'],
    };

    _calendarController = CalendarController();
  }

  @override
  void dispose(){
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          "About the Supplier",
        ),
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 10.0),
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 3.2,
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      "${suppliers[1]['img']}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: -10.0,
                  bottom: 3.0,
                  child: RawMaterialButton(
                  onPressed: () {
                  if (_isFav == false) {
                    setState(() {
                    _isFav = true;
                    dateAdded = DateTime.now();
                    favoriteAdded = DateFormat.yMMMMd("en_US").format(dateAdded);
                    print(favoriteAdded);
                    _scaffoldKey.currentState.showSnackBar(
                    SnackBar(
                      content: Text('Added to your Favorites'),
                      duration: Duration(seconds: 2),
                      backgroundColor: Theme.of(context).accentColor,
                      )
                      );
                    });
                  } else {
                    setState(() {
                    _isFav = false;
                    favoriteAdded = '';
                    print(favoriteAdded);
                    _scaffoldKey.currentState.showSnackBar(
                    SnackBar(
                      content: Text('Removed from your Favorites'),
                      duration: Duration(seconds: 2),
                      backgroundColor: Theme.of(context).accentColor,
                      )
                      );
                    });
                  }
                    }, //add to favorites function
                    fillColor: Colors.white,
                    shape: CircleBorder(),
                    elevation: 4.0,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(
                        _isFav ? Icons.favorite : Icons.favorite_border,
                        color: Color.fromARGB(1000, 103, 0, 160),
                        size: 17,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.only(bottom: 2.0, top: 8.0),
              child: Text(
                "${suppliers[1]['name']}",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w900,
                ),
                maxLines: 2,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 2.0, top: 3.0),
              child: Text(
                "${suppliers[1]['scategory']}",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.star),
                  Text(
                    "  Rating:",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    "2 out 5 (2 Ratings)", //must change
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.local_offer),
                  Text(
                    "  Service Fee Starts at:",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    "${suppliers[1]['srate']} PHP", //must change
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.hourglass_full),
                  Text(
                    "  Years of Experience as ${suppliers[1]['scategory']}:",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    "${suppliers[1]['yearsxp']}", //must change
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            SizedBox(height: 10.0),
            Text(
              "Bio",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            SizedBox(height: 10.0),
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: <Widget>[
                Text("${suppliers[1]['bio']}",
                style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
              ),
             ]
            ),            
            SizedBox(height: 10.0),
            Divider(),
            SizedBox(height: 10.0),
            Text(
              "Availability",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            SizedBox(height: 10.0),
          Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
           _buildTableCalendar(),
          // Expanded(
          //   child: _buildEventList()
          //   ),
        ],
      ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Reviews",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                  maxLines: 2,
                ),
                FlatButton(
                  child: Text(
                    "+ Add Review",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return NewReview();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              itemCount: reviews == null ? 0 : reviews.length,
              itemBuilder: (BuildContext context, int index) {
                Map review = reviews[index];
                return ListTile(
                  leading: CircleAvatar(
                    radius: 25.0,
                    backgroundImage: AssetImage(
                      "${review['img']}",
                    ),
                  ),
                  title: Text("${review['name']}"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 5.0),
                      Row(
                        children: <Widget>[
                          SmoothStarRating(
                            starCount: 2,
                            color: Constants.ratingBG,
                            allowHalfRating: true,
                            rating: 2.0,
                            size: 12.0,
                          ),
                          SizedBox(width: 6.0),
                          Text(
                            "|   February 14, 2020",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 7.0),
                          Wrap(
                            spacing: 0.0,
                            runSpacing: 2.0,
                            children: <Widget>[
                            Text("${review["review"]}"
                            ),
                            ]
                          ),
                      SizedBox(height: 7.0),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50.0,
        child: RaisedButton(
          child: Text(
            "CONTACT SUPPLIER",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          color: Theme.of(context).accentColor,
          onPressed: () => _service.sendSms("${suppliers[1]['phone']}"), //contact supplier function
        ),
      ),
    );
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      
      startingDayOfWeek: StartingDayOfWeek.sunday,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.purple[400],
        todayColor: Colors.purple[200],
        markersColor: Theme.of(context).accentColor,
        outsideDaysVisible: false,
      ),
      
      onDaySelected: _onDaySelected,
    );
  }
}
