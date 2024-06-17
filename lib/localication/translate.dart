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
    'disable': 'Disable',
    'active': 'Active',


    //-----------------
    'add_to_cart': 'Add To Cart',
    'group_code': 'Group code',
    'item_code': 'Item code',
    'description': 'Description EN',
    'description_2': 'Description KH',

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

    //-----------------
    'type_your_description_here': 'Type your description here',
    'type_your': 'Type your',
    'here': 'here',

    //-----------------
    'item': 'Item',

    //-----------------
    'item_set_up': 'Item set up',

    //-----------------
    'list_group': 'List group',
    'list_item': 'List item',
    'group_item': 'Group item',
    'group_setup': 'Group setup',
    'category': 'Category',
  };

  final Map<String, String> _khmer = {};
}
