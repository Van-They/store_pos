import 'package:get/get.dart';
import 'package:store_pos/core/data/model/item_model.dart';
import 'package:store_pos/core/data/model/order_head_model.dart';
import 'package:store_pos/core/data/model/order_tran_model.dart';
import 'package:store_pos/core/repository/cart_repo.dart';

class CartController extends GetxController
    with StateMixin<List<OrderTranModel>> {
  Rx<OrderHead?> orderHead = Rx<OrderHead?>(null);

  final cartRepo = Get.find<CartRepo>();

  @override
  void onInit() {
    onGetOrderHead();
    onGetItemCart();
    super.onInit();
  }

  void onGetOrderHead() async {
    final result = await cartRepo.onGetOrderHead();
    result.fold((l) {}, (r) {
      orderHead.value = r.record;
    });
  }

  void onGetItemCart() async {
    try {
      change(state, status: RxStatus.loading());
      final result = await cartRepo.onGetItemCart();
      result.fold((l) => throw Exception(), (r) {
        change(r.record, status: RxStatus.success());
      });
    } on Exception {
      change([], status: RxStatus.empty());
    }
  }

  void toggleCart(ItemModel itemModel) async {
    final result = await cartRepo.toggleCart(arg: itemModel);
    result.fold((l) {
      change([], status: RxStatus.empty());
    }, (r) {
      final data = state ?? [];
      final currentItem = data.indexWhere(
        (element) => element.code == itemModel.code,
      );
      if (currentItem != -1) {
        data.removeWhere((element) => element.code == itemModel.code);
      } else {
        data.add(r.record);
      }
      change(data, status: RxStatus.success());
    });
  }
}
