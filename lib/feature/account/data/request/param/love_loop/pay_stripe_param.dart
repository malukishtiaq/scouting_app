import '../../../../../../core/common/extensions/string_extensions.dart';
import '../../../../../../core/params/base_params.dart';

class PayStripeParam extends BaseParams {
  final String? accessToken;
  final String? stripeToken;
  final String? payType;
  final String? description;
  final String? price;

  PayStripeParam({
    this.accessToken,
    this.stripeToken,
    this.payType,
    this.description,
    this.price,
  });

  @override
  Map<String, dynamic> toMap() => {
        if (accessToken.isNotEmptyNorNull) 'access_token': accessToken,
        if (stripeToken.isNotEmptyNorNull) 'stripe_token': stripeToken,
        if (payType.isNotEmptyNorNull) 'pay_type': payType,
        if (description.isNotEmptyNorNull) 'description': description,
        if (price.isNotEmptyNorNull) 'price': price,
      };
}
