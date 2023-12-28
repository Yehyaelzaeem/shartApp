import 'package:flutter/material.dart';
import 'package:shart/core/routing/routes.dart';
import 'package:shart/features/provider/bottom_nav/presentation/screens/bottom_nav.dart';
import 'package:shart/features/provider/complete_renter_data/presentation/screens/complete_renter_data_screen.dart';
import 'package:shart/features/provider/favorite/presentation/screens/favorite_screen.dart';
import 'package:shart/features/provider/home/presentation/screens/home_screen.dart';
import 'package:shart/features/provider/messages/presentation/screens/messages_screen.dart';
import 'package:shart/features/provider/more/presentation/screens/more_screen.dart';
import 'package:shart/features/provider/myorders/presentation/screens/my_orders_screen.dart';
import 'package:shart/features/provider/packages/presentation/screens/package_details_screen.dart';
import 'package:shart/features/provider/packages/presentation/screens/packages_screen.dart';
import 'package:shart/features/user/auth/ui/screens/verify_account_screen.dart';
import 'package:shart/features/user/invoice/presentation/screens/invoice_screen.dart';
import 'package:shart/features/user/myorders/presentation/screens/order_details.dart';
import 'package:shart/features/user/notifications/presentation/screens/notification_screen.dart';
import 'package:shart/features/user/packages/presentation/screens/package_details_screen.dart';
import 'package:shart/features/user/products/presentation/screens/product_details_screen.dart';
import 'package:shart/features/user/report/presentation/screens/report_screen.dart';
import 'package:shart/features/user/spare_parts/presentation/screens/rims_screen.dart';
import 'package:shart/features/user/spare_parts/presentation/screens/spare_parts_details_screen.dart';
import 'package:shart/features/user/spare_parts/presentation/screens/spare_parts_screen.dart';
import 'package:shart/features/user/spare_parts/presentation/screens/tires_screen.dart';
import 'package:shart/features/user/spare_parts/presentation/screens/tires_types.dart';
import 'package:shart/features/user/store/presentation/screens/store_products.dart';
import 'package:shart/features/user/store/presentation/screens/store_screen.dart';

import '../../features/common/intro/presentation/screens/choose_user_type_screen.dart';
import '../../features/common/intro/presentation/screens/onboarding_screen.dart';
import '../../features/common/splash/presentation/screens/splash_screen.dart';
import '../../features/provider/auth/presentation/screens/login_provider_screen.dart';
import '../../features/provider/auth/presentation/screens/otp_provider_screen.dart';
import '../../features/provider/auth/presentation/screens/register_provider_screen.dart';
import '../../features/provider/profile/presentation/address/screens/provider_add_address.dart';
import '../../features/provider/profile/presentation/address/screens/provider_addresses.dart';
import '../../features/provider/profile/presentation/edit_profile/screen/edit_profile_screen.dart';
import '../../features/provider/profile/presentation/forget_password/screen/forgot_password_screen.dart';
import '../../features/provider/work_and_products/presentation/screens/add_new_product.dart';
import '../../features/provider/work_and_products/presentation/screens/product_details_screen.dart';
import '../../features/provider/work_and_products/presentation/screens/work_and_products_screen.dart';
import '../../features/user/auth/ui/screens/forgot_password_screen.dart';
import '../../features/user/auth/ui/screens/login_screen.dart';
import '../../features/user/auth/ui/screens/register_screen.dart';
import '../../features/user/book_package_service/presentation/screens/book_package_service_screen.dart';
import '../../features/user/bottom_nav/presentation/screens/bottom_nav_screen.dart';
import '../../features/user/favorite/presentation/screens/favorite_screen.dart';
import '../../features/user/filter/presentation/screens/filter_spare_parts_screen.dart';
import '../../features/user/filter/presentation/screens/filter_tires_and_rims_screen.dart';
import '../../features/user/menu/presentation/menu/menu_screen.dart';
import '../../features/user/menu/presentation/packages/packages_screen.dart';
import '../../features/user/menu/presentation/packages_details/package_details_screen.dart';
import '../../features/user/messages/presentation/screens/messages_screen.dart';
import '../../features/user/more/presentation/screens/about_company_screen.dart';
import '../../features/user/more/presentation/screens/complains_screen.dart';
import '../../features/user/more/presentation/screens/conditions_screen.dart';
import '../../features/user/more/presentation/screens/more_screen.dart';
import '../../features/user/myorders/presentation/screens/item_details.dart';
import '../../features/user/myorders/presentation/screens/myorders_screen.dart';
import '../../features/user/packages/presentation/screens/packages_screen.dart';
import '../../features/user/profile/presentation/edit_profile/screens/edit_profile_screen.dart';
import '../../features/user/spare_parts/presentation/screens/car_supplies_screen.dart';
import 'platform_page_route.dart';
import 'undefined_route_screen.dart';

