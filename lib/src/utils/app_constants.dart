import '../model/item/sort_model.dart';

class AppConstants {
  static const String defaultAvatar =
      'https://firebasestorage.googleapis.com/v0/b/esmp-4b85e.appspot.com/o/images%2F16-1c8843e5-4dd0-4fb7-b061-3a9fcbd68c0d?alt=media&token=0c8838a5-d3c4-4c31-82ed-d9b91d8c11d9-3a9fcbd68c0d%3Falt%3Dmedia%26token%3D0c8838a5-d3c4-4c31-82ed-d9b91d8c11d9%26fbclid%3DIwAR0v68PcVs-E38YszRIZPyNy4PaYRZU59b21d-iyQ8NTyBrvXYp3YBqKclQ&h=AT0F7Fm4W02bljIiOCCdNFraaSuuADp6xPHlwhoYbjufje1E8RgzWN2FGd6VMBRyqTf3FUfZTqL06dMVX9L_KUFIKX3uDnn11IbTYz6Sy3S1K3bJYBxQeouYAqKg8loyuiQ4dg';
  static const List<String> listWeightUnit = ['grams', 'kg'];
  static const List<String> listLwhtUnit = [
    'cm',
    'm',
  ];
  static const List<String> listOrderSearch = [
    'Tên',
    'Mã đơn hàng',
  ];
  static final List<String> genders = ['Khác', 'Nam', 'Nữ'];
  static final List<String> banks = [
    'VietcomBank',
    'BIDV',
    'VBSP',
    'Vietinbank',
    'Agribank',
    'MHB',
    'VDB',
    'Techcombank',
    'OCB',
    'HD Bank',
    'MB Bank',
    'ACB',
    'Sacombank'
  ];
  static List<SortModel> listSortModel = [
    SortModel(name: 'Giá tăng dần', query: 'price_asc'),
    SortModel(name: 'Giá giảm dần', query: 'price_desc'),
    SortModel(name: 'Khuyến mãi', query: 'discount'),
  ];
}
