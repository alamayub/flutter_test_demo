import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'detail.dart';
import 'package:cached_network_image/cached_network_image.dart';

class List extends StatefulWidget {
  const List({Key? key}) : super(key: key);

  @override
  _ListState createState() => _ListState();
}

class _ListState extends State<List> {

  fetchItems() async {
    final response = await http.get(Uri.parse('https://storage.googleapis.com/hashiona-public/interviews/contentItems'));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return result;
    } else {
      throw Exception('Failed to load items.');
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
      body: FutureBuilder(
        future: fetchItems(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            return ListView.separated(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              padding: const EdgeInsets.all(16),
              itemCount: data.length,
              separatorBuilder: (context, index) => SizedBox(height: 20),
              itemBuilder: (context, index) => ListTile(
                horizontalTitleGap: 16,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Detail(item: data[index]) ));
                },
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                tileColor: Colors.grey.shade200,
                leading: CircleAvatar(
                  child: CachedNetworkImage(
                    imageUrl: data[index]['imageUrl'],
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        CircularProgressIndicator(value: downloadProgress.progress),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                title: Text('${data[index]['name'] ?? data[index]['titile']}'),
                subtitle: Text('${data[index]['type']}'),
              ),
            );
          }
          else if (snapshot.hasError) Text('${snapshot.error}');
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
