import 'package:store_pos/core/data/data_source/api_response.dart';
import 'package:store_pos/core/data/model/item_model.dart';

abstract class Api {
  Future<ApiResponse> onGetHomeItems({Map? arg});

  Future<ApiResponse> onCreateGroupItem({required Map<String, dynamic> arg});

  Future<ApiResponse> onGetGroupItem();

  Future<ApiResponse> onCreateItem({required Map<String, dynamic> arg});

  Future<ApiResponse> onGetItem();

  Future<ApiResponse> toggleCart({required ItemModel arg});

  Future<ApiResponse> onGetItemCart();

  Future<ApiResponse> onGetOrderHead();

  Future<ApiResponse> onUpdateCart({required String code, required double qty});

  Future<ApiResponse> onGetCustomer();

  Future<ApiResponse> onGetPaymentMethod();

  Future<ApiResponse> onCheckOutCart();

  Future<ApiResponse> onDeleteGroup({Map? arg});

  Future<ApiResponse> onToggleDisableGroup({required Map<String, Object?> arg});

  Future<ApiResponse> onUpdateGroup({required Map<String, Object?> arg});

  Future<ApiResponse> onGetGroupItemHome();

  Future<ApiResponse> onDeleteItem(String code);

  Future<ApiResponse> toggleWishlist(String code);

  Future<ApiResponse> onUpdateItem({required Map<String, dynamic> arg});

  Future<ApiResponse> onGetHomeSldier();
  Future<ApiResponse> onInsertHomeSlder({Map? arg});
  Future<ApiResponse> onDeleteHomeSlider({Map? arg});

  Future<ApiResponse> onGetItemByCategory({Map? arg});

  Future<ApiResponse> onGetWishList({Map? arg});
  
  Future<ApiResponse> onToggleWishList({Map? arg});
}
