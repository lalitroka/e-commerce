 import 'package:flutter/material.dart';

 Drawer drawerMethod() {
    return Drawer(
      width: 200,
       child: ListView(
      children: const [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue
          ),
          child:Text('profile',
          style: TextStyle(
            fontSize: 15,
            color: Colors.greenAccent
          ),) ),

          ListTile(
          leading:  Icon(Icons.ac_unit_sharp),
          title:   Text('Name'),
          ),
           ListTile(
          leading: Icon(Icons.ac_unit_sharp),
          title: Text('Name'),
          ),
           ListTile(
          leading: Icon(Icons.ac_unit_sharp),
          title: Text('Name'),
          ),
           ListTile(
          leading: Icon(Icons.ac_unit_sharp),
          title: Text('Name'), 
          ),
           ListTile(
          leading: Icon(Icons.ac_unit_sharp),
          title: Text('Name'),
          ),
           ListTile(
          leading: Icon(Icons.ac_unit_sharp),
          title: Text('Name'),
          ),
          

      ],
       ),

    );
  }