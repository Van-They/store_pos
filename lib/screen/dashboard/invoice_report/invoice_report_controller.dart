import 'package:get/get.dart';
import 'package:store_pos/core/data/model/order_head_model.dart';
import 'package:store_pos/core/data/model/order_tran_model.dart';
import 'package:store_pos/core/repository/order_head_repo.dart';

class InvoiceReportController extends GetxController {
  RxList<OrderHead> invoiceList = <OrderHead>[].obs;
  RxBool isLoading = false.obs;
  final OrderHeadRepo _repo = Get.find<OrderHeadRepo>();

  RxList<OrderTranModel> orderTranList = <OrderTranModel>[].obs;

  Future<void> onGetInvoiceList() async {
    isLoading.value = false;
    try {
      final result = await _repo.onGetListInvoice();
      result.foldRight(null, (r, previous) {
        invoiceList.value = r.record;
      });
    } catch (e) {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onGetInvoiceDetail(String invoice) async {
      isLoading.value = false;
    try {
      final result = await _repo.onGetInvoiceDetail(invoice:invoice);
      result.foldRight(null, (r, previous) {
        orderTranList.value = r.record;
      });
    } catch (e) {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }
}
