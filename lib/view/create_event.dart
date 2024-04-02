import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../provider/playlist/playlist_bloc.dart';
import '../utils/colors.dart';
import '../utils/imagePath.dart';
import '../utils/widgets/button.dart';
import '../utils/widgets/custom_TextFeild.dart';
import '../utils/widgets/search_equal.dart';

class AddNoteScreen extends StatefulWidget {
  String index;
    AddNoteScreen({Key? key,required this.index}) : super(key: key);

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _formKey = GlobalKey<FormState>(); // Add a GlobalKey for the Form

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  int selectedIndex = -1;
  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
  final List<String> iconPaths = [
      ImagePath.icon1,
      ImagePath.icon2,
      ImagePath.icon3,
      ImagePath.icon4,

  ];
  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime ? selectedStartTime : selectedEndTime,
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          selectedStartTime = picked;
        } else {
          selectedEndTime = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: CustomColors.black87),
        backgroundColor: CustomColors.white,
        title: Text(
          "Add Event",
          style: TextStyle(color: CustomColors.black87),
        ),
        actions: [
          SearchIcon()
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey, // Assign the GlobalKey to the Form
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  child: Text(
                    'Event no. ${widget.index}', // Convert widget.index to string
                    style: TextStyle(color: CustomColors.black87, fontSize: 18),
                  ),
                ),
                SizedBox(height: 12.0),
                CustomTextField(
                  label: 'Task name',
                  onChanged: (val) => {},
                  controller: _titleController,
                  keyboardType: TextInputType.text, validatorLable: 'task name',

                ),
                SizedBox(height: 12.0),
                Text("Photo"),
                SizedBox(height: 08.0),
            Row(
              children: [
                for (int index = 0; index < iconPaths.length; index++)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(iconPaths[index]),
                            radius: 25,
                            backgroundColor: selectedIndex == index
                                ? Colors.blue // Highlight selected image
                                : Colors.transparent,
                          ),
                          if (selectedIndex == index)
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: Image.asset(
                                'assets/images/tick.png',
                                width: 30,
                                height: 30,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                SizedBox(width: 10), // Adjust spacing between icons
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  radius: 25,
                ),
              ],
            ),
                SizedBox(height: 12.0),
                Text("Date"),
                SizedBox(height: 08.0),
            GestureDetector(
              onTap: () {
                _selectDate(context);
              },
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child:    Center(
                  child: Text(
                    DateFormat('MMMM dd, yyyy').format(selectedDate),
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
            ),


                SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text("Start Time"),
                    GestureDetector(
                      onTap: () {
                        _selectTime(context, true);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${selectedStartTime.hour}:${selectedStartTime.minute.toString().padLeft(2, '0')}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text("End Time"),
                    GestureDetector(
                      onTap: () {
                        _selectTime(context, false);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${selectedEndTime.hour}:${selectedEndTime.minute.toString().padLeft(2, '0')}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
                SizedBox(height: 12.0),
                Text("About event"),
                SizedBox(height: 08.0),
                CustomTextField(
                  label: 'Description',
                  onChanged: (val) => {},
                  controller: _contentController,
                  keyboardType: TextInputType.text, validatorLable: 'Description',maxline: 2,

                ),
                SizedBox(height: 12.0),
                CustomButton(onPressed: saveDataToTable, label: "CREATE EVENT")
              ],
            ),
          ),
        ),
      ),
    );
  }

  void saveDataToTable() {
    bool  validation = _formKey.currentState!.validate();
    if (selectedIndex == -1) {
      // If user hasn't selected an image, show a message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select an image.'),
        ),
      );
      return; // Exit the function without saving data
    }

    if (validation) {
      String id = widget.index;
      String title = _titleController.text;
      String content = _contentController.text;
      String imagePath = selectedIndex != -1 ? iconPaths[selectedIndex] : ''; // Adjusted to handle selectedIndex
      String date = DateFormat('MMMM dd, yyyy').format(selectedDate); // Formatted date
      String startTime = '${selectedStartTime.hour}:${selectedStartTime.minute.toString().padLeft(2, '0')}';
      String endTime = '${selectedEndTime.hour}:${selectedEndTime.minute.toString().padLeft(2, '0')}';


      BlocProvider.of<PlayListBloc>(context).add(
        PlayListsuccessEvent(id: id, title: title, content: content, imagePath: imagePath, date: date, startTime: startTime, endTime: endTime),
      );
      BlocProvider.of<PlayListBloc>(context).add(
        NotegetEvent(),
      );
      Navigator.pop(context);
    }
  }
}


