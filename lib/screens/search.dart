import 'package:flutter/material.dart';
//
//import 'package:Eventory/podo/note.dart'; //reference
//
import 'package:intl/intl.dart';
//import 'package:http/http.dart' as http;
//import 'dart:convert';
//
//import 'package:Eventory/screens/provider_info.dart'; //destination

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with AutomaticKeepAliveClientMixin<SearchScreen>{

  final TextEditingController _searchControl = new TextEditingController();

  String _selectedDate = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (d != null)
      setState(() {
        _selectedDate = new DateFormat.yMMMMd("en_US").format(d);
      });
  }

  // List<Note> _notes = List<Note>();
  // List<Note> _notesForDisplay = List<Note>();

  // Future<List<Note>> fetchNotes() async {
  //   var url = "http://192.168.169.2/eventinventory/login.php";
  //   var response = await http.post(url, body: {"event": "search"});

  //   var notes = List<Note>();
  //   if (response.statusCode == 200) {
  //     var notesJson = json.decode(response.body);
  //     for (var noteJson in notesJson) {
  //       notes.add(Note.fromJson(noteJson));
  //     }
  //   }
  //   return notes;
  // }

  // @override
  // void initState() {
  //   fetchNotes().then((value) {
  //     setState(() {
  //       _notes.addAll(value);
  //       _notesForDisplay = _notes;
  //     });
  //   });
  //   super.initState();
  // }

 
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0,0,10.0,0),
      child: ListView(
        children: <Widget>[
          SizedBox(height: 10.0),

          Card(
            elevation: 6.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: TextField(
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: Colors.white,),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white,),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: "What supplier do you need?",
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                ),
                maxLines: 1,
                controller: _searchControl,
              ),
            ),
          ),

          Card(
            elevation: 6.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: Row(

                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    InkWell(
                      child: Text(
                          "   Needed on:  " + _selectedDate,
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                          )
                      ),
                      onTap: (){
                        _selectDate(context);
                      },
                    ),
                    
                    Expanded(
                      child:
                      IconButton(
                      alignment: Alignment.centerRight,
                      icon: Icon(Icons.calendar_today),
                      //tooltip: '[Tap to pick the date]',
                      onPressed: () {
                        _selectDate(context);
                      },
                    ),
                    ),
                  ],
                ),      
            ),
          ),

        SizedBox(height: 5.0),

        Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Search Results",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

//           ListView.builder(
//             shrinkWrap: true,
//             primary: false,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: suppliers == null ? 0 :suppliers.length,
//             itemBuilder: (BuildContext context, int index) {
//               Map supplier = suppliers[index];
//               return ListTile(
//                 title: Text(
//                   "${supplier['name']}",
//                   style: TextStyle(
// //                    fontSize: 15,
//                     fontWeight: FontWeight.w900,
//                   ),
//                 ),
                
//                 leading: CircleAvatar(
//                   radius: 25.0,
//                   backgroundImage: AssetImage(
//                     "${supplier['img']}",
//                   ),
//                 ),
//                 trailing: Text(supplier['srate']), //must change

//                 subtitle:
//                 Row(
//                   children: <Widget>[
                    
//                 Text(
//                   "${supplier['scategory']}",
//                   style: TextStyle(
//                     fontSize: 12.0,
//               ),
//               maxLines: 2,
//             ),

//             SizedBox(width: 6.0),

//                     SmoothStarRating(
//                       starCount: 5, //must change
//                       color: Constants.ratingBG,
//                       allowHalfRating: true,
//                       rating: 5.0, //must change
//                       size: 12.0, //must change
//                     ),
//                     SizedBox(width: 6.0),
                    
//                     Text(
//                       "5.0", //must change
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w300,
//                       ),
//                     ),

                  ],
                ),
// //                 onTap: (){
// //                   Navigator.of(context).push(
// //                   MaterialPageRoute(
// //                     builder: (BuildContext context){
// //                       return SupplierInfo();
// //            },
      //      ),
      //    );
      //  },
              );
            }
        //  ),
//         ListView.builder(
//           itemBuilder: (context, index) {
//             return index == 0 ? _searchBar() : _listItem(index - 1);
//           },
//           itemCount: _notesForDisplay.length + 1,
//           ),
//           SizedBox(height: 30),
//         ],
//       ),
//     );
//   }
  //   _searchBar() {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: TextField(
  //       decoration: InputDecoration(hintText: 'Search...'),
  //       onChanged: (text) {
  //         text = text.toLowerCase();
  //         setState(() {
  //           _notesForDisplay = _notes.where((note) {
  //             var noteTitle = note.fullName.toLowerCase();
  //             return noteTitle.contains(text);
  //           }).toList();
  //         });
  //       },
  //     ),
  //   );
  // }

  // _listItem(index) {
  //   return Card(
  //     child: Padding(
  //       padding: const EdgeInsets.only(
  //           top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: <Widget>[
  //           Text(
  //             _notesForDisplay[index].fullName,
  //             style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
  //           ),
  //           Text(
  //             _notesForDisplay[index].email,
  //             style: TextStyle(color: Colors.grey.shade600),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  bool get wantKeepAlive => true;
}