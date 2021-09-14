import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test_demo/model/item.dart';
import 'package:http/http.dart' as http;

class List extends StatefulWidget {
  const List({Key? key}) : super(key: key);

  @override
  _ListState createState() => _ListState();
}

class _ListState extends State<List> {

  Future<Item> fetchItems() async {
    final response = await http.get(Uri.parse('https://storage.googleapis.com/hashiona-public/interviews/contentItems'));
    if (response.statusCode == 200) {
      return Item.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }
  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Test'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: fetchItems(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              print(snapshot);
              return ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.all(16),
                itemCount: snapshot.data!.length,
                separatorBuilder: (BuildContext context, int index) => SizedBox(height: 20),
                itemBuilder: (context, index) => ListTile(
                  title: Text('${snapshot.data[index].name}'),
                ),
              );
            }
            else if (snapshot.hasError) Text('${snapshot.error}');
            return const CircularProgressIndicator();
          },
        )
      ),
    );
  }
}
