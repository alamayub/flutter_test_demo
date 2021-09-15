import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  final dynamic item;
  const Detail({Key? key, this.item}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.item['name'] ?? widget.item['titile']}'),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          CachedNetworkImage(
            height: 200,
            imageUrl: widget.item['imageUrl'],
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Text('${widget.item['name'] ?? widget.item['titile']}', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, letterSpacing: 1)),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Text('Type ${widget.item['type']}'),
          )
        ],
      ),
    );
  }
}
