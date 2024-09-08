import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shart/features/user/myorders/data/model/myorder_model.dart';
import 'package:shart/shared_screens/notifications/data/models/single_order_model.dart';
import 'package:shart/shared_screens/notifications/logic/notification_cubit.dart';
import '../../../../features/user/myorders/presentation/screens/order_details.dart';

class NotificationOrderDetails extends StatelessWidget {
  const NotificationOrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    NotificationCubit cubit =NotificationCubit.get(context);
    return Scaffold(
      body: BlocConsumer<NotificationCubit, NotificationState>(
        listener: (BuildContext context, NotificationState state) {},
        builder: (BuildContext context, NotificationState state) {
          SingleOrderModelData data =cubit.singleOrderModelData!.data!;
          if(cubit.singleOrderModelData!=null){
            MyOrdersModelData myOrdersModelData =MyOrdersModelData(
              id: data.id,
              providerId: data.providerId,
              provider: Provider(
                id: data.provider!.id!,
                name: data.provider!.name,
              ),
              userId: data.userId,
              user: User(
                id: data.user!.id,
                name: data.user!.name,
              ),
              totalPrice: data.totalPrice,
              status: data.status,
              userAddress: UserAddress(
                id: data.userAddress!.id,
                name: data.userAddress!.name,
                address: data.userAddress!.address,
              ),
              items: data.items!.map((Items2 e) => Items(
                id: e.id,orderId: e.orderId,
                providerId: e.providerId,
                providerProductId: e.providerProductId,
                price: e.price,
                qty: e.qty,
                providerProduct: ProviderProduct(
                  id: e.providerProduct!.id,
                  title: e.providerProduct!.title,
                  productStatus: e.providerProduct!.productStatus,
                  description: e.providerProduct!.description,
                  price: e.providerProduct!.price,
                  type: e.providerProduct!.type,
                  brand: Brand(
                    id: e.providerProduct!.brand!.id,
                    name: e.providerProduct!.brand!.name,
                    image: e.providerProduct!.brand!.image,
                    type: e.providerProduct!.brand!.type,
                  ),
                  brandId: e.providerProduct!.brandId,
                  modal: Modal(
                    id: e.providerProduct!.modal!.id,
                    name: e.providerProduct!.modal!.name,
                  ),
                  modalId: e.providerProduct!.modalId,
                  provider:Provider(
                    id: e.providerProduct!.provider!.id!,
                    name: e.providerProduct!.provider!.name,
                  ),
                  providerId: e.providerProduct!.providerId,
                  isFav: e.providerProduct!.isFav,
                  images: e.providerProduct!.images!.map((e) => Images(
                    image: e.image
                  )).toList(),
                  width:e.providerProduct!.width,
                  height: e.providerProduct!.height,
                  size:e.providerProduct!.size,

                )
              )).toList(),
            );
            return OrderDetailsScreen(myOrdersModelData: myOrdersModelData);
          }
          else{
            return Center(child: CircularProgressIndicator(),);
          }

        },
      ),
    );
  }
}
