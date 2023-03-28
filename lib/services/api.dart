import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:machine_test_azinova/services/common_widget.dart';
import 'package:machine_test_azinova/sqfLite/item.dart';
import 'package:machine_test_azinova/sqfLite/item_data.dart';

List<Items> itemData = [];
List<Map> itemList = [];

Future<void> getRapi(context) async {
  await refreshData();
  try {
    var response = await http.get(
      Uri.parse(
        "https://demo.azinova.me/machine-test/api/get_items",
      ),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print('-----------data--------------$data');
      if (data['status'] == "success") {
        var itemDetails = data['items'];
        for (int i = 0; i < itemDetails.length; i++) {
          bool dbItem = false;
          for (int j = 0; j < itemList.length; j++) {
            if (itemList[j]['itemName'] != itemDetails[i]['itemName']) {
              dbItem = true;
              break;
            } else {
              dbItem = false;
            }
          }
          if (dbItem == false) {
            final items = Items(
                itemName: itemDetails[i]['itemName'],
                itemImage: itemDetails[i]['itemImage'],
                itemDetails: itemDetails[i]['itemDetails']);
            await ItemDatabase.instance.create(items);
          }
        }
      }
    }
  } on SocketException catch (e) {
    snackBar(context, "Connection Problem");
  } catch (e) {
    snackBar(context, e.toString());
  }
  refreshData();
}

Future<void> refreshData() async {
  itemList.clear();
  itemData = await ItemDatabase.instance.readAllStudentData();
  itemData.forEach((element) {
    itemList.insert(0, {
      "itemName": element.itemName,
      "itemImage": element.itemImage,
      "itemDetails": element.itemDetails,
    });
  });
  print('-------------trbw-----------------$itemList');
}
