import 'package:database_crud/my_databse.dart';
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {  @override
  State<AddUser> createState() => _AddUserState();
  Map<String,Object?>? map;

  AddUser(map){
    this.map=map;
  }
}

class _AddUserState extends State<AddUser> {
var nameController=TextEditingController();
var genderController=TextEditingController();


void initState(){
  nameController.text=
widget.map == null ? '' : widget.map!["userName"].toString();

  genderController.text=
      widget.map == null ? '' : widget.map!["userGender"].toString();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Card(
child: Column(
  children: [
    Container(
      child: TextFormField(
        controller: nameController,
        decoration: InputDecoration(
          icon: Icon(Icons.account_box),
          hintText: "Enter a name"
        ),
      ),
    ),
    Container(
      child: TextFormField(
        controller: genderController,
        decoration: InputDecoration(
            icon: Icon(Icons.transgender),
            hintText: "Enter a Gender"
        ),
      ),
    ),
    Container(
      child: ElevatedButton(
        onPressed: () {
          if(widget.map==null){
            insertUser().then((value)=>Navigator.of(context).pop(true));
          }
          else{
            editUser(widget.map!["userId"].toString()).
          then((value)=>Navigator.of(context).pop(true));
          }
        },
        child: Text("Submit",
        style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    )
  ],
),
    ),
    );

  }

Future<int> insertUser() async{
 Map<String,Object?> map=Map<String,Object?>();
 map["userName"] = nameController.text;
 map["userGender"]=genderController.text;

var res=MyDatabase().insertUser(map);
return res;
}

Future<int> editUser(id) async{
  Map<String,Object?> map=Map<String,Object?>();
  map["userName"] = nameController.text;
  map["userGender"]=genderController.text;

  var res=MyDatabase().editUser(map, id);
  return res;
}

}
