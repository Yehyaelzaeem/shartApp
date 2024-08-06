import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/localization/appLocale.dart';
import '../../../../../../widgets/custom_button.dart';
import '../../../../../../widgets/custom_text_field.dart';
import '../../../logic/provider_profile_cubit.dart';

class CustomCompleteProfileBody extends StatefulWidget {
  const CustomCompleteProfileBody({super.key, this.isEdit});
  final bool? isEdit;

  @override
  State<CustomCompleteProfileBody> createState() => _CustomCompleteProfileBodyState();
}

class _CustomCompleteProfileBodyState extends State<CustomCompleteProfileBody> {
  @override
  void initState() {
    ProviderProfileCubit cubit = ProviderProfileCubit.get(context);
    cubit.displayDataOfScreen();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ProviderProfileCubit cubit = ProviderProfileCubit.get(context);
    return SingleChildScrollView(
      child: BlocConsumer<ProviderProfileCubit, ProviderProfileState>(
        listener: (BuildContext context,ProviderProfileState state) {},
        builder: (BuildContext context, ProviderProfileState state) {
          return Column(
            children: <Widget>[
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
                    prefixIcon: Icon(Icons.camera_alt_outlined,color: Colors.grey,)),
              ):
              InkWell(
                onTap: (){
                  cubit.pickImage();
                },
                child: CustomTextField(
                    enabled: false,
                    hintText: '${getLang(context, 'successfully_store_logo_done')}',
                    hintColor: Colors.blue.shade700,
                    controller: TextEditingController(),
                    prefixIcon: Icon(Icons.camera_alt_outlined,color:  Colors.blue.shade800,)),
              ),
              SizedBox(height: 30.h,),
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
                  DateTime date = DateTime.now();
                  DateTime newDate = DateTime(date.year+20,
                      date.month , date.day);
                  showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.parse(
                          newDate.toString()))
                      .then((DateTime? value)  {
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
                    prefixIcon: Icon(Icons.upload_file_outlined,color: Colors.grey,)),
              ):InkWell(
                onTap: (){
                  cubit.pickImage2();
                },
                child: CustomTextField(
                    enabled: false,
                    hintText: '${getLang(context, 'done_add_identity')}',
                    hintColor: Colors.blue.shade700,
                    controller: TextEditingController(),
                    prefixIcon: Icon(Icons.upload_file_outlined,color:  Colors.blue.shade800)),
              ),
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
                    prefixIcon: Icon(Icons.upload_file_outlined,color: Colors.grey,)),
              ):
              InkWell(
                onTap: (){
                  cubit.pickPDF();
                },
                child: CustomTextField(
                    enabled: false,
                    hintText: '${getLang(context, 'done_add_commercial_file')}',
                    hintColor: Colors.blue.shade700,
                    controller: TextEditingController(),
                    prefixIcon: Icon(Icons.upload_file_outlined,color:  Colors.blue.shade800,)),
              ),
              SizedBox(height: 60.h,),
              cubit.isUpdateLoading == false ?
              CustomElevatedButton(onTap: () {
                widget.isEdit==true?
                cubit.updateCompleteProfile(context):
                cubit.sendCompleteProfile(context);
              }, buttonText: '${getLang(context, 'done')}'): Center(child: CircularProgressIndicator()),
              SizedBox(height: 150.h,),
            ],
          );
        },
      ),
    );
  }
}
