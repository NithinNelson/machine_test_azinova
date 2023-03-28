import 'package:flutter/material.dart';
import 'package:machine_test_azinova/services/common_widget.dart';

class Details extends StatefulWidget {
  final itemName;
  final itemImage;
  final itemDetails;
  const Details(
      {Key? key,
      required this.itemName,
      required this.itemImage,
      required this.itemDetails})
      : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Center(
                  child: Card(
                    elevation: 5,
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SizedBox(
                      width: 200,
                      height: 300,
                      child: Image.network(widget.itemImage,
                          fit: BoxFit.cover, loadingBuilder: imageLoading),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      width: 300,
                      child: Text(
                        widget.itemName,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.brown,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    children: [
                      const TextSpan(text: '                      '),
                      TextSpan(text: widget.itemDetails),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
