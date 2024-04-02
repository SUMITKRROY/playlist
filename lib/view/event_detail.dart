import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../database/table/event_table.dart'; // Import your PlayListTable

import '../provider/playlist/playlist_bloc.dart';
import '../utils/colors.dart';
import '../utils/widgets/button.dart';
import '../utils/widgets/custom_TextFeild.dart';
import '../utils/widgets/search_equal.dart';

class EventDetails extends StatefulWidget {
  final int noteId;

  const EventDetails({Key? key, required this.noteId}) : super(key: key);

  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  late String taskController;
  late String descriptionController;
  String _imagePath = '';
  String date = '';
  String startTime = '';
  String endTime = '';
  String description = '';

  List<Map<String, dynamic>> playList = [];
  @override
  void initState() {
    super.initState();
    loadNoteDetails();
  }

  Future<void> loadNoteDetails() async {
    // Retrieve existing note details from the database based on the note ID
    Map<String, dynamic> noteDetails =
        await PlayListTable().getNoteById(widget.noteId);
    print("noteDetails $noteDetails");
    setState(() {
      taskController = noteDetails[PlayListTable.title];
      descriptionController = noteDetails[PlayListTable.content];
      _imagePath = noteDetails[PlayListTable.imagePath];
      date = noteDetails[PlayListTable.date] ?? "no image";
      startTime = noteDetails[PlayListTable.startTime] ?? "startTime";
      endTime = noteDetails[PlayListTable.endTime] ?? "endTime";
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        iconTheme: IconThemeData(color: CustomColors.black),
        backgroundColor: CustomColors.white,
        title: Text(
          'Event details',
          style: TextStyle(color: CustomColors.black),
        ),
        actions: [SearchIcon()],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(08.0),
          child: Flex(
            mainAxisAlignment: MainAxisAlignment.start,
            direction: Axis.vertical,
            children: [
              GestureDetector(
                onTap: () {
                  // Handle onTap
                },
                child: Image.asset(
                  _imagePath,
                  height: 200,
                  width: width,
                  fit: BoxFit.fill,
                ),
              ),
              //CustomButton(onPressed: saveChanges, label: "Update")
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(),
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Container(
                  height: 60, // Adjusted height to accommodate the content
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 20,
                        child: Text('1'),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 20,
                        child: Text('2'),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 20,
                        child: Text('3'),
                      ),
                      SizedBox(
                        width: 05,
                      ),
                      Positioned(
                        //   left: 80,
                        //  top: 10,
                        child: Text(
                          "+20 Going",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.indigoAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                "Music Concert",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Card(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.calendar_month_rounded,
                          size: 30,
                        ),
                      )),
                      Column(
                        children: [
                          Text(
                            date,
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            "$startTime - $endTime",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.location_on,
                              size: 30,
                            ),
                          )),
                      Column(
                        children: [
                          Text(
                            "Gala Convention Center",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            "36 Guild Street London,UK",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Text(
                "About Event",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(descriptionController,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),) ,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
