import 'package:shopping_app/feature/cart/models/cart.dart';
import 'package:shopping_app/feature/cart/models/cart_item.dart';
import 'package:shopping_app/feature/cart/repository/queries/get_cart.dart';
import 'package:shopping_app/feature/cart/repository/queries/remove_from_cart.dart';
import 'package:shopping_app/feature/cart/repository/queries/update_cart_item.dart';
import 'package:shopping_app/feature/discover/repository/queries/PrizeProductQuery.dart';
import 'package:shopping_app/feature/product_details/repository/queries/add_to_cart.dart';
import 'package:shopping_app/resources/app_data.dart';

import 'shopfiy_error.dart';
import 'shopify_config.dart';
import 'package:graphql/client.dart';
import 'package:shopping_app/feature/discover/model/product.dart';
import 'package:shopping_app/feature/discover/repository/queries/NListProductsWithQuery.dart';
import 'package:shopping_app/feature/discover/repository/queries/get_on_sale_collection.dart';
import 'package:shopping_app/feature/discover/repository/queries/create_cart.dart';
import '../discover/model/product.dart';

class ShopifyStore with ShopifyError {
  ShopifyStore._();

  static final ShopifyStore instance = ShopifyStore._();

  GraphQLClient get _graphQLClient => ShopifyConfig.graphQLClient;

  Future<List<Product>> getNProducts(int n, String query) async {
    assert(n != null);
    assert(query != null);
    List<Product> productList = [];
    final WatchQueryOptions _options =
        WatchQueryOptions(document: gql(getNProductsWithQuery), variables: {
      'n': n,
      'myQuery': query,
    });
    final QueryResult result = await _graphQLClient.query(_options);
    checkForError(result);
    productList =
        (Products.fromJson((result?.data ?? const {})["products"] ?? {}))
            .productList;

    _graphQLClient.cache.writeQuery(_options.asRequest, data: null);

    return productList;
  }

  Future<List<Product>> getPrizeProduct() async {
    List<Product> productList = [];
    final WatchQueryOptions _options =
    WatchQueryOptions(document: gql(getPrizeProductQuery));
    final QueryResult result = await _graphQLClient.query(_options);
    checkForError(result);
    productList =
        (Products.fromJson((result?.data ?? const {})["products"] ?? {}))
            .productList;

    _graphQLClient.cache.writeQuery(_options.asRequest, data: null);

    return productList;
  }

  Future<List<Product>> getOnSaleCollection() async {
    List<Product> productList = [];
    final WatchQueryOptions _options =
        WatchQueryOptions(document: gql(getOnSaleCollectionQuery));
    final QueryResult result = await _graphQLClient.query(_options);
    checkForError(result);
    productList =
        (Collections.fromJson((result?.data ?? const {})["collections"] ?? {}))
            .productList;
    return productList;
  }

  Future<String> createCart() async {
    String cartId;
    final MutationOptions _options =
        MutationOptions(document: gql(createCartMutation), variables: {
      'cartInput': {"lines": []},
    });
    final QueryResult result = await _graphQLClient.mutate(_options);
    checkForError(result);
    cartId = (result?.data ?? const {})['cartCreate']['cart']['id'];

    return cartId;
  }

  Future<Cart> getCart() async {
    List<CartItem> cartItems;
    final WatchQueryOptions _options = WatchQueryOptions(
        document: gql(getCartQuery), variables: {'cartId': AppData.cartId});
    final QueryResult result = await _graphQLClient.query(_options);
    checkForError(result);

    var jsonCartItems = (result?.data ?? const {})['cart']['lines']['edges'];
    print(jsonCartItems.length);

    cartItems = List.generate(jsonCartItems.length, (index) {
      final data = jsonCartItems[index];
      return CartItem(
          id: data['node']['id'],
          quantity: data['node']['quantity'],
          product: Product.fromCartJson(data['node']['merchandise']['product']));
    });

    _graphQLClient.cache.writeQuery(_options.asRequest, data: null);

    return Cart(cartItems, (result?.data ?? const {})['cart']['checkoutUrl']);
  }

  Future<int> addToCart(String merchandiseId) async {
    print(AppData.cartId);
    final MutationOptions _options =
        MutationOptions(document: gql(addToCartMutation), variables: {
      'lines': [
        {"merchandiseId": merchandiseId}
      ],
      'cartId': AppData.cartId
    });
    final QueryResult result = await _graphQLClient.mutate(_options);
    checkForError(result);

    return 1;
  }

  Future<int> updateCartItem(String cartItemId, int quantity) async {
    final MutationOptions _options =
    MutationOptions(document: gql(updateCartItemMutation), variables: {
      'lines': [
        {"id": cartItemId, "quantity": quantity}
      ],
      'cartId': AppData.cartId
    });
    final QueryResult result = await _graphQLClient.mutate(_options);
    checkForError(result);

    return 1;
  }

  Future<int> removeFromCart(String cartItemId) async {
    final MutationOptions _options =
    MutationOptions(document: gql(removeFromCartMutation), variables: {
      'lineIds': [
        cartItemId
      ],
      'cartId': AppData.cartId
    });
    final QueryResult result = await _graphQLClient.mutate(_options);
    checkForError(result);

    return 1;
  }
}
