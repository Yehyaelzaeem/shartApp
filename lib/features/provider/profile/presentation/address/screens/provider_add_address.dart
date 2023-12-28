import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/features/provider/auth/logic/auth_provider_cubit.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import 'package:shart/widgets/custom_button.dart';
import 'package:shart/widgets/custom_text_field.dart';
import '../../../logic/provider_profile_cubit.dart';
import '../widgets/custom_radio_widget.dart';
class ProviderAddAddressScreen extends StatelessWidget{
  const ProviderAddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProviderProfileCubit cubit =ProviderProfileCubit.get(context);

    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(
          title: 'أضف عنوان',
          hasBackButton: true,
        ),
        preferredSize: Size(double.infinity, 80.h),
      ),
      body: SingleChildScrollView(
        child: Container(
            height: ScreenUtil().screenHeight * 0.85,
            margin: EdgeInsets.only(top: 24.h),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                border: Border.all(color: Colors.grey)),
            child:
            BlocConsumer<ProviderProfileCubit ,ProviderProfileState>(
              builder: (BuildContext context ,ProviderProfileState state){
                return     Column(
                  children: <Widget>[
                    CustomRadioAddAddressWidget(),
                    if (cubit.addressType == 1)
                      Padding(
                        padding: EdgeInsets.only(top: 25.h),
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          underline: const SizedBox.shrink(),
                          hint: Text(
                            'العنوان الرئيسي',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          items: <String>['test', 'test', 'test']
                              .map((String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ))
                              .toList(),
                          onChanged: (String? value) {
                            // setState(() {
                            //   // selectedValue = value;
                            // });
                          },
                          buttonStyleData: ButtonStyleData(
                              decoration: BoxDecoration(
                                  border:
                                  Border.all(color: Colors.grey.withOpacity(0.5)),
                                  borderRadius: BorderRadius.circular(8.r))),
                        ),
                      ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.h),
                      child: CustomTextField(
                          hintText: 'اسم الفرع',
                          hintColor: Colors.black,
                          controller: cubit.addressAddNameController),
                    ),
                    CustomTextField(
                        hintText: 'العنوان',
                        hintColor: Colors.black,
                        controller: cubit.addressAddController),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.h),
                      child: CustomTextField(
                        hintText: 'الموقع',
                        controller: TextEditingController(),
                        prefixIcon: Icon(Icons.location_on_rounded,
                            color: Colors.grey.shade400),
                        hintColor: Colors.black,
                      ),
                    ),
                    CustomTextField(
                        hintText: 'رقم التليفون',
                        hintColor: Colors.black,
                        controller: cubit.addressAddPhoneController),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.h),
                      child:
                      CustomElevatedButton(onTap: () {
                        cubit.addAddressProvider(AuthProviderCubit.get(context).token, context);
                      }, buttonText: 'حفظ'),
                    ),
                  ],
                );
              },
              listener: (BuildContext context ,ProviderProfileState state){},
            )

        ),
      ),
    );
  }
}
