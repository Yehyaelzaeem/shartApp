class AppApis{
  static const String baseUrl='https://shart.dev01.matrix-clouds.com/api/';
//User
  //Auth
  static const String loginUser='${baseUrl}user/login';
  static const String registerUser='${baseUrl}user/register';
  static const String verifyAccountUser='${baseUrl}user/verify_account';
  static const String sendOTPUser='${baseUrl}user/send-otp';
  //Profile
  static const String getProfileUser='${baseUrl}user/profile';
  static const String updateProfileUser='${baseUrl}user/update-profile';
  static const String deleteAccount='${baseUrl}user/delete-account';
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
  static const String getMyOrder='${baseUrl}user/get-my-orders';
  static  String getSingleOrder(int id)=>'${baseUrl}user/get-my-orders/$id';
  //CheckCar
  static const String sendCheckCars='${baseUrl}user/check-car';
  static const String getCheckCars='${baseUrl}user/get-checks';






//Provider
  //Auth
  static const String loginProvider='${baseUrl}provider/login';
  static const String  registerProvider='${baseUrl}provider/register';
  static const String verifyAccountProvider='${baseUrl}provider/verify_account';
  static const String sendOTPProvider='${baseUrl}provider/send-otp';
  //profile
  static const String getProviderProfileUser='${baseUrl}provider/profile';
  static const String updateProviderProfileUser='${baseUrl}provider/update-profile';
  static const String deleteAccountProvider='${baseUrl}provider/delete-account';
  static const String getAddressProvider='${baseUrl}provider/addresses';
  static const String addAddressProvider='${baseUrl}provider/addresses/add';
  static  String editAddressProvider (int id)=>'${baseUrl}provider/addresses/edit/$id';
  static  String deleteAddressProvider (int id)=>'${baseUrl}provider/addresses/delete/$id';
  //Complete Profile
  static const String completeProfile='${baseUrl}provider/complete-profile';

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
 //Get Packages
  static const String getPackages='${baseUrl}provider/subscriptions';
  static const String subscribePackages='${baseUrl}provider/update-subscription';
  static const String historyPackages='${baseUrl}provider/get-subscription-history';

// Shared
  static const String getSize='${baseUrl}sizes';
  static const String getHeight='${baseUrl}heights';
  static const String getWidth='${baseUrl}widths';


  //Get Provider orders
  static  String getMyOrdersProvider(int limit , String status)=>'${baseUrl}provider/get-my-orders?limit=$limit&status=$status';


}