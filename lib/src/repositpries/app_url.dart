class AppUrl {
  static const String baseUrl =
      'https://esmpfree-001-site1.etempurl.com/api'; //hosting

  static const String checkExistUser = '$baseUrl/user/check_user';

  static const String supplierRegister = '$baseUrl/user/supplier_register';

  static const String getBank = '$baseUrl/Asset/bank';

  static const String login = '$baseUrl/user/suppliersign_in';

  static const String refeshtoken = '$baseUrl/user/refeshtoken';

  static const String province = '$baseUrl/Address/provine';

  static const String district = '$baseUrl/Address/district';

  static const String ward = '$baseUrl/Address/ward';

  static const String registerStore = '$baseUrl/Store/register';

  static const String storeUpdate = '$baseUrl/Store/store_edit';

  static const String storeCashFlow = '$baseUrl/Asset/get_store_reveneu';

  static const String updateSupplierImage = '$baseUrl/user/edit_image';

  static const String loginStore = '$baseUrl/Store/login_store';

  static const String getPriceActice = '$baseUrl/Store/get_price_actice';

  static const String storePayment = '$baseUrl/Payment/momo_store_pay';

  static const String storeWithdrawal = '$baseUrl/Asset/store_withdrawal';

  static const String getCategory = '$baseUrl/Category';

  static const String getSpecification = '$baseUrl/Specification/sub_category';

  static const String getBrand = '$baseUrl/Brand';

  static const String addItem = '$baseUrl/Item';

  // static const String getItem = '$baseUrl/Item/store';

  static const String getItems = '$baseUrl/Item/search_admin';

  static const String getItemDetail = '$baseUrl/Item/item_detail';

  static const String hiddenItem = '$baseUrl/Item/hidden_item';
  static const String unHiddenItem = '$baseUrl/Item/unhidden_item';

  static const String getOrders = '$baseUrl/Order/get_order_status';

  static const String getTicket = '$baseUrl/Ship/get_ticket';

  static const String getOrderShipStatus = '$baseUrl/Ship/ship_status';

  static const String getOrderInfo = '$baseUrl/Order/order_info';

  static const String getFeedbacksItem = '$baseUrl/Item/item_feedback';

  static const String cancelOrder = '$baseUrl/Payment/cancel_order';

  static const String updateUserName = '$baseUrl/user/edit_name';
  static const String updateUserEmail = '$baseUrl/user/edit_email';
  static const String updateUserGender = '$baseUrl/user/edit_gender';
  static const String updateUserDOB = '$baseUrl/user/edit_birth';
  static const String updateUserAddress = '$baseUrl/user/edt_address';

  static const String addPakingLink = '$baseUrl/Order/add_paking_link';

  static const String updateSubItem = '$baseUrl/Item/update_subitem';
  static const String storeReveneu = '$baseUrl/Asset/store_chart_reveneu';
  static const String getService = '$baseUrl/AfterBuyService';
  static const String updateStoreAddress = '$baseUrl/Store/update_address';
  static const String getWithdrawal = '$baseUrl/Asset/get_store_withdrawal';
}
