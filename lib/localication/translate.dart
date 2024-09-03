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
    'add_on': 'Add On',
    'add_image': 'Add Image',
    'amount_to_pay': 'Amount to pay',
    'adjust_stock': 'Adjust stock',

    //-----------------
    'button': 'Button',
    'browse_by_category': 'Browse by Categories',

    //-----------------
    'cropper': 'Cropper',
    'create': 'Create',
    'code': "Code",
    'cost': 'Cost',
    'category': 'Category',
    'customer': 'Customer',
    'count_stock': 'Count stock',
    'check_stock': 'Check stock',
    'cash_register': 'Cash register',
    'create_payment': 'Create payment',
    'create_customer': 'Create customer',

    //-----------------
    'download_data': 'Download Data',
    'data_set_up': 'Data Setup',
    'daily_item_sale': 'Daily item sale',

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
    'invoice_register': 'Invoice register',
    'stock': 'Stock',
    'exit': 'Exit',
    'search_item_here': 'Search item here',
    'home_slide_set_up': 'Home slide setup',

    'hello': 'Hello',
    'home': 'Home',
    'poscash': 'Pos cash',
    'home_slider': 'Home slider',
    'configure': 'Configure',
    'import_item': 'Import item',
    'export_item': 'Export item',
    'daily_report': 'Daily report',

    //-----------------
    'yes': 'Yes',
    'no': 'No',
    'info': 'Info',
    'deleted': 'Deleted',

    //-----------------
    'disable': 'Disable',
    'upload_data': 'Upload Data',
    'pick_file': 'Pick File',
    'upload_image': 'Upload Image',

    //-----------------

    'group_code': 'Group code',
    'item_code': 'Item code',
    'import_data': 'Import data',
    'description': 'Description EN',
    'description_2': 'Description KH',
    'search_group': 'Search group',
    'search_item': 'Search item',

    'group_already_exist': 'Group already exist',
    'do_you_want_to_delete': 'Do you want to delete',
    'can_not_delete_group_is_not_empty': 'Can not delete group is not empty',

    //-----------------
    'not_selected': 'Not selected',
    'not_allow_to_edit': 'Not allow to edit',
    'num_row': 'No',
    'invoice_no': 'Invoice',

    //-----------------

    'delete': 'Delete',
    'update': 'Update',
    'select': 'Select',
    'failed': 'Failed',
    'save': 'Save',

    //-----------------
    'khmer': 'Khmer',
    'english': 'English',

    //-----------------
    'subtotal': 'Subtotal',
    'summary_data': 'Summary Data',
    'item_data': 'Item Data',
    'grand_total': 'Grand total',
    'phone_number': 'Phone number',
    'paid_by': 'Paid by',
    'date': 'Date',
    'discount': 'Discount',

    'check_out': 'Check out',
    'pay_now': 'Pay now',
    'qty': "Qty",
    'quantity': "Quantity",
    'payment_type': "Payment type",
    'to_customer': "To customer",
    'amount': "Amount",
    'update_item': "Update Item",
    'item_already_exist': "Item already exist",
    'can_not_delete_item_transaction':
        "Can't delete item already has transaction",

    'new_qty': "New Qty",

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
    'recent_sale': 'Recent sale',
    'invoice_report': 'Invoice report',
    'cash_report': 'Cash report',
    'item_sale': 'Item sale',
    'payment_method': 'Payment method',

    //-----------------
    'wishlist': 'WishList',
    'language': 'Language',
    'dashboard': 'Dashboard',
    'menu': 'Menu',
    'import_group_item': 'Import group item',
    'not_allow_quantity_smaller_than_one': 'No allow quantity smaller than one',
  };

  final Map<String, String> _khmer = {
    //-----------------
    'khmer': 'ខេមរភាសា',
    'english': 'អង់គ្លេស',
  };
}
