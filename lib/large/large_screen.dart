import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../Screen.dart';
import '../constants.dart';
import '../custom_model.dart';

class LargeScreen extends StatefulWidget {
  const LargeScreen({Key? key}) : super(key: key);

  @override
  State<LargeScreen> createState() => _LargeScreenState();
}

class _LargeScreenState extends State<LargeScreen> {
  static const IconData copyright =
      IconData(0xe198, fontFamily: 'MaterialIcons');
  bool isSelected = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? _firstName;
  String? _lastName;
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _getUserData() async {
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        final DocumentSnapshot snapshot =
            await _firestore.collection('users').doc(user.uid).get();
        setState(() {
          _firstName = snapshot.get('firstName');
          _lastName = snapshot.get('lastName');
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  saveData(
    String email,
    DateTime now,
  ) {
    FirebaseFirestore.instance.collection('Discount Subscription').add({
      'Email': email,
      'uid': _auth.currentUser?.uid,
      'time-stamp': now,
    }).then((value) {
      if (kDebugMode) {
        print(value.id);
      }
    });
  }

  @override
  void initState() {
    _getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE9E9E9),
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.only(left: 50, right: 50, top: 10),
          child: SizedBox(
            width: 150,
            child: Image(
              image: AssetImage('images/logo.png'),
            ),
          ),
        ),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomAppBarButton(
                  isSelected: isSelected,
                  title: 'Shop',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Shop(),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  width: 30,
                ),
                CustomAppBarButton(
                  isSelected: isSelected,
                  title: 'About Us',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const About(),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  width: 30,
                ),
                CustomAppBarButton(
                  isSelected: isSelected,
                  title: 'Location',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Locations(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 100, top: 15, bottom: 10),
            child: SizedBox(
              width: 400,
              child: TextField(
                textInputAction: TextInputAction.search,
                cursorColor: const Color(0xFF141414),
                style: kAppBarTextStyle,
                decoration: searchTextField,
                onSubmitted: (value) {
                  searchProducts(value, context);
                },
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 50),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Consumer<Cart>(
                  builder: (context, cart, child) => Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomIconButton(
                        icon: const Icon(
                          Icons.shopping_bag,
                          size: 20,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Carts(),
                            ),
                          );
                        },
                      ),
                      if (cart.itemCount > 0)
                        Positioned(
                          top: 5,
                          right: 5,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: kWhiteColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 15,
                              maxHeight: 15,
                            ),
                            child: Text(
                              '${cart.itemCount}',
                              style: kAppBarTextStyle.copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                _auth.currentUser != null
                    ? PopupMenuButton(
                        elevation: 0.5,
                        padding: const EdgeInsets.only(top: 10.0),
                        constraints: const BoxConstraints(
                          maxWidth: 150,
                        ),
                        position: PopupMenuPosition.under,
                        color: Colors.white,
                        itemBuilder: (context) => <PopupMenuEntry>[
                          PopupMenuItem(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            onTap: () {},
                            value: 0,
                            child: Text(
                              'My Orders',
                              style: kAppBarTextStyle,
                            ),
                          ),
                          PopupMenuItem(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Text(
                              'Sign out',
                              style: kAppBarTextStyle,
                            ),
                            onTap: () {
                              setState(() {
                                _auth.signOut();
                              });
                            },
                          ),
                        ],
                        onSelected: (value) {
                          if (value == 0) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Orders(),
                                ));
                          }
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 15,
                          child: Text(
                            '${_firstName != null ? _firstName![0].toUpperCase() : ""}${_lastName != null ? _lastName![0].toUpperCase() : ""}',
                            style: kAppBarTextStyle.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                    : CustomIconButton(
                        icon: const Icon(
                          Icons.person,
                          size: 20,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignIn(),
                            ),
                          );
                        },
                      )
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 120,
                left: 100,
              ),
              height: size.height,
              width: size.width,
              decoration: const BoxDecoration(
                color: Color(0xFFE9E9E9),
                image: DecorationImage(
                  image: AssetImage('images/homeImg.png'),
                  alignment: Alignment.centerLeft,
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LIZB WIGS',
                    style: kLargeH2text.copyWith(fontSize: 40),
                  ),
                  Text(
                    '15% OFF',
                    style: kLargeH1text,
                  ),
                  Text(
                    'SHOP WITH CODE WBZIL15',
                    style: kLargeH2text,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Button(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => const Shop(),
                        ),
                      );
                    },
                    title: 'Shop',
                    style: kLargeButtonStyle,
                    width: 100,
                    height: 50,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'New Arrivals',
                  style: kLargeHeaderText,
                ),
                const SizedBox(
                  height: 1.5,
                ),
                Text(
                  'Fresh look fresh season',
                  style: kLargeSubHeaderText,
                ),
                const SizedBox(
                  height: 20,
                ),
                Button(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const NewArrivals(),
                      ),
                    );
                  },
                  title: 'Shop',
                  style: kLargeButtonStyle,
                  width: 100,
                  height: 50,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Product')
                      .limit(4)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFFE9E9E9),
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      List<Product> products =
                          snapshot.data!.docs.map((product) {
                        return Product(
                            id: product.get('id'),
                            productName: product.get('Name'),
                            productCategory: product.get('Category'),
                            productDescription: product.get('Description'),
                            productRating: product.get('Rating'),
                            productPrice: product.get('Price'),
                            imageUrl: [
                              product.get('Image')[0],
                              product.get('Image')[1],
                              product.get('Image')[2],
                              product.get('Image')[2],
                            ]);
                      }).toList();
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 400,
                          crossAxisCount: 4,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          Product product = products[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductInfo(product: product),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 250,
                                        child:
                                            Image.network(product.imageUrl[0]),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        product.productName,
                                        style: kAppBarTextStyle,
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Text("#${product.productPrice}",
                                          style: kAppBarTextStyle),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      RatingBar.builder(
                                          initialRating: double.parse(
                                            product.productRating,
                                          ),
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 20,
                                          itemPadding:
                                              const EdgeInsets.only(right: 2.0),
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                                size: 5,
                                              ),
                                          onRatingUpdate: (rating) {
                                            if (kDebugMode) {
                                              print(rating);
                                            }
                                          }),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Container(),
                                  //     TextButton(
                                  //       onPressed: () {
                                  //         Navigator.push(
                                  //           context,
                                  //           MaterialPageRoute(
                                  //             builder: (context) =>
                                  //                 ProductDetails(
                                  //                     product: product),
                                  //           ),
                                  //         );
                                  //       },
                                  //       style: TextButton.styleFrom(
                                  //         backgroundColor:
                                  //             const Color(0xFF141414),
                                  //         shadowColor: const Color(0xFF707070),
                                  //         fixedSize: const Size(120, 40),
                                  //         elevation: 5,
                                  //       ),
                                  //       child: Center(
                                  //         child: Text(
                                  //           'Buy Now',
                                  //           style: kAppBarTextStyle.copyWith(
                                  //               color: Colors.white,
                                  //               fontWeight: FontWeight.w500),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return Center(
                      child: Text(
                        'Product is not available yet!',
                        style: kAppBarTextStyle,
                      ),
                    );
                  }),
            ),
            const SizedBox(
              height: 150,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Best Sellers',
                  style: kLargeHeaderText,
                ),
                const SizedBox(
                  height: 1.5,
                ),
                Text(
                  'This is where you will find all of our customer favorites',
                  style: kLargeSubHeaderText,
                ),
                const SizedBox(
                  height: 20,
                ),
                Button(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const BestSeller(),
                      ),
                    );
                  },
                  title: 'Shop',
                  style: kLargeButtonStyle,
                  width: 100,
                  height: 50,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Product')
                      .orderBy('Rating', descending: true)
                      .limit(4)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFFE9E9E9),
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      List<Product> products =
                          snapshot.data!.docs.map((product) {
                        return Product(
                            id: product.get('id'),
                            productName: product.get('Name'),
                            productCategory: product.get('Category'),
                            productDescription: product.get('Description'),
                            productRating: product.get('Rating'),
                            productPrice: product.get('Price'),
                            imageUrl: [
                              product.get('Image')[0],
                              product.get('Image')[1],
                              product.get('Image')[2],
                              product.get('Image')[2],
                            ]);
                      }).toList();
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 400,
                          crossAxisCount: 4,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          Product product = products[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductInfo(product: product),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 250,
                                        child:
                                            Image.network(product.imageUrl[0]),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        product.productName,
                                        style: kAppBarTextStyle,
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        "#${product.productPrice}",
                                        style: kAppBarTextStyle,
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      RatingBar.builder(
                                          initialRating: double.parse(
                                            product.productRating,
                                          ),
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 20,
                                          itemPadding:
                                              const EdgeInsets.only(right: 2.0),
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                                size: 5,
                                              ),
                                          onRatingUpdate: (rating) {
                                            if (kDebugMode) {
                                              print(rating);
                                            }
                                          }),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Container(),
                                  //     TextButton(
                                  //       onPressed: () {
                                  //         Navigator.push(
                                  //           context,
                                  //           MaterialPageRoute(
                                  //             builder: (context) =>
                                  //                 ProductDetails(
                                  //                     product: product),
                                  //           ),
                                  //         );
                                  //       },
                                  //       style: TextButton.styleFrom(
                                  //         backgroundColor:
                                  //             const Color(0xFF141414),
                                  //         shadowColor: const Color(0xFF707070),
                                  //         fixedSize: const Size(120, 40),
                                  //         elevation: 5,
                                  //       ),
                                  //       child: Center(
                                  //         child: Text(
                                  //           'Buy Now',
                                  //           style: kAppBarTextStyle.copyWith(
                                  //               color: Colors.white,
                                  //               fontWeight: FontWeight.w500),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return Center(
                      child: Text(
                        'Product is not available yet!',
                        style: kAppBarTextStyle,
                      ),
                    );
                  }),
            ),
            const SizedBox(
              height: 150,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 100,
                vertical: 50,
              ),
              color: const Color(0xFF303030),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Shop By Collections',
                    style: kLargeHeaderText.copyWith(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const StraightWigs(),
                            ),
                          );
                        },
                        child: Container(
                          width: 400,
                          height: 600,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: AssetImage('images/img1.jpeg'),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Container(
                              color: Colors.transparent.withOpacity(0),
                              child: Text(
                                'Straight Wig',
                                style: kCollectionText,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CurlyWigs(),
                                ),
                              );
                            },
                            child: Container(
                              width: 550,
                              height: 280,
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image: AssetImage('images/img2.jpeg'),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Container(
                                  color: Colors.transparent.withOpacity(0),
                                  child: Text(
                                    'Curly Wig',
                                    style: kCollectionText,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const WavyWigs(),
                                ),
                              );
                            },
                            child: Container(
                              width: 550,
                              height: 280,
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image: AssetImage('images/img3.jpeg'),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Container(
                                  color: Colors.transparent.withOpacity(0),
                                  child: Text(
                                    'Wavy Wig',
                                    style: kCollectionText,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              'Testimonial',
              style: kLargeHeaderText,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 100,
                vertical: 150,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 100,
                    backgroundImage: AssetImage('images/image2.jpeg'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 300,
                    child: Text(
                      'I really appreciate the hair. It was just as I imagined. Thank you very much SIMPHAIR ',
                      style: kAppBarTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 50),
              color: const Color(0xFF141414),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Our Company',
                            style: kLargeHeaderText.copyWith(
                              color: const Color(0xFF707070),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const About(),
                                ),
                              );
                            },
                            child: Text(
                              'About Us',
                              style: kAppBarTextStyle.copyWith(
                                  color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HairCare(),
                                ),
                              );
                            },
                            child: Text(
                              'Hair Care Guide',
                              style: kAppBarTextStyle.copyWith(
                                  color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Pickup',
                              style: kAppBarTextStyle.copyWith(
                                  color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Partner Program',
                              style: kAppBarTextStyle.copyWith(
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Supports',
                            style: kLargeHeaderText.copyWith(
                              color: const Color(0xFF707070),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Faqs(),
                                ),
                              );
                            },
                            child: Text(
                              'FAQs',
                              style: kAppBarTextStyle.copyWith(
                                  color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Return(),
                                ),
                              );
                            },
                            child: Text(
                              'Returns',
                              style: kAppBarTextStyle.copyWith(
                                  color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const OrderDetails(),
                                ),
                              );
                            },
                            child: Text(
                              'Order Status',
                              style: kAppBarTextStyle.copyWith(
                                  color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Shipping(),
                                ),
                              );
                            },
                            child: Text(
                              'Shipping and Delivery',
                              style: kAppBarTextStyle.copyWith(
                                  color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Payment()),
                              );
                            },
                            child: Text(
                              'Payment Options',
                              style: kAppBarTextStyle.copyWith(
                                  color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Contacts(),
                                ),
                              );
                            },
                            child: Text(
                              'Contact Us',
                              style: kAppBarTextStyle.copyWith(
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Looking For Exclusive\nDiscount?',
                            style: kLargeHeaderText.copyWith(
                              color: const Color(0xFF707070),
                            ),
                          ),
                          Text(
                            'Sign up for all the latest updates and deals!',
                            style:
                                kAppBarTextStyle.copyWith(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Form(
                            key: _formKey,
                            child: SizedBox(
                              width: 300,
                              child: TextFormField(
                                controller: _emailController,
                                validator: (value) {
                                  RegExp regex = RegExp(
                                      r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

                                  if (_emailController.value.text.isEmpty) {
                                    return 'Enter your email';
                                  } else if (!(_emailController.value.text
                                      .contains(regex))) {
                                    return 'Enter a valid email';
                                  } else {
                                    return null;
                                  }
                                },
                                style: kAppBarTextStyle.copyWith(
                                    color: Colors.white),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 20,
                                  ),
                                  hintText: 'Enter your email',
                                  hintStyle: const TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        width: 1.5, color: Colors.white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        width: 1.5, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 300,
                            child: Text(
                              'BY ENTERING YOUR EMAIL ADDRESS, YOU AGREE TO RECEIVE MARKETING MESSAGES FROM OUR COMPANY AT THE EMAIL ADDRESS PROVIDED, INCLUDING MESSAGES LIKE CART REMINDERS. CONSENT IS NOT A CONDITION OF PURCHASE. MESSAGE FREQUENTLY VARIES. UNSUBSCRIBE TO CANCEL EMAIL MESSAGES. VIEW OUR PRIVACY POLICY AND TERMS OF SERVICE',
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  color: Color(0xFF707070),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 150,
                              ),
                              TextButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    saveData(
                                        _emailController.text, DateTime.now());
                                    _emailController.clear();
                                  }
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  fixedSize: const Size(120, 40),
                                ),
                                child: Center(
                                  child: Text(
                                    'Subscribe',
                                    style: kAppBarTextStyle.copyWith(
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 100,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            copyright,
                            color: Color(0xFF707070),
                            size: 15,
                          ),
                          Text(
                            ' 2023 SIMPHAIR. ALL RIGHT RESERVED.',
                            style: kAppBarTextStyle.copyWith(
                                color: const Color(0xFF707070), fontSize: 12),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              facebookLauncher();
                            },
                            child: const CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.transparent,
                              backgroundImage:
                                  AssetImage('images/facebook.png'),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              instagramLauncher();
                            },
                            child: const CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.transparent,
                              backgroundImage:
                                  AssetImage('images/instagram.png'),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              twitterLauncher();
                            },
                            child: const CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage('images/twitter.png'),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
