import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:machine_test_azinova/screens/details_page.dart';
import 'package:machine_test_azinova/services/api.dart';
import 'package:machine_test_azinova/services/common_widget.dart';
import 'package:machine_test_azinova/sqfLite/item.dart';
import 'package:machine_test_azinova/sqfLite/item_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Items> itemData = [];
  bool loader = false;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async {
    setState(() {
      loader = true;
    });
    await getRapi(context).then((value) {
      setState(() {
        loader = false;
      });
    });
    itemData = await ItemDatabase.instance.readAllStudentData();
    if (itemData.isEmpty) {
      setState(() {
        loader = true;
      });
    } else {
      setState(() {
        loader = false;
      });
    }
  }

  Future<void> refresh() async {
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: loader
          ? Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(color: Colors.white),
              child: const Center(
                child: SpinKitFadingCircle(
                  color: Colors.yellow,
                ),
              ),
            )
          : Container(
              width: double.infinity,
              height: double.infinity,
              child: RefreshIndicator(
                onRefresh: refresh,
                child: ListView.builder(
                    itemCount: itemList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return Details(
                                  itemName: itemList[index]['itemName'],
                                  itemImage: itemList[index]['itemImage'],
                                  itemDetails: itemList[index]['itemDetails']);
                            }));
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            child: Card(
                              color: Colors.grey[200],
                              elevation: 5,
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              margin: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Card(
                                      elevation: 0,
                                      semanticContainer: true,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      margin: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: SizedBox(
                                        width: 100,
                                        child: Image.network(
                                            itemList[index]['itemImage'],
                                            fit: BoxFit.cover,
                                            loadingBuilder: imageLoading),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      width: 200.w,
                                      child: Text(
                                        itemList[index]['itemName'],
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: Colors.brown,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
    );
  }
}
