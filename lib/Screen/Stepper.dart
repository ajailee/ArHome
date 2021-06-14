import 'package:aj_ar/Model/ArchiModel.dart';
import 'package:aj_ar/Model/BookModel.dart';
import 'package:aj_ar/Provider/Auth.dart';
import 'package:aj_ar/Provider/BookProvier.dart';
import 'package:aj_ar/Widget/TableText.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class StepperDemo extends StatefulWidget {
  static String routeName = '/stepper';
  @override
  _StepperDemoState createState() => _StepperDemoState();
}

class _StepperDemoState extends State<StepperDemo> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  double _height;
  double _width;
  String _chosenValue = 'Audio Call';

  String _setTime, _setDate;

  String _hour, _minute, _time;

  String dateTime;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  ArchiModel model;
  User user;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 50)));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = picked.format(context);
      });
  }

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _dateController.text =
        DateFormat('dd-MM-yyyy').format(DateTime.now().add(Duration(days: 1)));

    _timeController.text = DateFormat('hh:mm a')
        .format(DateTime.now().add(new Duration(hours: 1)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<AuthProvider>(context).user;
    model = ModalRoute.of(context).settings.arguments;
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('My Home'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Stepper(
                type: stepperType,
                physics: ScrollPhysics(),
                currentStep: _currentStep,
                onStepTapped: (step) => tapped(step),
                onStepContinue: continued,
                onStepCancel: cancel,
                steps: <Step>[
                  Step(
                    title: new Text('Booking For'),
                    content: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: model == null
                              ? Icon(Icons.search)
                              : Image.network(model.coverImage),
                        ),
                        model == null
                            ? TableText('Custome Model')
                            : TableText('Model Id: ${model.id}'),
                        model == null
                            ? TableText('')
                            : TableText('Builder Name: ${model.builderName}'),
                        model == null
                            ? TableText('')
                            : TableText(
                                'Square Feet: ${model.length * model.breath} sq.ft.')
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 0
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: new Text('Pick Your Time'),
                    content: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                'Choose Date',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5),
                              ),
                              InkWell(
                                onTap: () {
                                  _selectDate(context);
                                },
                                child: Container(
                                  width: _width / 1.7,
                                  height: _height / 9,
                                  margin: EdgeInsets.only(top: 30),
                                  alignment: Alignment.center,
                                  decoration:
                                      BoxDecoration(color: Colors.grey[200]),
                                  child: TextFormField(
                                    style: TextStyle(fontSize: 40),
                                    textAlign: TextAlign.center,
                                    enabled: false,
                                    keyboardType: TextInputType.text,
                                    controller: _dateController,
                                    onSaved: (String val) {
                                      _setDate = val;
                                    },
                                    decoration: InputDecoration(
                                        disabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide.none),
                                        // labelText: 'Time',
                                        contentPadding:
                                            EdgeInsets.only(top: 0.0)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                'Choose Time',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5),
                              ),
                              InkWell(
                                onTap: () {
                                  _selectTime(context);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 30),
                                  width: _width / 1.7,
                                  height: _height / 9,
                                  alignment: Alignment.center,
                                  decoration:
                                      BoxDecoration(color: Colors.grey[200]),
                                  child: TextFormField(
                                    style: TextStyle(fontSize: 40),
                                    textAlign: TextAlign.center,
                                    onSaved: (String val) {
                                      _setTime = val;
                                    },
                                    enabled: false,
                                    keyboardType: TextInputType.text,
                                    controller: _timeController,
                                    decoration: InputDecoration(
                                        disabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide.none),
                                        // labelText: 'Time',
                                        contentPadding: EdgeInsets.all(5)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    subtitle: Text('how can we reach you?'),
                    title: new Text('Pick Your Mode'),
                    content: DropdownButton<String>(
                      focusColor: Colors.white,
                      value: _chosenValue,
                      //elevation: 5,
                      style: TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.black,
                      items: <String>[
                        'Audio Call',
                        'Video Call',
                        'Email',
                        'Agent To Your Door Step',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      hint: Text(
                        "Please choose a langauage",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      onChanged: (String value) {
                        setState(() {
                          _chosenValue = value;
                        });
                      },
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 2
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    if (_currentStep == 2) {
      final bookmodel = BookModel(
        builderId: model == null ? 'Custome' : model.builderId,
        builderName: model == null ? 'Custome' : model.builderName,
        date: _dateController.text,
        time: _timeController.text,
        modelId: model == null ? 'Custome' : model.id,
        requestedMode: _chosenValue,
        userEmail: user.email,
        userId: user.uid,
        userName: user.displayName,
      );
      BookProvider.bookModel(bookmodel);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("My Home"),
            content: Text("Your Request Has Been Submitted Successfully"),
            actions: [
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    if (_currentStep == 0) {
      Navigator.pop(context);
    }
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
