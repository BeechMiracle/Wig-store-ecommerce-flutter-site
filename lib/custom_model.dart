import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Screen.dart';
import 'constants.dart';

class CustomIconButton extends StatelessWidget {
  final Icon icon;
  final VoidCallback onTap;
  const CustomIconButton({
    Key? key,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: icon,
      color: const Color(0xFF141414),
      focusColor: Colors.white,
      splashColor: const Color(0xFFE9E9E9),
    );
  }
}

class CustomAppBarButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  const CustomAppBarButton({
    Key? key,
    required this.isSelected,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      hoverColor: const Color(0xFFE9E9E9).withOpacity(0.2),
      child: Text(
        title,
        style: GoogleFonts.roboto(
          textStyle: TextStyle(
            color: const Color(0xFF141414),
            fontSize: 15,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final double width;
  final double height;
  final TextStyle style;

  const Button({
    Key? key,
    required this.onTap,
    required this.title,
    required this.width,
    required this.height,
    required this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        backgroundColor: const Color(0xFF141414),
        shadowColor: const Color(0xFF141414).withOpacity(0.3),
        fixedSize: Size(width, height),
      ),
      child: Text(
        title,
        style: style,
      ),
    );
  }
}

Widget orderCard(QueryDocumentSnapshot docs) {
  return Card(
    margin: const EdgeInsets.all(25),
    child: Padding(
      padding: const EdgeInsets.all(50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Text(
              'Order Number :',
              style: kAppBarTextStyle.copyWith(fontWeight: FontWeight.w500),
            ),
            title: Text(
              docs.get('Reference'),
              style: kAppBarTextStyle,
            ),
          ),
          ListTile(
            leading: Text(
              'Total Price :',
              style: kAppBarTextStyle.copyWith(fontWeight: FontWeight.w500),
            ),
            title: Text(
              docs.get('Price'),
              style: kAppBarTextStyle,
            ),
          ),
          ListTile(
            leading: Text(
              'Date and Time :',
              style: kAppBarTextStyle.copyWith(fontWeight: FontWeight.w500),
            ),
            title: Text(
              '${docs.get('time-stamp').toDate().toString()} UTC+1',
              style: kAppBarTextStyle,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget smallOrderCard(QueryDocumentSnapshot docs) {
  return Card(
    margin: const EdgeInsets.all(25),
    child: Padding(
      padding: const EdgeInsets.all(50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Text(
              'Order Number :',
              style: kAppBarTextStyle.copyWith(
                  fontWeight: FontWeight.w500, fontSize: 12),
            ),
            title: Text(
              docs.get('Reference'),
              style: kAppBarTextStyle.copyWith(fontSize: 12),
            ),
          ),
          ListTile(
            leading: Text(
              'Total Price :',
              style: kAppBarTextStyle.copyWith(
                  fontWeight: FontWeight.w500, fontSize: 12),
            ),
            title: Text(
              docs.get('Price'),
              style: kAppBarTextStyle.copyWith(fontSize: 12),
            ),
          ),
          ListTile(
            leading: Text(
              'Date and Time :',
              style: kAppBarTextStyle.copyWith(
                  fontWeight: FontWeight.w500, fontSize: 12),
            ),
            title: Text(
              '${docs.get('time-stamp').toDate().toString()} UTC+1',
              style: kAppBarTextStyle.copyWith(fontSize: 12),
            ),
          ),
        ],
      ),
    ),
  );
}

// Widget boxCard(Function()? onTap, QueryDocumentSnapshot docs) {
//   return Expanded(
//     child: Container(
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: Colors.white,
//       ),
//       child: Column(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: 250,
//                 child: Image.network(docs.get('Image')[0]),
//               ),
//               const SizedBox(
//                 height: 5,
//               ),
//               Text(
//                 docs.get('Name'),
//                 style: kAppBarTextStyle,
//               ),
//               const SizedBox(
//                 height: 2,
//               ),
//               Text(
//                 "#${docs.get('Price')}",
//                 style: kAppBarTextStyle.copyWith(fontWeight: FontWeight.w600),
//               ),
//               const SizedBox(
//                 height: 2,
//               ),
//               RatingBar.builder(
//                   initialRating: double.parse(
//                     docs.get('Rating'),
//                   ),
//                   minRating: 1,
//                   direction: Axis.horizontal,
//                   allowHalfRating: true,
//                   itemCount: 5,
//                   itemSize: 10,
//                   itemPadding: const EdgeInsets.only(right: 2.0),
//                   itemBuilder: (context, _) => const Icon(
//                         Icons.star,
//                         color: Colors.amber,
//                       ),
//                   onRatingUpdate: (rating) {
//                     if (kDebugMode) {
//                       print(rating);
//                     }
//                   }),
//             ],
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(),
//               TextButton(
//                 onPressed: onTap,
//                 style: TextButton.styleFrom(
//                   backgroundColor: const Color(0xFF141414),
//                   shadowColor: const Color(0xFF707070),
//                   fixedSize: const Size(100, 40),
//                   elevation: 5,
//                 ),
//                 child: Text(
//                   'BUY NOW',
//                   style: kAppBarTextStyle.copyWith(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 12,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
// }

// Widget cubeCard(Function()? onTap, QueryDocumentSnapshot docs) {
//   return Expanded(
//     child: Container(
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: Colors.white,
//       ),
//       child: Column(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: 200,
//                 child: Image.network(docs.get('Image')[0]),
//               ),
//               const SizedBox(
//                 height: 5,
//               ),
//               Text(
//                 docs.get('Name'),
//                 style: kAppBarTextStyle.copyWith(fontSize: 12),
//                 overflow: TextOverflow.ellipsis,
//               ),
//               const SizedBox(
//                 height: 2,
//               ),
//               Text(
//                 "#${docs.get('Price')}",
//                 style: kAppBarTextStyle.copyWith(
//                     fontSize: 12, fontWeight: FontWeight.w600),
//               ),
//               const SizedBox(
//                 height: 2,
//               ),
//               RatingBar.builder(
//                   initialRating: double.parse(
//                     docs.get('Rating'),
//                   ),
//                   minRating: 1,
//                   direction: Axis.horizontal,
//                   allowHalfRating: true,
//                   itemCount: 5,
//                   itemSize: 10,
//                   itemPadding: const EdgeInsets.only(right: 2.0),
//                   itemBuilder: (context, _) => const Icon(
//                         Icons.star,
//                         color: Colors.amber,
//                       ),
//                   onRatingUpdate: (rating) {
//                     if (kDebugMode) {
//                       print(rating);
//                     }
//                   }),
//             ],
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(),
//               TextButton(
//                 onPressed: onTap,
//                 style: TextButton.styleFrom(
//                   backgroundColor: const Color(0xFF141414),
//                   shadowColor: const Color(0xFF707070),
//                   fixedSize: const Size(80, 30),
//                   elevation: 5,
//                 ),
//                 child: Text(
//                   'BUY NOW',
//                   style: kAppBarTextStyle.copyWith(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 10,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
// }

class Product {
  final String id;
  final String productName;
  final String productCategory;
  final String productDescription;
  final String productRating;
  final String productPrice;
  final List<String> imageUrl;

  Product({
    required this.id,
    required this.productName,
    required this.productCategory,
    required this.productDescription,
    required this.productRating,
    required this.productPrice,
    required this.imageUrl,
  });
  factory Product.fromSnapshot(DocumentSnapshot doc) {
    return Product(
      id: doc.get('id'),
      productName: doc.get('Name'),
      productDescription: doc.get('Description'),
      productPrice: doc.get('Price'),
      productCategory: doc.get('Category'),
      productRating: doc.get('Rating'),
      imageUrl: [
        doc.get('Image')[0],
        doc.get('Image')[1],
        doc.get('Image')[2],
        doc.get('Image')[3],
      ],
    );
  }
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  CartItem decreaseQuantity() {
    return CartItem(
      product: product,
      quantity: quantity - 1,
    );
  }
}

class Cart extends ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += double.parse(cartItem.product.productPrice) * cartItem.quantity;
    });
    return total;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (existingCartItem) => CartItem(
          product: product,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          product: product,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void decreaseItemQuantity(Product product) {
    if (_items.containsKey(product.id)) {
      // Decrease the quantity of the item in the cart
      if (_items[product.id]!.quantity > 1) {
        _items.update(
          product.id,
          (existingCartItem) => existingCartItem.decreaseQuantity(),
        );
      } else {
        _items.remove(product.id);
      }
      notifyListeners();
    }
  }

  void removeItem(CartItem item) {
    _items.remove(item);

    notifyListeners();
  }

  void clear() {
    _items.clear();

    notifyListeners();
  }

  Future<void> checkout(String loggedInUserId) async {
    final orderRef = FirebaseFirestore.instance
        .collection('Users')
        .doc('loggedInUserId')
        .collection('Orders')
        .doc();

    await orderRef.set({
      'items': _items.values
          .map((item) => {
                'Product Name': item.product.productName,
                'Product Category': item.product.productCategory,
                'Product Price': item.product.productPrice,
                'Product Id': item.product.id,
              })
          .toList(),
      'Total Amount': totalAmount,
      'Created At': Timestamp.now(),
    });

    _items = {};
    notifyListeners();
  }
}

// Future<List<Product>> searchWords(String searchText) async {
//   final QuerySnapshot searchResults = await FirebaseFirestore.instance
//       .collection('Product')
//       .where('name', isGreaterThanOrEqualTo: searchText)
//       .where('name', isLessThan: searchText + 'z')
//       .get();
//
//   List<Product> searchResult = searchResults.docs
//       .map((product) => Product(
//               id: product.get('id'),
//               productName: product.get('Name'),
//               productCategory: product.get('Category'),
//               productDescription: product.get('Description'),
//               productRating: product.get('Rating'),
//               productPrice: product.get('Price'),
//               imageUrl: [
//                 product.get('Image')[0],
//                 product.get('Image')[1],
//                 product.get('Image')[2],
//                 product.get('Image')[2],
//               ]))
//       .toList();
//   return searchResult;
// }

Future<void> searchProducts(String query, BuildContext context) async {
  try {
    List<Product> foundProducts = [];
    final productsSnapshot =
        await FirebaseFirestore.instance.collection('Product').get();
    for (var productDoc in productsSnapshot.docs) {
      final product = Product.fromSnapshot(productDoc);
      if (product.productName.toLowerCase().contains(query.toLowerCase())) {
        foundProducts.add(product);
      }
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Search(searchResults: foundProducts),
      ),
    );
  } catch (e) {
    if (kDebugMode) {
      print('Error searching products: $e');
    }
    // show error dialog or snackBar
  }
}

Future<void> mediumSearchProducts(String query, BuildContext context) async {
  try {
    List<Product> foundProducts = [];
    final productsSnapshot =
        await FirebaseFirestore.instance.collection('Product').get();
    for (var productDoc in productsSnapshot.docs) {
      final product = Product.fromSnapshot(productDoc);
      if (product.productName.toLowerCase().contains(query.toLowerCase())) {
        foundProducts.add(product);
      }
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Search(searchResults: foundProducts),
      ),
    );
  } catch (e) {
    if (kDebugMode) {
      print('Error searching products: $e');
    }
    // show error dialog or snackBar
  }
}

Future<void> smallSearchProducts(String query, BuildContext context) async {
  try {
    List<Product> foundProducts = [];
    final productsSnapshot =
        await FirebaseFirestore.instance.collection('Product').get();
    for (var productDoc in productsSnapshot.docs) {
      final product = Product.fromSnapshot(productDoc);
      if (product.productName.toLowerCase().contains(query.toLowerCase())) {
        foundProducts.add(product);
      }
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Search(searchResults: foundProducts),
      ),
    );
  } catch (e) {
    if (kDebugMode) {
      print('Error searching products: $e');
    }
    // show error dialog or snackBar
  }
}

void facebookLauncher() {
  launchUrl(Uri.parse('https://google.com'));
}

void instagramLauncher() {
  launchUrl(Uri.parse('https://google.com'));
}

void twitterLauncher() {
  launchUrl(Uri.parse('https://google.com'));
}
