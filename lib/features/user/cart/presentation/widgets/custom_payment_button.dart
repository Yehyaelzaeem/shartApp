import 'package:flutter/material.dart';
import 'package:shart/features/user/cart/data/model/cart_model.dart';
import 'package:shart/widgets/show_toast_widget.dart';
import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../common/intro/presentation/screens/choose_user_type_screen.dart';
import '../../../auth/logic/auth_cubit.dart';
import '../../logic/cart_cubit.dart';

class CompletePaymentButton extends StatelessWidget {
  const CompletePaymentButton({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {

        AuthCubit authCubit =AuthCubit.get(context);
        if (authCubit.token.isEmpty|| authCubit.token.toString() == 'null' || authCubit.token.toString() == '') {
          shouldBeRegister(context);
        }else{
          CartCubit cubit =CartCubit.get(context);
          if (cubit.products.isEmpty){
           showToast(text: '${getLang(context, 'no_items_cart')}', state: ToastStates.error, context: context);
          }else{
            cubit.sendOrder(50, context);

          }
        }

      },
      child: Center(
        child: Container(
          width: 135.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17.0),
              color:blueColor,
          ),
          child:
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Text(
                getLang(context, 'pay'),
                style: TextStyle(
                    fontSize: 23.0,
                    fontFamily: FontConstants.lateefFont,
                    color: Colors.white,
                    letterSpacing: 0.004200000017881393,
                    fontWeight: FontWeight.bold
                ),
                // style: GoogleFonts.cairo(
                //   fontSize: 12.0,
                //   color: const Color(0xFFEAC43D),
                //   letterSpacing: 0.003920000016689301,
                //   fontWeight: FontWeight.w700,
                // ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
shouldBeRegister(BuildContext context){
  AlertDialog alert;
  Widget cancelButton = MaterialButton(
    child: Text(getLang(context, 'cancel'),
    style:  TextStyle(
        fontSize: 23.0,
        fontFamily: FontConstants.lateefFont,
        color: Colors.brown,
        letterSpacing: 0.004200000017881393,
        fontWeight: FontWeight.bold
    ),

    ),
    onPressed: () async {
      Navigator.of(context, rootNavigator: true).pop();
    },
  );
  Widget okButton = new Align(
    alignment: Alignment.center,
    child: Container(
      width: MediaQuery.of(context).size.width,
      child: MaterialButton(
        color: blueColor,
        child: Text(
          getLang(context, 'login'),
          style: TextStyle(
              fontSize: 23.0,
              fontFamily: FontConstants.lateefFont,
              color: Colors.white,
              letterSpacing: 0.004200000017881393,
              fontWeight: FontWeight.bold
          ),
          // style: GoogleFonts.cairo(fontSize: 17,fontWeight: FontWeight.bold,
          //     color: colorWhite),
        ),
        onPressed: () async {
          // Navigator.of(context, rootNavigator: true).pop();
          // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>ChooseUserTypeScreen()));

          // Navigator.of(context, rootNavigator: true).pop();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => ChooseUserTypeScreen()),
                (Route<dynamic> route) => false,
          );
          // Navigator.of(context).push(MaterialPageRoute(builder:
          //     (context)=>LoginScreen()));
        },
      ),
    ),
  );
  // set up the AlertDialog
  alert = AlertDialog(
    title: Text(
      getLang(context, 'Log_in_first'),
      // style: GoogleFonts.cairo(fontSize: 17,fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    ),
    actions: <Widget>[
      okButton,
      cancelButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
