import 'package:graphql/client.dart';
import 'package:shopify_store_app/shopify_models/graphql_operations/mutations/cart_buyer_identity_update.dart';
import 'package:shopify_store_app/shopify_models/graphql_operations/mutations/cart_discount_codes_update.dart';
import 'package:shopify_store_app/shopify_models/graphql_operations/mutations/cart_lines_add.dart';
import 'package:shopify_store_app/shopify_models/graphql_operations/mutations/cart_lines_remove.dart';
import 'package:shopify_store_app/shopify_models/graphql_operations/mutations/cart_lines_update.dart';
import 'package:shopify_store_app/shopify_models/graphql_operations/mutations/cart_note_update.dart';
import 'package:shopify_store_app/shopify_models/graphql_operations/mutations/cart_selected_delivery_options_update.dart';
import 'package:shopify_store_app/shopify_models/graphql_operations/mutations/create_cart.dart';
import 'package:shopify_store_app/shopify_models/graphql_operations/queries/get_cart_info.dart';
import 'package:shopify_store_app/shopify_models/graphql_operations/queries/get_cart_web_url.dart';
import 'package:shopify_store_app/shopify_models/mixins/src/shopfiy_error.dart';
import 'package:shopify_store_app/shopify_models/models/src/cart/cart.dart';
import 'package:shopify_store_app/shopify_models/models/src/cart/cart_line/cart_line.dart';
import 'package:shopify_store_app/shopify_models/models/src/checkout/mailing_address/mailing_address.dart';
import 'package:shopify_store_app/shopify_models/shopify_config.dart';

class ShopifyCart with ShopifyError {
  ShopifyCart._();

  static final ShopifyCart instance = ShopifyCart._();

  GraphQLClient? get _graphQLClient => ShopifyConfig.graphQLClient;


  // Method for getting Cart info
  Future<Cart> getCartInfoQuery(String cartId) async {
    final WatchQueryOptions options = WatchQueryOptions(
      document: gql(cartInfoQuery),
      variables: {'cartId': cartId},
    );
    final QueryResult result = await _graphQLClient!.query(options);
    checkForError(result);
    return Cart.fromJson(result.data!['cart']);
  }

  // Method for getting Cart Web Url for processing as WebPage.
  Future<String?> getCartWebUrlQuery(String cartId) async {
    final WatchQueryOptions _options = WatchQueryOptions(
      document: gql(getCartWebUrl),
      variables: {'id': cartId},
    );
    final QueryResult _queryResult = await _graphQLClient!.query(_options);
    checkForError(_queryResult);
    final node = _queryResult.data!['node'];
    if (node == null) {
      return null;
    } else {
      return node['webUrl'];
    }
  }


  Future<Cart> createCart({
    required List<CartLine> lines,
    required String userAccessToken,
    required String userEmail,
    required MailingAddress address,
    bool deleteThisPartOfCache = false,
  }) async {
    final MutationOptions options = MutationOptions(
      document: gql(createCartMutation),
      variables: {
        'input': {
          if (lines.isNotEmpty)
            {
              'lines': [
                for (var line in lines)
                  {
                    "merchandiseId": line.merchandise.id,
                    "quantity": line.quantity,
                  }
              ],
              'buyerIdentity': {
                'email': userEmail,
                'phone': address.phone,
                "customerAccessToken": userAccessToken,
                "deliveryAddressPreferences": {
                  "mailingAddress": {
                    "address1": address.address1,
                    "address2": address.address2,
                    "city": address.city,
                    "country": address.country,
                    "firstName": address.firstName,
                    "lastName": address.lastName,
                    "phone": address.phone,
                    "province": address.province,
                    "zip": address.zip
                  }
                }
              },
            }
        },
      },
    );

    final QueryResult result = await _graphQLClient!.mutate(options);

    checkForError(
      result,
      key: 'cartCreate',
      errorKey: 'cartUserErrors',
    );

    if (deleteThisPartOfCache) {
      _graphQLClient!.cache.writeQuery(options.asRequest, data: {});
    }

    return Cart.fromJson(
      ((result.data!['cartCreate'] ?? const {})['cart'] ?? const {}),
    );
  }

  Future<Cart> updateCartBuyerIdentity({
    required String cartId,
    required String customerAccessToken,
    required String userEmail,
    required MailingAddress address,
    bool deleteThisPartOfCache = false,
  }) async {
    final MutationOptions options = MutationOptions(
        document: gql(updateCartBuyerIdentityMutation),
        variables: {
          'cartId': cartId,
          'buyerIdentity': {
            'customerAccessToken': customerAccessToken,
            'countryCode':address.countryCodeV2,
            'email': userEmail,
            'phone': address.phone,
            'defaultAddress': {
              'firstName': address.firstName,
              'lastName': address.lastName,
              'address1': address.address1,
              'address2': address.address2,
              'city': address.city,
              'country': address.country,
              'province': address.province,
              'zip': address.zip
            }
          }
        });

    final QueryResult result = await _graphQLClient!.mutate(options);

    checkForError(
      result,
      key: 'cartBuyerIdentityUpdateV2',
      errorKey: 'cartUserErrors',
    );

    if (deleteThisPartOfCache) {
      _graphQLClient!.cache.writeQuery(options.asRequest, data: {});
    }

    return Cart.fromJson(
      ((result.data!['cartBuyerIdentityUpdateV2'] ?? const {})['cart'] ??
          const {}),
    );
  }

