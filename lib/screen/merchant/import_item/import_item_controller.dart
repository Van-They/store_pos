import 'package:get/get.dart';
import 'package:store_pos/core/data/model/item_model.dart';

class ImportItemController extends GetxController {
  RxList<ItemModel> itemList = <ItemModel>[].obs;
  RxBool isLoading = false.obs;


  Future<void> onCreateItem() async{

  }

}
