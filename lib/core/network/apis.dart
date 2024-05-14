class AppApis{
  // static const String baseUrl='https://shart.dev01.matrix-clouds.com/api/';
  static const String baseUrl='https://dev02.matrix-clouds.com/shart/public/api/';
//User
  //Auth
  static const String loginUser='${baseUrl}user/login';
  static const String registerUser='${baseUrl}user/register';
  static const String verifyAccountUser='${baseUrl}user/verify_account';
  static const String sendOTPUser='${baseUrl}user/send-otp';
  static const String sendFCMToken='${baseUrl}user/update-fcm-token';
  static const String forgetPassword='${baseUrl}user/forget_password';
  static const String resetPassword='${baseUrl}user/reset_password';
  //Profile
  static const String getProfileUser='${baseUrl}user/profile';
  static const String updateProfileUser='${baseUrl}user/update-profile';
  static const String deleteAccount='${baseUrl}user/delete-account';
  static const String changePasswordUser='${baseUrl}user/change-password';
  //?per_page/$page
  static  String getUserNotification(int limit)=>'${baseUrl}user/my-notifications?per_page=$limit';
  // static  String getSingleOrder(int id)=>'${baseUrl}user/get-order/$id';

  //Address
  static const String getAddressUser='${baseUrl}user/addresses';
  static const String addAddressUser='${baseUrl}user/addresses/add';
  static  String editAddressUser (int id)=>'${baseUrl}user/addresses/edit/$id';
  static  String deleteAddressUser (int id)=>'${baseUrl}user/addresses/delete/$id';
  //Company
  static const String termsAndConditionUser='${baseUrl}pages/terms_and_conditions';
  static const String privacyAndPolicyUser='${baseUrl}pages/privacy_policy';
  //Spare_parts
  static const String getProductUser='${baseUrl}user/get-products';
  //Favorite
  static const String getFavoriteUser='${baseUrl}user/fav-products';
  static const String addFavoriteUser='${baseUrl}user/add-remove-product-to-favorite';
  //Cart
  static const String sendOrder='${baseUrl}user/make-order';
  static  String getMyOrder(int limit)=>'${baseUrl}user/get-my-orders?limit=$limit';
  static  String getSingleOrder(int id)=>'${baseUrl}user/get-order/$id';
  //CheckCar
  static const String sendCheckCars='${baseUrl}user/check-car';
  static const String getCheckCars='${baseUrl}user/get-checks';
 // Merchants
  static const String getMerchants='${baseUrl}user/providers-search';
  static  String getWorksMerchant(int id)=>'${baseUrl}user/get-provider-works/$id';
  static  String getProductsMerchant(int id)=>'${baseUrl}user/get-products-by-provider-id/$id';
  static  String getAddressMerchant(int id)=>'${baseUrl}user/get-provider-addresses/$id';
  static const String addFavoriteMerchants='${baseUrl}user/add-remove-fav-provider';
  static const String getFavoriteMerchants='${baseUrl}user/get-fav-providers';
  static  String cancelOrderUser(int id)=>'${baseUrl}user/order/cancel/${id}';


//Payment
  static const String payment='${baseUrl}user/pay-order';




//Provider
  //Auth
  static const String loginProvider='${baseUrl}provider/login';
  static const String  registerProvider='${baseUrl}provider/register';
  static const String verifyAccountProvider='${baseUrl}provider/verify_account';
  static const String sendOTPProvider='${baseUrl}provider/send-otp';
  static const String sendFCMTokenProvider='${baseUrl}provider/update-fcm-token';
  static const String forgetPasswordProvider='${baseUrl}provider/forget_password';
  static const String resetPasswordProvider='${baseUrl}provider/reset_password';
  //profile
  static const String getProviderProfileUser='${baseUrl}provider/profile';
  static const String updateProviderProfileUser='${baseUrl}provider/update-profile';
  static const String deleteAccountProvider='${baseUrl}provider/delete-account';
  static const String getAddressProvider='${baseUrl}provider/addresses';
  static const String addAddressProvider='${baseUrl}provider/addresses/add';
  static const String changePasswordProvider='${baseUrl}provider/change-password';
  //?per_page=$page
  static  String getProviderNotification(int limit)=>'${baseUrl}provider/my-notifications?per_page=$limit';

  static  String editAddressProvider (int id)=>'${baseUrl}provider/addresses/edit/$id';
  static  String deleteAddressProvider (int id)=>'${baseUrl}provider/addresses/delete/$id';
  //Complete Profile
  static const String completeProfile='${baseUrl}provider/complete-profile';
  //Wallet
  static const String getWallet='${baseUrl}provider/get-my-wallets';

  //Pages
  static const String termsAndConditionProvider='${baseUrl}provider/pages/terms_and_conditions_provider_app';
  static const String privacyAndPolicyProvider='${baseUrl}provider/pages/privacy_policy_provider_app';
  static const String aboutCompany='${baseUrl}pages/about';
  //Products
  static const String getProducts='${baseUrl}provider/products';
  static  String getSearchProducts(String title)=>'${baseUrl}provider/products?title=$title';
  static const String addProduct='${baseUrl}provider/products/add';
  static  String editProduct(int id)=>'${baseUrl}provider/products/edit/$id';
  static  String deleteProduct(int id)=>'${baseUrl}provider/products/delete/$id';
  static  String getSingleOrderProvider(int id)=>'${baseUrl}provider/get-order/$id';

  // Works
  static const String getAllWorks='${baseUrl}provider/works';
  static const String addWorks='${baseUrl}provider/works/add';
  static  String editWorks(int id)=>'${baseUrl}provider/works/edit/$id';
  static  String deleteWorks(int id)=>'${baseUrl}provider/works/delete/$id';

//Package Check
  static const String checkCars='${baseUrl}packages';
  static  String brandsAll='${baseUrl}brands';
  static  String brands(String type)=>'${baseUrl}brands/$type';
  static String brandModel(int id)=> '${baseUrl}modals/$id';
  static String banners(String type)=> '${baseUrl}banners/$type';
  static const String brandColors='${baseUrl}colors';

//Send Contact us message
  static const String complaintMessage='${baseUrl}send-contact-message';
  //Payment
  static const String getPaymentVisibility='${baseUrl}get-payment-visibility';
 //Get Packages
  static const String getPackages='${baseUrl}provider/subscriptions';
  static const String subscribePackages='${baseUrl}provider/update-subscription';
  static const String historyPackages='${baseUrl}provider/get-subscription-history';

// Shared
  static const String getSize='${baseUrl}sizes';
  static const String getHeight='${baseUrl}heights';
  static const String getWidth='${baseUrl}widths';


  //Get Provider orders
  static  String getMyOrdersProvider(int limit , String status)=>'${baseUrl}provider/get-my-orders?limit=$limit&&status=$status';
  static  String acceptOrder(int id)=>'${baseUrl}provider/order/accept/${id}';
  static  String rejectOrder(int id)=>'${baseUrl}provider/order/reject/${id}';
  static  String cancelOrder(int id)=>'${baseUrl}provider/order/cancel/${id}';
  static  String deliveredOrder(int id)=>'${baseUrl}provider/order/delivered/${id}';
  static  String preparingOrder(int id)=>'${baseUrl}provider/order/preparing/${id}';


}