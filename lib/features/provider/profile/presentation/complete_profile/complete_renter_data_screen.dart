import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import 'package:shart/widgets/custom_button.dart';
import 'package:shart/widgets/custom_text_field.dart';
import 'package:intl/intl.dart';
import '../../logic/provider_profile_cubit.dart';

class CompleteRenterDataScreen extends StatelessWidget {
  const CompleteRenterDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProviderProfileCubit cubit = ProviderProfileCubit.get(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 80.h),
        child:
        CustomAppBar(title: '${getLang(context, 'complete_store_information')}', hasBackButton: true),
      ),
      body: Container(
        height: ScreenUtil().screenHeight * 0.85,
        margin: EdgeInsets.only(top: 24.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            border: Border.all(color: Colors.grey)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CustomTextField(
                hintText: '${getLang(context, 'store_name')}',
                hintColor: Colors.black,
                controller: cubit.titleCompleteProfileController,
              ),
              SizedBox(height: 30.h,),
              CustomTextField(
                hintText: '${getLang(context, 'commercial_no')}',
                hintColor: Colors.black,
                textInputType: TextInputType.number,
                controller: cubit.numberCommercialCompleteProfileController,
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.h),
                child: CustomTextField(
                  hintText: '${getLang(context, 'main_address')}',
                  hintColor: Colors.black,
                  controller: cubit.addressCompleteProfileController,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.h, bottom: 30.h),
                child: CustomTextField(
                  textInputType: TextInputType.number,
                  hintText: '${getLang(context, 'bank_account_number')}',
                  hintColor: Colors.black,
                  controller: cubit.iPanCompleteProfileController,
                ),
              ),
              InkWell(
                onTap: (){
                  var date = DateTime.now();
                  var newDate = DateTime(date.year+20,
                      date.month , date.day);
                  showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.parse(
                          newDate.toString()))
                      .then((value)  {
                        try{
                          cubit.dateCompleteProfileController.text = DateFormat('yyyy-MM-dd').format(value!);
                        }catch(e){
                  }
                  });
                },
                child: CustomTextField(
                  enabled: false,
                  hintText: '${getLang(context, 'record_expiration_date')}',
                  hintColor: Colors.black,
                  controller: cubit.dateCompleteProfileController,
                ),
              ),
              SizedBox(height: 30.h,),
              BlocConsumer<ProviderProfileCubit, ProviderProfileState>(
                listener: (BuildContext context,ProviderProfileState state) {
                },
                builder: (BuildContext context, ProviderProfileState state) {
                  return Column(
                    children: [
                     cubit.logoCompleteFile ==null?
                      InkWell(
                        onTap: () {
                          cubit.pickImage();
                        },
                        child:
                        CustomTextField(
                            enabled: false,
                            hintText: '${getLang(context, 'attach_store_logo')}',
                            hintColor: Colors.black,
                            controller: TextEditingController(),
                            prefixIcon: Icon(Icons.store)),
                      ):
                      CustomTextField(
                          enabled: false,
                          hintText: '${getLang(context, 'successfully_store_logo_done')}',
                          hintColor: Colors.blue.shade700,
                          controller: TextEditingController(),
                          prefixIcon: Icon(Icons.store,color:  Colors.blue.shade800,)),
                      SizedBox(height: 30.h,),
                      cubit.idCompleteFile ==null?
                      InkWell(
                        onTap: () {
                          cubit.pickImage2();
                        },
                        child: CustomTextField(
                            enabled: false,
                            hintText: '${getLang(context, 'add_identity')}',
                            hintColor: Colors.black,
                            controller: TextEditingController(),
                            prefixIcon: Icon(Icons.credit_card)),
                      ):CustomTextField(
                          enabled: false,
                          hintText: '${getLang(context, 'done_add_identity')}',
                          hintColor: Colors.blue.shade700,
                          controller: TextEditingController(),
                          prefixIcon: Icon(Icons.credit_card,color:  Colors.blue.shade800)),
                      SizedBox(height: 30.h,),
                      cubit.pdfCompleteFile==null?
                      InkWell(
                        onTap: () {
                          cubit.pickPDF();
                        },
                        child: CustomTextField(
                            enabled: false,
                            hintText: '${getLang(context, 'add_commercial_file')}',
                            hintColor: Colors.black,
                            controller: TextEditingController(),
                            prefixIcon: Icon(Icons.file_open_outlined)),
                      ):
                      CustomTextField(
                          enabled: false,
                          hintText: '${getLang(context, 'done_add_commercial_file')}',
                          hintColor: Colors.blue.shade700,
                          controller: TextEditingController(),
                          prefixIcon: Icon(Icons.file_open_outlined,color:  Colors.blue.shade800,)),
                      SizedBox(height: 60.h,),
                        cubit.isUpdateLoading == false ?CustomElevatedButton(onTap: () {
                        cubit.sendCompleteProfile(context);
                        }, buttonText: '${getLang(context, 'done')}'): Center(child: CircularProgressIndicator()),
                      SizedBox(height: 40.h,),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
