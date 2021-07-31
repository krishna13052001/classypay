import 'package:flutter/material.dart';

import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactList extends StatefulWidget {
  ContactList({Key? key}) : super(key: key);

  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  List<Contact> _contactList = [];
  bool _status = false;

  Future<void> _getContactPermission() async {
    var status = await Permission.contacts.request();
    if (status.isGranted)
      setState(() {
        _status = true;
      });
  }

  Future<List<Contact>> _getContacts() async {
    await _getContactPermission();
    if (_status) {
      _contactList = (await ContactsService.getContacts()).toList();
      return _contactList;
    } else
      return _contactList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getContacts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting && !_status)
          return Center(child: CircularProgressIndicator());
        else
          return _contactList.length == 0
              ? Center(
                  child: _status
                      ? Text('No contacts to show.')
                      : Text(
                          'Please provide access to your contacts to show here.'))
              : ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: _contactList.length,
                  itemBuilder: (context, index) => ListTile(
                        key: ValueKey(index),
                        leading: CircleAvatar(
                            backgroundColor: Colors.black,
                            child: Text(_contactList[index].initials())),
                        title: Text(_contactList[index].displayName ?? '#'),
                        subtitle: Text(_contactList[index]
                                .phones
                                ?.toList()[0]
                                .value
                                .toString() ??
                            ""),
                        trailing: IconButton(
                            onPressed: () {}, icon: Icon(Icons.send_outlined)),
                      ));
      },
    );
  }
}
