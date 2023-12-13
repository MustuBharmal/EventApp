import 'dart:io';

import 'package:event_app/models/event.dart';
import 'package:event_app/provider/event_provider.dart';
import 'package:event_app/provider/user_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../widgets/person_image_picker.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({Key? key}) : super(key: key);

  static const routeName = '/add_event_screen';

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  File? _selectedImage;
  final _form = GlobalKey<FormState>();
  final _eventName = TextEditingController();
  final _dsc = TextEditingController();
  final _rStDate = TextEditingController();
  final _rEdDate = TextEditingController();
  final _nDays = TextEditingController();
  final _eDate = TextEditingController();
  final _location = TextEditingController();
  final _link = TextEditingController();
  final _time = TextEditingController();
  var _editedEvent = EventModel(
    id: '',
    name: '',
    img: '',
    dsc: '',
    rStDate: '',
    rEdDate: '',
    nDays: '',
    eDate: '',
    organisers: '',
    location: '',
    link: '',
    time: '',
  );
  var _isLoading = false;
  var _isInit = true;

  @override
  void dispose() {
    super.dispose();
    _eventName.dispose();
    _rStDate.dispose();
    _rEdDate.dispose();
    _time.dispose();
    _dsc.dispose();
    _eDate.dispose();
    _nDays.dispose();
    _location.dispose();
    _link.dispose();
  }
  @override
  void didChangeDependencies() {
    if (_isInit) {
      final personId = ModalRoute.of(context)!.settings.arguments as String;
      if (personId != 'Add Event') {
        _editedEvent = Provider.of<EventProvider>(context).findById(personId);
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid || _selectedImage == null) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    // final _sendLink = '""\"${_link.text}\"""''';
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('images')
        .child('${_eventName.text}.jpg');
    await storageRef.putFile(_selectedImage!);
    _editedEvent.img = await storageRef.getDownloadURL();
    _editedEvent = EventModel(
      id: _editedEvent.id,
      name: _eventName.text,
      dsc: _dsc.text,
      rStDate: _rStDate.text,
      rEdDate: _rEdDate.text,
      nDays: _nDays.text,
      eDate: _eDate.text,
      organisers:
          Provider.of<UserProvider>(context, listen: false).userModel!.dept!,
      location: _location.text,
      img: _editedEvent.img,
      link: _link.text,
      time: _time.text,
    );
    await Provider.of<EventProvider>(context, listen: false)
        .addEventData(_editedEvent);
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text('Add Event'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: _form,
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 30,
                  ),
                  children: <Widget>[
                    PersonImagePicker(
                      onPickImage: (pickedImage) {
                        _selectedImage = pickedImage;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    nameTextField(),
                    const SizedBox(
                      height: 20,
                    ),
                    reStDt(),
                    const SizedBox(
                      height: 20,
                    ),
                    reEdDt(),
                    const SizedBox(
                      height: 20,
                    ),
                    regEdTime(),
                    const SizedBox(
                      height: 20,
                    ),
                    numOfDaysEveTextField(),
                    const SizedBox(
                      height: 20,
                    ),
                    dayOfEvent(),
                    const SizedBox(
                      height: 20,
                    ),
                    dscEventTextField(),
                    const SizedBox(
                      height: 20,
                    ),
                    locationTextField(),
                    const SizedBox(
                      height: 20,
                    ),
                    linkTextField(),
                    const SizedBox(
                      height: 20,
                    ),
                    submitButton(),
                  ],
                ),
              ),
            ),
    );
  }

  Widget nameTextField() {
    return TextFormField(
      controller: _eventName,
      validator: (value) {
        if (value!.isEmpty) return "Event name can't be empty";
        return null;
      },
      autofocus: true,
      decoration: InputDecoration(
        border: borderDecorate(),
        focusedBorder: focusedBorderDecorate(),
        prefixIcon: Icon(
          Icons.person,
          color: Theme.of(context).colorScheme.primary,
        ),
        labelText: "Event Name",
        hintText: "Hackathon",
      ),
    );
  }

  Widget reStDt() {
    return TextFormField(
      readOnly: true,
      controller: _rStDate,
      validator: (value) {
        if (value!.isEmpty) return "Registration start date can't be empty";
        return null;
      },
      decoration: InputDecoration(
        border: borderDecorate(),
        focusedBorder: focusedBorderDecorate(),
        prefixIcon: Icon(
          Icons.date_range,
          color: Theme.of(context).colorScheme.primary,
        ),
        labelText: 'Registration Start Date',
        hintText: 'Pick your Date',
      ),
      onTap: () async {
        var date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2100));
        if (date != null) {
          _rStDate.text = DateFormat('dd/MM/yyyy').format(date);
        }
      },
    );
  }

  Widget reEdDt() {
    return TextFormField(
      readOnly: true,
      controller: _rEdDate,
      validator: (value) {
        if (value!.isEmpty) return "Registration end date can't be empty";
        return null;
      },
      decoration: InputDecoration(
        border: borderDecorate(),
        focusedBorder: focusedBorderDecorate(),
        prefixIcon: Icon(
          Icons.date_range,
          color: Theme.of(context).colorScheme.primary,
        ),
        labelText: 'Registration End Date',
        hintText: 'Pick your Date',
      ),
      onTap: () async {
        var date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2100));
        if (date != null) {
          _rEdDate.text = DateFormat('dd/MM/yyyy').format(date);
        }
      },
    );
  }

  Widget dayOfEvent() {
    return TextFormField(
      readOnly: true,
      controller: _eDate,
      validator: (value) {
        if (value!.isEmpty) return "Event date can't be empty";
        return null;
      },
      decoration: InputDecoration(
        border: borderDecorate(),
        focusedBorder: focusedBorderDecorate(),
        prefixIcon: Icon(
          Icons.date_range,
          color: Theme.of(context).colorScheme.primary,
        ),
        labelText: 'Event Date',
        hintText: 'Pick your Date',
      ),
      onTap: () async {
        var date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2100));
        if (date != null) {
          _eDate.text = DateFormat('dd/MM/yyyy').format(date);
        }
      },
    );
  }

  Widget regEdTime() {
    return TextFormField(
      controller: _time,
      validator: (value) {
        if (value!.isEmpty) return "Time field can't be empty";
        return null;
      },
      decoration: InputDecoration(
        border: borderDecorate(),
        focusedBorder: focusedBorderDecorate(),
        prefixIcon: Icon(
          Icons.settings_system_daydream,
          color: Theme.of(context).colorScheme.primary,
        ),
        labelText: "Registration End time",
        hintText: "7 pm",
      ),
    );
  }

  Widget numOfDaysEveTextField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: _nDays,
      validator: (value) {
        if (value!.isEmpty) return "Name can't be empty";
        return null;
      },
      decoration: InputDecoration(
        border: borderDecorate(),
        focusedBorder: focusedBorderDecorate(),
        prefixIcon: Icon(
          Icons.settings_system_daydream,
          color: Theme.of(context).colorScheme.primary,
        ),
        labelText: "No. of Days",
        hintText: "Dev Stack",
      ),
    );
  }

  Widget dscEventTextField() {
    return TextFormField(
      controller: _dsc,
      validator: (value) {
        if (value!.isEmpty) return "Description can't be empty";
        return null;
      },
      decoration: InputDecoration(
        border: borderDecorate(),
        focusedBorder: focusedBorderDecorate(),
        prefixIcon: Icon(
          Icons.message_outlined,
          color: Theme.of(context).colorScheme.primary,
        ),
        labelText: "Event Description",
        hintText: "About Hackathon",
      ),
    );
  }

  Widget locationTextField() {
    return TextFormField(
      controller: _location,
      validator: (value) {
        if (value!.isEmpty) return "Location can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: borderDecorate(),
        focusedBorder: focusedBorderDecorate(),
        prefixIcon: Icon(
          Icons.location_on_outlined,
          color: Theme.of(context).colorScheme.primary,
        ),
        labelText: "Location of the Event",
        hintText: "Central Auditorium",
      ),
    );
  }

  Widget linkTextField() {
    return TextFormField(
      controller: _link,
      validator: (value) {
        if (value!.isEmpty) return "Link can't be empty";
        return null;
      },
      decoration: InputDecoration(
        border: borderDecorate(),
        focusedBorder: focusedBorderDecorate(),
        prefixIcon: Icon(
          Icons.link,
          color: Theme.of(context).colorScheme.primary,
        ),
        labelText: "Add Link",
        hintText: "add the link for registration",
      ),
    );
  }

  Widget submitButton() {
    return ElevatedButton(
      onPressed: _saveForm,
      child: const Text('SAVE'),
    );
  }

  OutlineInputBorder borderDecorate() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.background,
      ),
    );
  }

  OutlineInputBorder focusedBorderDecorate() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.background,
        width: 2,
      ),
    );
  }
}
