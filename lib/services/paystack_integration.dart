import 'dart:js' as js;

import '../constants.dart';
import '../services/paystack_interop.dart' as paystack;

class PaystackPopup {
  static Future<void> openPaystackPopup({
    required String email,
    required String amount,
    required String ref,
    required void Function() onClosed,
    required void Function() onSuccess,
  }) async {
    js.context.callMethod(
      paystack.paystackPopUp(
        pKey,
        email,
        amount,
        ref,
        js.allowInterop(
          onClosed,
        ),
        js.allowInterop(
          onSuccess,
        ),
      ),
      [],
    );
  }
}
