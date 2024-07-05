import 'package:get/get.dart';

class Translate extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': _english,
        'km_KH': _khmer,
      };

  final Map<String, String> _english = {
    //-----------------
    'active': 'Active',
    'add_to_cart': 'Add To Cart',
    'add_group': 'Add group',
    'add_item': 'Add item',
    'add_new': 'Add new',
    'amount_to_pay': 'Amount to pay',

    //-----------------
    'button': 'Button',

    //-----------------
    'cropper': 'Cropper',
    'create': 'Create',
    'code': "Code",
    'cost': 'Cost',
    'category': 'Category',
    'customer': 'Customer',


    'end_of_records': 'End of records',
    'empty': 'Empty',




    'report': 'Report',
    'payment': 'Payment',
    'preference': 'Preference',
    'currency': 'Currency',
    'expanse': 'Expanse',
    'setting': 'Setting',
    'company': 'Company',
    'income': 'Income',
    'stock': 'Stock',
    'exit': 'Exit',
    'search_item_here': 'Search item here',

    'hello': 'Hello',

    //-----------------
    'yes': 'Yes',
    'no': 'No',
    'info': 'Info',
    'deleted': 'Deleted',

    //-----------------
    'disable': 'Disable',

    //-----------------

    'group_code': 'Group code',
    'item_code': 'Item code',
    'description': 'Description EN',
    'description_2': 'Description KH',

    'search_group': 'Search group',
    'search_item': 'Search item',

    'group_already_exist': 'Group already exist',
    'do_you_want_to_delete': 'Do you want to delete',
    'can_not_delete_group_is_not_empty': 'Can not delete group is not empty',

    //-----------------
    'not_selected': 'Not selected',

    //-----------------

    'delete': 'Delete',

    'select': 'Select',
    'failed': 'Failed',
    'save': 'Save',

    //-----------------
    'khmer': 'Khmer',
    'english': 'English',

    //-----------------
    'subtotal': 'Subtotal',
    'discount': 'Discount',

    'check_out': 'Check out',
    'pay_now': 'Pay now',
    'qty': "Qty",
    'quantity': "Quantity",
    'payment_type': "Payment type",
    'to_customer': "To customer",
    'product_list': "Product list",

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
    'good_morning': 'Good morning',
    'good_afternoon': 'Good afternoon',
    'good_evening': 'Good evening',

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

    'unit_price': 'Unit price',

    //-----------------
    'wishlist': 'WishList',
    'language': 'Language',
    'dashboard': 'Dashboard',
    'menu': 'Menu',
  };

  final Map<String, String> _khmer = {};
}