  // define a method to update the discount codes of a cart
  Future<Cart> updateCartDiscountCodes({
    required String cartId,
    required List<String> discountCodes,
  }) async {
    // create the mutation options with variables
    final MutationOptions options = MutationOptions(
      document: gql(cartDiscountCodesUpdateMutation),
      variables: <String, dynamic>{
        'cartId': cartId,
        'discountCodes': discountCodes,
      },
    );

    // execute the mutation
    final QueryResult result = await _graphQLClient!.mutate(options);

    // check for errors and throw exception if there are any
    checkForError(
      result,
      key: 'cartDiscountCodesUpdate',
      errorKey: 'cartUserErrors',
    );

    // return the cart object parsed from the mutation response
    return Cart.fromJson(
      ((result.data!['cartDiscountCodesUpdate'] ?? const {})['cart'] ??
          const {}),
    );
  }

  // define a method to add the Lines Items of a cart
  Future<Cart> addCartLines({
    required String cartId,
    required List<CartLine> lines,
  }) async {
    final List<Map<String, dynamic>> lineInputs = lines.map((line) {
      return {
        'variantId': line.merchandise.id,
        'quantity': line.quantity,
      };
    }).toList();

    final MutationOptions options = MutationOptions(
      document: gql(cartLinesAddMutation),
      variables: {
        'cartId': cartId,
        'lines': lineInputs,
      },
    );

    final QueryResult result = await _graphQLClient!.mutate(options);

    checkForError(result, key: 'cartLinesAdd', errorKey: 'userErrors');

    return Cart.fromJson(result.data!['cartLinesAdd']['cart']);
  }

  // define a method to remove the Lines Items of a cart
  Future<Cart> removeCartLines({
    required String cartId,
    required List<String> lineItemIds,
  }) async {
    final MutationOptions options = MutationOptions(
      document: gql(removeCartLinesMutation),
      variables: {
        'cartId': cartId,
        'lineItemIds': lineItemIds,
      },
    );

    final QueryResult result = await _graphQLClient!.mutate(options);

    checkForError(
      result,
      key: 'cartLinesRemove',
      errorKey: 'cartUserErrors',
    );

    return Cart.fromJson(
      ((result.data!['cartLinesRemove'] ?? const {})['cart'] ?? const {}),
    );
  }

  // define a method to update the Lines Items of a cart
  Future<Cart> updateCartLines({
    required String cartId,
    required List<CartLine> lines,
  }) async {
    final MutationOptions options = MutationOptions(
      document: gql(cartLinesUpdateMutation),
      variables: {
        'cartId': cartId,
        'lines': lines.map((line) => line.toJson()).toList(),
      },
    );

    final QueryResult result = await _graphQLClient!.mutate(options);

    checkForError(
      result,
      key: 'cartLinesUpdateV2',
      errorKey: 'cartUserErrors',
    );

    return Cart.fromJson(
      (result.data!['cartLinesUpdateV2'] ?? const {})['cart'] ?? const {},
    );
  }

  // Method to update the Note for a cart
  Future<Cart> updateCartNote({
    required String cartId,
    required String note,
  }) async {
    final MutationOptions options = MutationOptions(
      document: gql(cartNoteUpdateMutation),
      variables: {
        'id': cartId,
        'note': note,
      },
    );

    final QueryResult result = await _graphQLClient!.mutate(options);

    checkForError(
      result,
      key: 'cartNoteUpdate',
      errorKey: 'userErrors',
    );

    return Cart.fromJson(result.data!['cartNoteUpdate']['cart']);
  }

  // Method to update the selected delivery option for a cart
  Future<Cart> updateSelectedDeliveryOption({
    required String cartId,
    required String deliveryOptionId,
    bool deleteThisPartOfCache = false,
  }) async {
    final MutationOptions options = MutationOptions(
      document: gql(updateSelectedDeliveryOptionMutation),
      variables: {
        'cartId': cartId,
        'deliveryOptionId': deliveryOptionId,
      },
    );

    final QueryResult result = await _graphQLClient!.mutate(options);

    checkForError(
      result,
      key: 'cartShippingAddressUpdateV2',
      errorKey: 'cartUserErrors',
    );

    if (deleteThisPartOfCache) {
      _graphQLClient!.cache.writeQuery(options.asRequest, data: {});
    }

    return Cart.fromJson(
      ((result.data!['cartShippingAddressUpdateV2'] ?? const {})['cart'] ??
          const {}),
    );
  }
}
