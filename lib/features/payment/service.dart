import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:pet/common/widgets/loaders/loaders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'consts.dart';

class StripeService {
  StripeService._();

  static final StripeService instance = StripeService._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> createConnectedAccount(String email) async {
    try {
      String? existingAccountId = await _getAccountIdFromDatabase(email);
      if (existingAccountId != null) {
        return existingAccountId;
      }

      final Dio dio = Dio();
      Map<String, dynamic> data = {
        "type": "standard",
        "email": email,
      };

      var response = await dio.post(
        "https://api.stripe.com/v1/accounts",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer $stripeSecretKey",
            "Content-Type": 'application/x-www-form-urlencoded'
          },
        ),
      );

      if (response.data != null && response.data["id"] != null) {
        String accountId = response.data["id"];
        await _storeAccountIdInDatabase(accountId, email);
        return accountId;
      }
      return null;
    } catch (e) {
      print('Error creating connected account: $e');
      Loaders.errorSnackBar(title: 'Connected Account Creation Failed');
      return null;
    }
  }

  Future<bool> makePayment(String email, double price) async {
    try {
      String? accountId = await createConnectedAccount(email);
      if (accountId == null) {
        return false;
      }

      int amountInCents = (price * 100).toInt();
      String? paymentIntentClientSecret = await _createPaymentIntent(amountInCents, "usd", accountId);
      if (paymentIntentClientSecret == null) {
        return false;
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: "Laiba Ahmar",
        ),
      );

      bool paymentSuccess = await _presentPaymentSheet();
      return paymentSuccess;
    } catch (e) {
      print('Error during payment setup: $e');
      Loaders.errorSnackBar(title: 'Make Payment');
      return false;
    }
  }

  // Create a payment intent with the destination for the provider
  Future<String?> _createPaymentIntent(int amount, String currency, String destinationAccountId) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        "amount": amount,
        "currency": currency,
        "transfer_data[destination]": destinationAccountId, // Send funds directly to the provider
      };

      var response = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer $stripeSecretKey",
            "Content-Type": 'application/x-www-form-urlencoded'
          },
        ),
      );

      if (response.data != null && response.data["client_secret"] != null) {
        return response.data["client_secret"];
      }
      return null;
    } catch (e) {
      print('Error creating payment intent: $e');
      Loaders.errorSnackBar(title: 'Payment Intent failed');
      return null;
    }
  }

  // Present the payment sheet to the user
  Future<bool> _presentPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      return true;
    } catch (e) {
      print("Error during payment processing: $e");
      if (e is StripeException) {
        Loaders.errorSnackBar(title: "Payment Sheet Error");
      }
      return false;
    }
  }

  Future<String?> _getAccountIdFromDatabase(String email) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('stripe_accounts').doc(email).get();
      if (doc.exists) {
        return doc['account_id'];
      }
    } catch (e) {
      print('Error fetching account ID: $e');
    }
  }

  Future<void> _storeAccountIdInDatabase(String accountId, String email) async {
    try {
      await _firestore.collection('stripe_accounts').doc(email).set({
        'email': email,
        'account_id': accountId,
      });
    } catch (e) {
      print('Error storing account ID: $e');
    }
  }
}

