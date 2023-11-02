import 'dart:convert';

import 'package:bye/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class myhome extends StatefulWidget {
  const myhome({super.key});

  @override
  State<myhome> createState() => _myhomeState();
}

class _myhomeState extends State<myhome> {
  Future<List<modelclass>>getpost() async {

    List <modelclass> allposts = [];
    var url = Uri.https("jsonplaceholder.typicode.com", "/posts");

    // Await the http get response", then decode the json-formatted response.
    var response = await http.get(url);
    var jsonResponse = jsonDecode(response.body);

for(var i in jsonResponse){
allposts.add(modelclass.fromJson(i));
}

    return allposts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder <List<modelclass>>(
            future: getpost(),
            builder:
                (BuildContext context, AsyncSnapshot<List<modelclass>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(itemCount: snapshot.data!.length,
                  itemBuilder: (context,index) {
                    return ListTile(
                      tileColor: Colors.teal,
                      title:
                          Text(snapshot.data?[index].title??"data"),
                        
                      
                      subtitle: Text("${snapshot.data![index].id!}"),
                        leading: Text(snapshot.data![index].userId!.toString()),   
                        trailing: Text(snapshot.data![index].body!),
                                       );
                  }
                );
              }

              return CircularProgressIndicator();
            }));
  }
}
