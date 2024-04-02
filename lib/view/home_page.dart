import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playlist/utils/imagePath.dart';
import 'package:playlist/utils/widgets/search_equal.dart';

import '../database/table/event_table.dart';
import '../provider/playlist/playlist_bloc.dart';
import '../utils/widgets/button.dart';
import 'create_event.dart';
import 'event_detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> playList = [];
  List<String> searchNotes = [];
  @override
  void initState() {
    super.initState();
    // BlocProvider.of<PlayListBloc>(context).add(
    //     NotegetEvent(
    //     ));
    _loadNotes();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Refresh notes whenever dependencies change
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    BlocProvider.of<PlayListBloc>(context).add(NotegetEvent());
  }

  Future<void> _deleteNoteFromDatabase(int noteId) async {
    BlocProvider.of<PlayListBloc>(context).add(
        NoteDeleteEvent(id: noteId
        ));
    _loadNotes();
  }

  void updateSearchResults(List<String> results) {
    setState(() {
      searchNotes = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        toolbarHeight: 70,
        title: ListTile(
          leading: CircleAvatar(radius: 30,),
          title: Text("Hello,",style: TextStyle(fontSize: 16,color: Colors.grey),),
          subtitle: Text('Sumit',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
        ),
        actions: [
          SearchIcon()
        ],

      ),
      body: BlocBuilder<PlayListBloc, PlayListState>(
        builder: (context, state) {
          if (state is PlayListLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(state is PlayListSuccess){
            playList = state.PlayList;
            return _buildScreen(context);
          }
          return _buildScreen(context);
        },
      ),
    );

  }

  _buildScreen(BuildContext context){
    return RefreshIndicator(
      onRefresh: () async {
        _loadNotes();
        await Future.delayed(Duration(seconds: 2));
      },
      child: playList.isEmpty
          ? Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please add Event',
              style: TextStyle(color: Colors.black,fontSize: 24),
            ),
            SizedBox(height: 20,),
            Center(child: CustomButton(onPressed: eventCreate, label: "Create Event"))
          ],
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(12.0),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Events',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 380,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: playList.length,
                itemBuilder: (BuildContext context, int index) {
                  final task = playList[index][PlayListTable.title] ?? 'No title';
                  final content = playList[index][PlayListTable.content] ?? 'No content';
                  final id = playList[index][PlayListTable.id] as int? ?? -1;
                  final imagePath = playList[index][PlayListTable.imagePath] ?? "no image";
                  final date = playList[index][PlayListTable.date] ?? "no image";
                  final startTime = playList[index][PlayListTable.startTime] ?? "startTime";
                  final endTime = playList[index][PlayListTable.endTime] ?? "endTime";
                  return Card(
                    elevation: 2,
                    margin: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Handle onTap
                          },
                          child: Image.asset(
                            imagePath,
                            height: 200,
                            width: 200,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(height: 8,),
                        Text(task,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                        Container(
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
                        Row(
                          children: [
                            Icon(Icons.location_on,color: Colors.grey,),
                            Text("36 Guild Street London,UK",style: TextStyle(color: Colors.grey),),

                          ],
                        ),
                        CustomButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> EventDetails(noteId: id,)));
                        } , label: "View more")

                      ],
                    ),
                  );
                },
              ),
            ),
            Center(child: CustomButton(onPressed: eventCreate, label: "Create Event"))
          ],
        ),
      ),
    );
  }

    viewMore( int id){
   // Navigator.push(context, MaterialPageRoute(builder: (context)=> EventDetails(noteId: id,)));
  }
  void eventCreate() {
      // Navigate to add note screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              AddNoteScreen(index: "${playList.length + 1}",),
        ),
      ).then((newNote) {
        if (newNote != null) {
          setState(() {
            playList.add(newNote);
          });
        }
      });

  }
}
