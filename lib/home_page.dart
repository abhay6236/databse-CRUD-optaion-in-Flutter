import 'package:database_crud/add_user.dart';
import 'package:database_crud/my_databse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.pinkAccent,
      title: Text("CRUD DEMO",style: TextStyle(fontWeight: FontWeight.bold)),
      actions: [
      InkWell(
        onTap: () async {
          await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return AddUser(null);
          },)).then((value) {
            if(value == true){
              setState(() {

              });
            }
          },);
        },
        child: Container(
          margin: EdgeInsets.only(right: 10),
          child: Icon(Icons.add),
        ),
      )
      ],
    ),
      body: Container(
        child: FutureBuilder(
          builder: (context, snapshot) {
          if(snapshot.hasData){
            return FutureBuilder(future: MyDatabase().grtDetail(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                  return ListView.builder(

                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Container(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                                                child: Text(snapshot.data![index]["userName"].toString(),
                                  style: TextStyle(fontSize: 20),
                                                                ),
                                  ),
                                ),
                                Container(
                                  child: Text(snapshot.data![index]["userGender"].toString(),
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Container(
                                  child: TextButton(
                                    onPressed: () async {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                    return AddUser(snapshot.data![index]);
                                  },)).then((value) {
                                    setState(() {

                                    });
                                  });
                                    },
                                    child: Icon(Icons.edit),
                                  ),
                                ),
                                Container(

                                  child: TextButton(
                                    onPressed: () async{
                                        showCupertinoDialog(context: context, builder: (context) {
                                          return AlertDialog(
                                            title:Text( "Alert!"),
                                            content: Text(
                                              "Are you Sure Delete?"
                                            ),
                                            actions: [
                                              TextButton(onPressed: () async {
                                                await MyDatabase()
                                                    .deleteUser(
                                                    snapshot.data![index]["userId"])
                                                    .then((value) {
                                                  setState(() {});
                                                });
                                                Navigator.pop(context);
                                              }, child: Text("Yes")),
                                              TextButton(onPressed: () {
                                                Navigator.pop(context);
                                              }, child: Text("No")),
                                            ],

                                          );
                                        },);
                                    },
                                    child:  Icon(Icons.delete,color: Colors.red),
                                  )
                                )
                              ],
                            ),
                          ),
                        );
                      },);
                  }else{
                    return Center(child: CircularProgressIndicator(),);
                  }
                },

            );
          }else{
return Center(
  child: Container(child: Text("Loading.....")),
);
          }
          },
          future: MyDatabase().copyPasteAssetFileToRoot(),
        ),
      ),
    );
  }}
