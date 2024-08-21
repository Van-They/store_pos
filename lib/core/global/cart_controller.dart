import 'package:get/get.dart';
import 'package:store_pos/core/data/model/customer_model.dart';
import 'package:store_pos/core/data/model/item_model.dart';
import 'package:store_pos/core/data/model/order_head_model.dart';
import 'package:store_pos/core/data/model/order_tran_model.dart';
import 'package:store_pos/core/data/model/payment_method_model.dart';
import 'package:store_pos/core/repository/cart_repo.dart';
import 'package:store_pos/core/repository/item_repo.dart';

class CartController extends GetxController {
  RxBool isLoading = false.obs;
  var orderHead = Rx<OrderHead?>(null);
  var customers = <CustomerModel>[].obs;
  var paymentMethods = <PaymentMethodModel>[].obs;
  var orderTranList = <OrderTranModel>[].obs;
  var customerName = 'not_selected'.tr.obs;
  var paymentName = 'not_selected'.tr.obs;

  final cartRepo = Get.find<CartRepo>();
  final itemRepo = Get.find<ItemRepo>();

  @override
  void onInit() {
    onGetOrderHead();
    onGetItemCart();
    super.onInit();
  }

  void onGetWishList() async {
    //Todo get wishlist item
  }

  void onGetOrderHead() async {
    final result = await cartRepo.onGetOrderHead();
    result.fold((l) {}, (r) {
      orderHead.value = r.record;
    });
  }

  void onGetItemCart() async {
    try {
      isLoading.value = true;
      final result = await cartRepo.onGetItemCart();
      result.fold((l) => throw Exception(), (r) {
        orderTranList.value = r.record;
        isLoading.value = false;
      });
    } on Exception {
      isLoading.value = false;
    }
  }

  void toggleCart(ItemModel itemModel) async {
    final result = await cartRepo.toggleCart(arg: itemModel);
    result.fold((l) => throw Exception(), (r) {
      final currentItem = orderTranList.indexWhere(
        (element) => element.code == itemModel.code,
      );
      if (currentItem != -1) {
        orderTranList.removeWhere((element) => element.code == itemModel.code);
      } else {
        orderTranList.add(r.record);
      }
    });
  }

  void onUpdateCart({required String code, required double qty}) async {
    final result = await cartRepo.onUpdateCart(code: code, qty: qty);
    result.fold((l) => {}, (r) {
      final currentIndex =
          orderTranList.indexWhere((element) => element.code == code);
      if (currentIndex != -1) {
        orderTranList[currentIndex] = r.record;
      }
      orderHead.refresh();
    });
  }

  void onGetCustomer() async {
    final result = await cartRepo.onGetCustomer();
    result.fold((l) {}, (r) {
      customers.value = r.record;
    });
  }

  void onGetPaymentMethod() async {
    final result = await cartRepo.onGetPaymentMethod();
    result.fold((l) {}, (r) {
      paymentMethods.value = r.record;
    });
  }

  Future<bool> onCheckOutCart() async {
    try {
      final result = await cartRepo.onCheckOutCart();
      result.fold((l) => throw Exception(), (r) {});
      return true;
    } on Exception {
      return false;
    }
  }

  void onClearCartState() {
    customerName.value = 'not_selected'.tr;
    paymentName.value = 'not_selected'.tr;
    orderHead.value = null;
    orderTranList.clear();
  }

  void onResetCode() {
    customerName.value = 'not_selected'.tr;
    paymentName.value = 'not_selected'.tr;
  }
}
