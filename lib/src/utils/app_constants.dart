import 'package:gsp23se37_supplier/src/model/withdrawal/withdrawal_status.dart';

import '../model/item/sort_model.dart';

class AppConstants {
  static const String defaultAvatar =
      'https://firebasestorage.googleapis.com/v0/b/esmp-4b85e.appspot.com/o/images%2F2-5d887447-257a-4b45-8fbd-11e299762b65?alt=media&token=acc782a0-8136-4eaa-8276-1969870e7937&fbclid=IwAR2pmwGz2USS8bg7g27EeSsTQBsOJ_pBQL97lpA4J6hn4b5re209iZSqyt0';

  static const List<String> listWeightUnit = ['grams', 'kg'];
  static const List<String> listLwhtUnit = [
    'mm',
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
  static List<WithdrawalStatus> listWithdrawalStatus = [
    WithdrawalStatus(item_StatusID: -1, statusName: "Trạng thái"),
    WithdrawalStatus(item_StatusID: 1, statusName: "Chờ tiếp nhận"),
    WithdrawalStatus(item_StatusID: 2, statusName: "Đang xử lí"),
    WithdrawalStatus(item_StatusID: 3, statusName: "Huỷ"),
    WithdrawalStatus(item_StatusID: 4, statusName: "Hoàn thành"),
  ];
}
