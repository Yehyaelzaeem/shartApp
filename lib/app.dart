import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nested/nested.dart';
import 'package:shart/core/resources/color.dart';
import 'package:shart/core/resources/themes/app_theme.dart';
import 'package:shart/features/chats/data/models/chat_user.dart';
import 'package:shart/features/chats/logic/chat_cubit.dart';
import 'package:shart/notificationss.dart';
import 'package:shart/shared_screens/notifications/logic/notification_cubit.dart';
import 'core/localization/appLocale.dart';
import 'core/notification/notification_service.dart';
import 'core/routing/navigation_services.dart';
import 'core/routing/route_generator.dart';
import 'core/routing/routes.dart';
import 'features/provider/auth/logic/auth_provider_cubit.dart';
import 'features/provider/home/logic/provider_home_cubit.dart';
import 'features/provider/myorders/logic/provider_orders_cubit.dart';
import 'features/provider/profile/logic/provider_profile_cubit.dart';
import 'features/provider/work_and_products/logic/work_products_cubit.dart';
import 'features/user/auth/logic/auth_cubit.dart';
import 'features/user/book_package_service/logic/book_package_cubit.dart';
import 'features/user/cart/logic/cart_cubit.dart';
import 'features/user/favorite/logic/favorite_cubit.dart';
import 'features/user/menu/logic/menu_cubit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'features/user/merchants/logic/merchants_cubit.dart';
import 'features/user/myorders/logic/my_orders_cubit.dart';
import 'features/user/myorders/presentation/screens/test.dart';
import 'features/user/profile/logic/user_profile_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // NotificationService notificationService = NotificationService();
    // notificationService.init();:
    return
      MultiBlocProvider(
        providers: <SingleChildWidget>[
        BlocProvider<AuthCubit>(create: (BuildContext context) => AuthCubit()),
        BlocProvider<UserProfileCubit>(create: (BuildContext context) => UserProfileCubit()),
        BlocProvider<AuthProviderCubit>(create: (BuildContext context) => AuthProviderCubit()),
        BlocProvider<ProviderProfileCubit>(create: (BuildContext context) => ProviderProfileCubit()),
        BlocProvider<MenuCubit>(create: (BuildContext context) => MenuCubit()),
        BlocProvider<NotificationCubit>(create: (BuildContext context) => NotificationCubit()),
        BlocProvider<WorkProductsCubit>(create: (BuildContext context) => WorkProductsCubit()),
        BlocProvider<FavoriteCubit>(create: (BuildContext context) => FavoriteCubit()),
        BlocProvider<ProviderHomeCubit>(create: (BuildContext context) => ProviderHomeCubit()),
        BlocProvider<MyOrdersCubit>(create: (BuildContext context) => MyOrdersCubit()),
        BlocProvider<MerchantsCubit>(create: (BuildContext context) => MerchantsCubit()),
        BlocProvider<CartCubit>(create: (BuildContext context) => CartCubit()),
        BlocProvider<ChatCubit>(create: (BuildContext context) => ChatCubit()),
        // BlocProvider<BeerCubit>(create: (BuildContext context) => BeerCubit()),
        BlocProvider<ProviderOrdersCubit>(create: (BuildContext context) => ProviderOrdersCubit()),
        BlocProvider<BookPackageCubit>(create: (BuildContext context) => BookPackageCubit()..getBrands(type:'spare_parts ', context: context)),
       ],
      child:
      ScreenUtilInit(
        designSize: const Size(375, 812),
        useInheritedMediaQuery: true,
        builder: (BuildContext context, Widget? child) {
          NotificationsFCM(context);
          return BlocConsumer<AuthCubit ,AuthState>(
              builder: (BuildContext context ,AuthState state){
                return  MaterialApp(
                  theme: AppThemes.whiteTheme,
                  color: whiteColor,
                  locale:  AuthCubit.get(context).localeLanguage,
                  localizationsDelegates: const <LocalizationsDelegate>[
                    AppLocale.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: const <Locale>[
                    Locale('en'), // English
                    Locale('ar'), // Arabic
                  ],
                  // localizationsDelegates: context.localizationDelegates,
                  // supportedLocales: context.supportedLocales,
                  // locale: context.locale,
                  title: 'شَرْط',
                  debugShowCheckedModeBanner: false,
                  navigatorKey: NavigationManager.navigationKey,
                  initialRoute: Routes.splash,
                  // home: ChatScreen(receiver: ChatUser(
                  //     image: 'https://dev02.matrix-clouds.com/shart/public/storage/users/default.jpg',
                  //     about: '', name: 'test', createdAt: '', isOnline: true, id: '232', lastActive: '', phone: '132564', pushToken: ''), isUser: false,),
                  onGenerateRoute: RouteGenerator.generateBaseRoute,
                );
              },
              listener: (BuildContext context ,AuthState state){},);
        },
      )
      );
  }
}