class RouteGenerator {
  static Route generateBaseRoute(RouteSettings settings) {
    return getRout(settings);
  }

  static Route getRout(RouteSettings settings) {
    if (settings.name == Routes.splash) {
      return platformPageRoute(const SplashScreen());
    }
    if (settings.name == Routes.onBoarding) {
      return platformPageRoute(const OnBoardingScreen());
    }
    if (settings.name == Routes.chooseUserScreen) {
      return platformPageRoute(const ChooseUserTypeScreen());
    }
    if (settings.name == Routes.login) {
      return platformPageRoute(const UserLoginScreen());
    }
    if (settings.name == Routes.register) {
      return platformPageRoute(const RegisterScreen());
    }  if (settings.name == Routes.otpScreen) {
      return platformPageRoute(const VerifyAccountScreen());
    }
    if (settings.name == Routes.forgotPassword) {
      return platformPageRoute(const ForgotPasswordScreen());
    }
    if (settings.name == Routes.editProfile) {
      return platformPageRoute(const EditProfileScreen());
    }
    if (settings.name == Routes.home) {
      return platformPageRoute(UserBottomNavScreen());
    }
    if (settings.name == Routes.packagesHistory) {
      return platformPageRoute(const UserPackagesScreen());
    }
    if (settings.name == Routes.filterTiresAndRims) {
      return platformPageRoute(const FilterTireAndRimsScreen());
    }
    if (settings.name == Routes.aboutCompany) {
      return platformPageRoute(const AboutCompanyScreen());
    }
    if (settings.name == Routes.sparePartsFilter) {
      return platformPageRoute(const SparePartsFilterScreen());
    }
    if (settings.name == Routes.productDetails) {
      return platformPageRoute(const ProductDetailsScreen());
    }
    if (settings.name == Routes.storeProducts) {
      return platformPageRoute(const StoreProductsScreen());
    }
    if (settings.name == Routes.store) {
      return platformPageRoute(const StoreScreen());
    }
    if (settings.name == Routes.complains) {
      return platformPageRoute(const ComplainsScreen());
    }
    if (settings.name == Routes.orderDetails) {
      return platformPageRoute(const OrderDetailsScreen());
    }
    if (settings.name == Routes.conditions) {
      return platformPageRoute( ConditionsScreen(text: 'waiting...',));
    }
    if (settings.name == Routes.userFavorite) {
      return platformPageRoute(const UserFavoriteScreen());
    }
    if (settings.name == Routes.itemDetails) {
      return platformPageRoute(ItemDetailsScreen());
    }
    if (settings.name == Routes.menu) {
      return platformPageRoute(const UserMenuScreen());
    }
    if (settings.name == Routes.messages) {
      return platformPageRoute(const UserMessagesScreen());
    }
    if (settings.name == Routes.more) {
      return platformPageRoute(const UserMoreScreen());
    }
    if (settings.name == Routes.checkingPackages) {
      return platformPageRoute(const CarPackagesCheckScreen());
    }
    if (settings.name == Routes.checkingPackagesDetails) {
      return platformPageRoute(const CarCheckPackagesDetailsScreen());
    }
    if (settings.name == Routes.spareParts) {
      return platformPageRoute(const SparePartsScreen());
    }
    if (settings.name == Routes.bookPackageService) {
      return platformPageRoute(const UserBookPackageServiceScreen());
    }
    if (settings.name == Routes.packageDetails) {
      return platformPageRoute(const UserPackageDetailsScreen());
    }
    if (settings.name == Routes.carSupplies) {
      return platformPageRoute(const CarSuppliesScreen());
    }
    if (settings.name == Routes.tires) {
      return platformPageRoute(const TiresScreen());
    }
    if (settings.name == Routes.report) {
      return platformPageRoute(const ReportScreen());
    }
    if (settings.name == Routes.sparePartsDetails) {
      return platformPageRoute(const SparePartsDetailsScreen());
    }
    if (settings.name == Routes.providerCompleteRenterData) {
      return platformPageRoute(const CompleteRenterDataScreen());
    }
    if (settings.name == Routes.providerNavBar) {
      return platformPageRoute(const ProviderBottomNavScreen());
    }
    if (settings.name == Routes.tiresTypes) {
      return platformPageRoute(const TiresTypesScreen());
    }
    if (settings.name == Routes.invoice) {
      return platformPageRoute(const InvoiceScreen());
    }
    if (settings.name == Routes.rims) {
      return platformPageRoute(const RimsScreen());
    }
    if (settings.name == Routes.notifications) {
      return platformPageRoute(const NotificationScreen());
    }
    if (settings.name == Routes.orders) {
      return platformPageRoute(const UserOrdersScreen());
    }

    /// PROVIDER PAGE ROUTES
    if (settings.name == Routes.providerCompleteRenterData) {
      return platformPageRoute(const CompleteRenterDataScreen());
    }
    if (settings.name == Routes.providerFavorite) {
      return platformPageRoute(const ProviderFavoriteScreen());
    }
    if (settings.name == Routes.providerHome) {
      return platformPageRoute(const ProviderHomeScreen());
    }
    if (settings.name == Routes.providerLogin) {
      return platformPageRoute(const ProviderLoginScreen());
    }
    if (settings.name == Routes.providerRegister) {
      return platformPageRoute(const ProviderRegisterScreen());
    }
    if (settings.name == Routes.providerOtpScreen) {
      return platformPageRoute(const OtpProviderScreen());
    }
    if (settings.name == Routes.providerFavorite) {
      return platformPageRoute(const ProviderFavoriteScreen());
    }
    if (settings.name == Routes.providerMessages) {
      return platformPageRoute(const ProviderMessagesScreen());
    }
    if (settings.name == Routes.providerAddNewProduct) {
      return platformPageRoute(const ProviderAddNewProduct());
    }
    if (settings.name == Routes.providerProductDetails) {
      return platformPageRoute(const ProviderProductDetailsScreen());
    }
    if (settings.name == Routes.providerAddAddress) {
      return platformPageRoute(const ProviderAddAddressScreen());
    }
    if (settings.name == Routes.providerAddresses) {
      return platformPageRoute(const ProviderAddressesScreen());
    }
    if (settings.name == Routes.providerOrders) {
      return platformPageRoute(const ProviderOrdersScreen());
    }
    if (settings.name == Routes.providerEditProfile) {
      return platformPageRoute(const ProviderEditProfileScreen());
    }
    if (settings.name == Routes.providerPackageDetails) {
      return platformPageRoute(const ProviderPackageDetailsScreen());
    }
    if (settings.name == Routes.providerWorkScreen) {
      return platformPageRoute(const ProviderWorkAndProductsScreen());
    }
    if (settings.name == Routes.providerPackages) {
      return platformPageRoute(const ProviderPackagesScreen());
    }
    if (settings.name == Routes.providerForgetPassword) {
      return platformPageRoute(const ProviderForgotPasswordScreen());
    }
    if (settings.name == Routes.providerMore) {
      return platformPageRoute(const ProviderMoreScreen());
    } else {
      return platformPageRoute(UndefinedRouteScreen(settings.name));
    }
  }
}
