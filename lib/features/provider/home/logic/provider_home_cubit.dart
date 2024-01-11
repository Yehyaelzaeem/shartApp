import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'provider_home_state.dart';

class ProviderHomeCubit extends Cubit<ProviderHomeState> {
  ProviderHomeCubit() : super(ProviderHomeInitial());
  static ProviderHomeCubit get(BuildContext context)=>BlocProvider.of(context);

}
