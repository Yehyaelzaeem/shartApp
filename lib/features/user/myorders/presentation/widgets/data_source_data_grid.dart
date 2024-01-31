import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../data/model/product_invoice.dart';

class ProductDataSource extends DataGridSource {
  ProductDataSource({required List<Product> productData}) {
    _productData = productData
        .map<DataGridRow>((Product e) => DataGridRow(cells: <DataGridCell>[
      DataGridCell<String>(columnName: 'name', value: e.name),
      DataGridCell<String>(
          columnName: 'description', value: e.description),
      DataGridCell<String>(columnName: 'price', value: e.price),
      DataGridCell<int>(columnName: 'quantity', value: int.parse(e.quantity)),
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
