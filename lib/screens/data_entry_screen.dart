import 'dart:ffi';
import 'dart:io';

import 'package:countdownontaskbar/logicfunctions/directory_operations.dart';
import 'package:countdownontaskbar/logicfunctions/folders_fetcher.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'appbar_for_mainscreen.dart';
import 'package:intl/intl.dart';

class DataEntryScreen extends StatefulWidget {
  const DataEntryScreen({Key? key}) : super(key: key);

  @override
  State<DataEntryScreen> createState() => _DataEntryScreenState();
}
String _defalultColor="4279314758";
class _DataEntryScreenState extends State<DataEntryScreen> {


  TextEditingController countDownName_textField = TextEditingController();
  TextEditingController countDownInfo_textField = TextEditingController();
  TextEditingController countDownTargetDate_textField = TextEditingController();
  TextEditingController countDownIconPath_textField = TextEditingController(text: defaultImageIcoPath);
  TextEditingController countDownTileColor_textField = TextEditingController(text: _defalultColor);



  final FocusNode cdIcon_Focus = FocusNode();
  final FocusNode cdName_focus = FocusNode();
  final FocusNode cdInfo_focus = FocusNode();
  final FocusNode cdTDate_focus = FocusNode();
  final FocusNode cdTileColor_focus =FocusNode();


  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);



  @override
  dispose() {
    super.dispose();
    countDownName_textField.dispose();
    countDownInfo_textField.dispose();
    countDownTargetDate_textField.dispose();
    countDownIconPath_textField.dispose();
    countDownTileColor_textField.dispose();

    cdName_focus.dispose();
    cdInfo_focus.dispose();
    cdIcon_Focus.dispose();
    cdTDate_focus.dispose();
    cdTileColor_focus.dispose();
  }



  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
   _targetDatePicker()async{
     DateTime? pickedDate = await showDatePicker(
         context: context,
         initialDate: DateTime.now(),
         firstDate: DateTime(1950),
         //DateTime.now() - not to allow to choose before today.
         lastDate: DateTime(2100));

     if (pickedDate != null) {
       print(
           pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
       String formattedDate =
       DateFormat('yyyy-MM-dd').format(pickedDate);
       print(
           formattedDate); //formatted date output using intl package =>  2021-03-16
       setState(() {
         countDownTargetDate_textField.text =
             formattedDate; //set output date to TextField value.
       });
     } else {}
   }
  var iconWarningText = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarForMainScreen("Countdown Creator"),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            TextFormField(
              autofocus: true,
              controller: countDownName_textField,
              focusNode: cdName_focus,
              onFieldSubmitted: (d) {
                _fieldFocusChange(context, cdName_focus, cdInfo_focus);
              },
              maxLength: 20,
              textInputAction: TextInputAction.next,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z_/s]")),
              ],
              // On
              onChanged: (value) {
                setState(() {});
              },
              //editing controller of this TextField
              decoration: InputDecoration(
                  suffixIcon: countDownName_textField.text.isEmpty
                      ? null
                      : IconButton(
                          splashRadius: 20,
                          splashColor: Colors.red,
                          onPressed: () {
                            countDownName_textField.clear();
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.clear,
                            color: Colors.grey,
                          )),
                  icon: Icon(Icons.title), //icon of text field
                  helperText: "Only _ (underscore) allowed!",
                  helperStyle: TextStyle(fontSize: 12 ),
                  labelText: "Enter Countdown Title" //label text of field
                  ),
            ),
            TextFormField(
              focusNode: cdInfo_focus,
              textInputAction: TextInputAction.done,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z_ .() -,]")),
              ],
              // Only numbers can be entered
              onChanged: (value) {
                setState(() {});
              },
              onFieldSubmitted: (d) {
                _fieldFocusChange(context, cdInfo_focus,cdTDate_focus );
                _targetDatePicker();
              },

              controller: countDownInfo_textField,
              //editing controller of this TextField
              decoration: InputDecoration(
                  suffixIcon: countDownInfo_textField.text.isEmpty
                      ? null
                      : IconButton(
                          splashRadius: 20,
                          splashColor: Colors.red,
                          onPressed: () {
                            countDownInfo_textField.clear();
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.clear,
                            color: Colors.grey,
                          )),
                  icon: Icon(Icons.info_outline), //icon of text field
                  labelText: "Enter about your Countdown",
                  hintText: "Optional"),
            ),
            TextField(
              focusNode: cdTDate_focus,
                textInputAction: TextInputAction.done,
                controller: countDownTargetDate_textField,
                //editing controller of this TextField

                decoration: InputDecoration(
                    suffixIcon: countDownTargetDate_textField.text.isEmpty
                        ? null
                        : IconButton(
                            splashRadius: 20,
                            splashColor: Colors.red,
                            onPressed: () {
                              countDownTargetDate_textField.clear();
                            },
                            icon: Icon(
                              Icons.clear,
                              color: Colors.grey,
                            )),
                    icon: Icon(Icons.calendar_today), //icon of text field
                    labelText: "Enter Date" //label text of field
                    ),
                readOnly: true,
                keyboardType: TextInputType.datetime,
                onTap: () async {
                await  _targetDatePicker();
                }),
            TextField(
              controller: countDownIconPath_textField,
              //editing controller of this TextField
              readOnly: true,
              focusNode: cdIcon_Focus,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                  errorText: iconWarningText,
                  suffixIcon: countDownIconPath_textField.text.isEmpty
                      ? null
                      : IconButton(
                          splashRadius: 20,
                          splashColor: Colors.red,
                          onPressed: () {
                            setState(() {
                              countDownIconPath_textField.text=defaultImageIcoPath;
                            });
                          },
                          icon: Icon(
                            Icons.clear,
                            color: Colors.grey,
                          )),
                  icon: countDownIconPath_textField.text.isNotEmpty
                      ? SizedBox(
                          height: 30,
                          width: 30,
                          child: Image.file(
                              File(countDownIconPath_textField.text)))
                      : Icon(Icons.photo), //icon of text field
                  labelText: "Countdown Icon (Optional)" //label text of field
                  ),
              onTap: () async {

                FilePickerResult? result = await FilePicker.platform.pickFiles(
                    allowedExtensions: ['ico'], type: FileType.custom);

                if (result != null) {
                  if (result.paths.last.toString().contains(" ")) {
                    countDownIconPath_textField.clear();
                    setState(() {
                      iconWarningText = "⚠ Your Icon File Path Contains Space!";
                      // countDownIconPath_textField.text="error";
                    });
                  } else {
                    setState(() {
                      iconWarningText = null;
                      countDownIconPath_textField.text =
                          result.paths.last.toString();
                    });

                    _fieldFocusChange(context, cdIcon_Focus, cdName_focus);
                  }
                } else {
                  // User canceled the picker
                }
              },
            ),
            TextField(
              controller: countDownTileColor_textField,
              //editing controller of this TextField
              readOnly: true,
              decoration: InputDecoration(
                  errorText: iconWarningText,
                  suffixIcon: countDownTileColor_textField.text.isEmpty
                      ? null
                      : IconButton(
                          splashRadius: 20,
                          splashColor: Colors.red,
                          onPressed: () {
                            setState(() {
                              countDownTileColor_textField.text=_defalultColor;
                            });
                          },
                          icon: Icon(
                            Icons.clear,
                            color: Colors.grey,
                          )),
                  icon: Icon(Icons.circle,color: Color(int.parse(countDownTileColor_textField.text)),), //icon of text field
                  labelText: "Countdown Tile Color (Optional)" //label text of field
                  ),
              onTap: () async {



                return showDialog(
                  context: context,
                  builder:(BuildContext context) { return AlertDialog(
                    title: const Text('Pick a color!'),
                    content: Container(
                      height: 300,

                      child: BlockPicker(
                        pickerColor: currentColor,
                        onColorChanged: (Color color) {
                          setState((){ countDownTileColor_textField.text = color.value.toString();});
                        },
                      ),

                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        child: const Text('Got it'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                   );}
                );


              },
            ),
            SizedBox(
              height: 30,
            ),
            TextButton(
                onPressed: () {
                  if (countDownTargetDate_textField.text.isNotEmpty &&
                      countDownName_textField.text.isNotEmpty) {
                    DirectoryOperator.createCountDown(
                        cdName: countDownName_textField.text,
                        iconAddress: countDownIconPath_textField.text,
                        cdInfo: countDownInfo_textField.text,
                        targetDate: countDownTargetDate_textField.text,
                      tileColor: countDownTileColor_textField.text,
                    );
                    Navigator.pop(context);
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor:(countDownTargetDate_textField.text.isNotEmpty &&
                      countDownName_textField.text.isNotEmpty)? Colors.green:Colors.grey,
                ),
                child: Text(
                  "Create",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
