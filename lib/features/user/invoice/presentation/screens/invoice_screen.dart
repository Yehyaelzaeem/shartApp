import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/resources/assets_menager.dart';
import 'package:shart/core/resources/color.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({Key? key}) : super(key: key);

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  List<Product> products = <Product>[];
  late ProductDataSource productDataSource;

  @override
  void initState() {
    super.initState();
    products = getProductData();
    productDataSource = ProductDataSource(productData: products);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 80.h),
          child: CustomAppBar(title: 'الفاتورة', hasBackButton: true)),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text('#261255',
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Align(
                  child: Image.asset(ImagesManager.logoCircle),
                  alignment: Alignment.centerLeft),
            ),
            SizedBox(height: 21.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('بواسطة',
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.bold)),
                        Padding(
                          padding: EdgeInsets.only(top: 14.h, bottom: 8.h),
                          child: Text('الثوب لقطع الغيار',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff6E6D71))),
                        ),
                        Text(' طلحة بن عبيد الله بحى النسيم الشرقى بالرياض',
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff6E6D71))),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('إلي',
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.bold)),
                        Padding(
                          padding: EdgeInsets.only(top: 14.h, bottom: 8.h),
                          child: Text('أحمد عبدالغنى محمود',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff6E6D71))),
                        ),
                        Text('العلمين , الشهداء , الرياض',
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff6E6D71))),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        Text('الإجمالى',
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.bold)),
                        SizedBox(height: 14.h),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            '3000 ${'rs'}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Lateef',
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff136B79),
                              minimumSize: Size(75.w, 40.h),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
             Padding(
              padding:   EdgeInsets.only(top: 50.h,bottom: 15.h),
              child: SfDataGrid(
                verticalScrollPhysics: NeverScrollableScrollPhysics(),
                horizontalScrollPhysics: BouncingScrollPhysics(),
                source: productDataSource,
                shrinkWrapRows: true,
                columnWidthMode: ColumnWidthMode.fill,
                rowHeight: 80.h,
                columns: <GridColumn>[
                  GridColumn(
                      columnName: 'name',
                      label: Container(
                          color: primaryColor,
                          alignment: Alignment.center,
                          child: Text(
                            'العنصر',
                            style: TextStyle(fontFamily: 'Tajawal'),
                          ))),
                  GridColumn(
                      columnName: 'description',
                      label: Container(
                          color: primaryColor,
                          alignment: Alignment.center,
                          child: Text('الوصف',
                              style: TextStyle(fontFamily: 'Tajawal')))),
                  GridColumn(
                      columnName: 'price',
                      label: Container(
                          color: primaryColor,
                          alignment: Alignment.center,
                          child: Text('التكلفة',
                              style: TextStyle(fontFamily: 'Tajawal')))),
                  GridColumn(
                      columnName: 'quantity',
                      label: Container(
                          color: primaryColor,
                          alignment: Alignment.center,
                          child: Text('الكمية',
                              style: TextStyle(fontFamily: 'Tajawal')))),
                  GridColumn(
                      columnName: 'total',
                      label: Container(
                        color: primaryColor,
                        alignment: Alignment.center,
                        child: Text('الإجمالي',
                            style: TextStyle(fontFamily: 'Tajawal')),
                      )),
                ],
              ),
            ),
            Padding(
              padding:   EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text('إجمالى\nالمطلوب',style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w400,color: Color(0xff6E6D71)),textAlign: TextAlign.center,),
                  SizedBox(width: 16.w),
                  Text('300\n ${'rs'}',style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w400,color: Color(0xff6E6D71)),textAlign: TextAlign.center,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

List<Product> getProductData() {
  return <Product>[
    Product('المنتج', 'لوريم ايبسم لوريم ايبسم لوريم ايبسم', '500\nر.س', 3,
        '1500\n ر.س'),
    Product('المنتج', 'لوريم ايبسم لوريم ايبسم لوريم ايبسم', '500\nر.س', 3,
        '1500\n ر.س'),
  ];
}

class Product {
  Product(this.name, this.description, this.price, this.quantity, this.total);

  final String name;
  final String description;
  final int quantity;
  final String price;
  final String total;
}

class ProductDataSource extends DataGridSource {
  ProductDataSource({required List<Product> productData}) {
    _productData = productData
        .map<DataGridRow>((Product e) => DataGridRow(cells: <DataGridCell>[
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(
                  columnName: 'description', value: e.description),
              DataGridCell<String>(columnName: 'price', value: e.price),
              DataGridCell<int>(columnName: 'quantity', value: e.quantity),
              DataGridCell<String>(columnName: 'total', value: e.total),
            ]))
        .toList();
  }

  List<DataGridRow> _productData = <DataGridRow>[];

  @override
  List<DataGridRow> get rows => _productData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((DataGridCell e) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8),
        child: Text('${e.value}',
            style: TextStyle(
                fontSize: 12.sp,
                color: Color(0xff6E6D71),
                fontFamily: 'Tajawal')),
      );
    }).toList());
  }
}
