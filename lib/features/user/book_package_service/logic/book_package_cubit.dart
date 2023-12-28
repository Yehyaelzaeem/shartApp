import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/data_base/book_package_data_base.dart';
import '../data/model/brand_color_model.dart';
import '../data/model/brand_model.dart';
import '../data/model/brands.dart';
part 'book_package_state.dart';

class BookPackageCubit extends Cubit<BookPackageState> {
  BookPackageCubit() : super(BookPackageInitial());
  static BookPackageCubit get(BuildContext context)=>BlocProvider.of(context);
  BookPackageDataSource bookPackageDataSource =BookPackageDataSource();
  List<BrandsData?> brands=<BrandsData?>[];
  List<BrandModelData?> brandModelList=<BrandModelData?>[];
  List<BrandColorsData?> brandColorsList=<BrandColorsData?>[];


  void getBrands(BuildContext context){
    bookPackageDataSource.getBrands(context).then((value) {
      brands =value!.data!;
    });
    emit(GetBrandsState());
  }
  void getBrandModel(BuildContext context){
    bookPackageDataSource.getBrandModel(context).then((value) {
      brandModelList =value!.data!;
      // print(brandModelList.length);
      // print(brandModelList[0]!.name);
    });
    emit(GetBrandsState());
  }
  void getBrandColors(BuildContext context){
    bookPackageDataSource.getBrandColors(context).then((value) {
      brandColorsList =value!.data!;
    });
    emit(GetBrandsState());
  }
}
