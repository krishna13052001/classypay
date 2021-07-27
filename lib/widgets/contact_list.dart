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

  Future<void> _getContacts() async {
    var status = await Permission.contacts.request();
    if (status.isGranted) {
      _contactList = (await ContactsService.getContacts()).toList();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
      future: _getContacts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return CircularProgressIndicator();
        else if (snapshot.hasError)
          return Container(child: Center(child: Text('Something went wrong!')));
        else
          return ListView.builder(
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
    ));
  }
}
