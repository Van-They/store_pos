import 'package:get/get.dart';

class Translate extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': _english,
        'km_KH': _khmer,
      };

  final Map<String, String> _english = {
    'hello': 'Hello',

    //-----------------
    'yes': 'Yes',
    'no': 'No',
    'info': 'Info',
    'deleted': 'Deleted',

    //-----------------
    'disable': 'Disable',
    'active': 'Active',

    //-----------------
    'add_to_cart': 'Add To Cart',
    'group_code': 'Group code',
    'item_code': 'Item code',
    'description': 'Description EN',
    'description_2': 'Description KH',
    'cropper': 'Cropper',
    'search_group': 'Search group',
    'add_group': 'Add group',
    'group_already_exist': 'Group already exist',
    'do_you_want_to_delete': 'Do you want to delete',

    //-----------------
    'not_selected': 'Not selected',

    //-----------------
    'button': 'Button',
    'create': 'Create',
    'delete': 'Delete',
    'add_new': 'Add new',
    'select': 'Select',
    'failed': 'Failed',
    'save': 'Save',

    //-----------------
    'khmer': 'Khmer',
    'english': 'English',

    //-----------------
    'subtotal': 'Subtotal',
    'discount': 'Discount',
    'amount_to_pay': 'Amount to pay',
    'check_out': 'Check out',
    'pay_now': 'Pay now',
    'qty': "Qty",
    'quantity': "Quantity",
    'payment_type': "Payment type",
    'to_customer': "To customer",
    'product_list': "Product list",
    'code': "Code",
    'please_input_group_code': "Please input group code",
    'please_input_group_description': "Please input group description",
    'please_input_code': "Please input code",
    'please_input_qty': "Please input qty",
    'please_input_cost': "Please input cost",
    'please_input_price': "Please input price",
    'please_input_description': "Please input description",
    'please_select_group_code': "Please select group code",

    //-----------------
    'type_your_description_here': 'Type your description here',
    'type_your': 'Type your',
    'here': 'here',
    'display_language': 'Display language',

    //-----------------
    'item': 'Item',
    'cart': 'Cart',

    //-----------------
    'item_set_up': 'Item set up',

    //-----------------
    'list_group': 'List group',
    'list_item': 'List item',
    'group_item': 'Group item',
    'group_setup': 'Group setup',
    'item_setup': 'Item setup',
    'item_qty': 'Item qty',
    'item_cost': 'Item cost',
    'no_records': 'No records',
    'cost': 'Cost',
    'unit_price': 'Unit price',
    'category': 'Category',

    //-----------------
    'wishlist': 'WishList',
    'language': 'Language',
    'dashboard': 'Dashboard',
    'menu': 'Menu',
  };

  final Map<String, String> _khmer = {};
}
