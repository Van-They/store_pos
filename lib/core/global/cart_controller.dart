import 'package:get/get.dart';
import 'package:store_pos/core/data/model/item_model.dart';
import 'package:store_pos/core/data/model/order_tran_model.dart';
import 'package:store_pos/core/repository/cart_repo.dart';

class CartController extends GetxController
    with StateMixin<List<OrderTranModel>> {
  final cartRepo = Get.find<CartRepo>();

  // @override
  // void onInit() {
  //   onGetItemCart();

  //   super.onInit();
  // }

  void onGetItemCart() async {
    try {
      change(state, status: RxStatus.loading());
      final result = await cartRepo.onGetItemCart();
      result.fold((l) => throw Exception(), (r) {
        if (r.record.isEmpty) {
          throw Exception();
        }
        change(r.record, status: RxStatus.success());
      });
    } on Exception {
      change([], status: RxStatus.empty());
    }
  }

  void toggleCart(ItemModel itemModel) async {
    
    await cartRepo.toggleCart(arg: itemModel);
    
    // final data = state ?? [];
    // final currentItem =
    //     data.indexWhere((element) => element.code == itemModel.code);
    // if (currentItem != -1) {
    //   data.removeWhere((element) => element.code == itemModel.code);
    // } else {
    //   data.add(itemModel);
    // }
    // change(data, status: RxStatus.success());
  }
}
