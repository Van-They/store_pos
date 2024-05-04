import 'package:get/get.dart';
import 'package:store_pos/core/data/model/item_model.dart';
import 'package:store_pos/core/exception/exceptions.dart';
import 'package:store_pos/core/repository/item_repo.dart';

class HomeController extends GetxController with StateMixin<List<ItemModel>> {

  final ItemRepo repo = Get.find();

  Future<void> onGetHomeItems({Map? arg}) async {
    try{
      change([],status: RxStatus.loading());
      await repo.onGetHomeItems(arg:arg).then((value) {
        value.fold((l) => throw GeneralException(), (r) {
          final record = r.record;
          if(record.isEmpty){
            change([],status: RxStatus.empty());
          }else{
            change(record,status: RxStatus.success());
          }

        });
      });
    }on GeneralException{
      change([],status: RxStatus.error());
      rethrow;
    }
  }
}