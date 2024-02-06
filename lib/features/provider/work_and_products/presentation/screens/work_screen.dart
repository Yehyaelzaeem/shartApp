import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/core/resources/assets_menager.dart';
import 'package:shart/widgets/custom_button.dart';
import '../../../../../widgets/custom_text_field.dart';
import '../../logic/work_products_cubit.dart';

class WorkScreen extends StatelessWidget {
  const WorkScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    WorkProductsCubit cubit = WorkProductsCubit.get(context);
    return BlocConsumer<WorkProductsCubit, WorkProductsState>(
      listener: (BuildContext context,WorkProductsState state) {},
      builder: (BuildContext context, WorkProductsState state) {
        if(cubit.worksModel !=null){
          final data =cubit.worksModel;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '${getLang(context, 'my_business1')}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    fontFamily: 'Lateef',
                  ),
                ),
                InkWell(
                   onTap: () async {
                     cubit.changeAddingState(!cubit.isAdding);
                   },
                   child:
                   cubit.isAdding == false ?
                   Row(
                     children: <Widget>[
                       Icon(Icons.add, color: Color(0xff136B79)),
                       Text('${getLang(context, 'my_business2')}',
                           style: TextStyle(
                               color: Color(0xff136B79),
                               fontFamily: 'Lateef',
                               fontSize: 14.sp,
                               fontWeight: FontWeight.bold)),
                     ],
                   ) : Icon(Icons.arrow_forward_ios, color: Colors.grey,),
                 ),
              ],
            ),
            SizedBox(height: 10,),
            cubit.isLoadingDelete?LinearProgressIndicator():SizedBox.shrink(),
            cubit.isAdding == true?
            cubit.image ==null?  Padding(
              padding: const EdgeInsets.only(top: 10.0,bottom: 10),
              child: InkWell(
                onTap: (){
                  cubit.getImage();
                },
                child: CustomTextField(hintText: '${getLang(context, 'my_business3')}',
                  prefixIcon: Icon(Icons.camera_alt_outlined,color: Colors.grey,),
                  borderColor: Colors.grey,
                  controller: TextEditingController(),enabled: false,),
              ),
            ):
            Padding(
              padding: const EdgeInsets.only(top: 10.0,bottom: 10),
              child: CustomTextField(hintText: '${getLang(context, 'my_business4')}',
                hintColor: Colors.blue.shade700,
                prefixIcon: Icon(Icons.camera_alt_outlined,color:  Colors.blue.shade800,),
                borderColor: Colors.grey,
                controller: TextEditingController(),enabled: false,),
            )
                :SizedBox.shrink(),
            cubit.worksModel!.data!.length==0?
            Expanded(
              child: Center(child: Text(getLang(context, 'There_jobs_currently'),
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 25.sp,
                fontFamily: 'Lateef',
              ),
              ),),
            ):
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
                child: GridView.builder(
                  itemCount: data!.data!.length,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemBuilder: (BuildContext context, int index) =>
                      Container(
                          width: 81.w,
                          height: 69.h,
                          alignment: Alignment.topLeft,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage('${data.data![index].file}'),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(10)),
                          child: InkWell(
                            onTap: (){
                              cubit.deleteWorks(data.data![index].id.toString(), context);
                            },
                            child: Container(
                                margin: EdgeInsets.only(top: 8, left: 8),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.white),
                                child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Icon(Icons.restore_from_trash_outlined,
                                        size: 25, color: Color(0xffFF3535)))),
                          )),
                ),
              ),
            ) ,
            cubit.isAdding == true ?
            cubit.isLoading==false?
            CustomElevatedButton(
                onTap: () {
                  cubit.addWorks(context);
                },
                buttonText: '${getLang(context, 'my_business_save')}'):Center(child: CircularProgressIndicator(),) : SizedBox.shrink(),
            SizedBox(height: 120.h,)
          ],
        );
         }  else{
          return Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }
}
