import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../custom_model.dart';
import '../Screen.dart';

class SmallHighPriceScreen extends StatelessWidget {
  const SmallHighPriceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Product')
            .orderBy('Price', descending: true)
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
            List<Product> products = snapshot.data!.docs.map((product) {
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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 350,
                crossAxisCount: 4,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              itemBuilder: (context, index) {
                Product product = products[index];

                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductInfo(product: product),
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 200,
                                child: Image.network(product.imageUrl[0]),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                product.productName,
                                style: kAppBarTextStyle,
                                overflow: TextOverflow.ellipsis,
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
                                  itemSize: 15,
                                  itemPadding:
                                      const EdgeInsets.only(right: 2.0),
                                  itemBuilder: (context, _) => const Icon(
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
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Container(),
                          //     TextButton(
                          //       onPressed: () {
                          //         Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //             builder: (context) =>
                          //                 ProductDetails(product: product),
                          //           ),
                          //         );
                          //       },
                          //       style: TextButton.styleFrom(
                          //         backgroundColor: const Color(0xFF141414),
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
        });
  }
}

class SmallLowPriceScreen extends StatelessWidget {
  const SmallLowPriceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Product')
            .orderBy('Price', descending: false)
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
            List<Product> products = snapshot.data!.docs.map((product) {
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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 350,
                crossAxisCount: 4,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              itemBuilder: (context, index) {
                Product product = products[index];

                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductInfo(product: product),
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 200,
                                child: Image.network(product.imageUrl[0]),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                product.productName,
                                style: kAppBarTextStyle,
                                overflow: TextOverflow.ellipsis,
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
                                  itemSize: 15,
                                  itemPadding:
                                      const EdgeInsets.only(right: 2.0),
                                  itemBuilder: (context, _) => const Icon(
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
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Container(),
                          //     TextButton(
                          //       onPressed: () {
                          //         Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //             builder: (context) =>
                          //                 ProductDetails(product: product),
                          //           ),
                          //         );
                          //       },
                          //       style: TextButton.styleFrom(
                          //         backgroundColor: const Color(0xFF141414),
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
        });
  }
}

class SmallBestSellingScreen extends StatelessWidget {
  const SmallBestSellingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Product')
            .orderBy('Rating', descending: true)
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
            List<Product> products = snapshot.data!.docs.map((product) {
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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 350,
                crossAxisCount: 4,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              itemBuilder: (context, index) {
                Product product = products[index];

                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductInfo(product: product),
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 200,
                                child: Image.network(product.imageUrl[0]),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                product.productName,
                                style: kAppBarTextStyle,
                                overflow: TextOverflow.ellipsis,
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
                                  itemSize: 15,
                                  itemPadding:
                                      const EdgeInsets.only(right: 2.0),
                                  itemBuilder: (context, _) => const Icon(
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
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Container(),
                          //     TextButton(
                          //       onPressed: () {
                          //         Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //             builder: (context) =>
                          //                 ProductDetails(product: product),
                          //           ),
                          //         );
                          //       },
                          //       style: TextButton.styleFrom(
                          //         backgroundColor: const Color(0xFF141414),
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
        });
  }
}

class SmallFeaturedScreen extends StatelessWidget {
  const SmallFeaturedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Product').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFE9E9E9),
              ),
            );
          }
          if (snapshot.hasData) {
            List<Product> products = snapshot.data!.docs.map((product) {
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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 350,
                crossAxisCount: 4,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              itemBuilder: (context, index) {
                Product product = products[index];

                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductInfo(product: product),
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 250,
                                child: Image.network(product.imageUrl[0]),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                product.productName,
                                style: kAppBarTextStyle,
                                overflow: TextOverflow.ellipsis,
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
                                  itemSize: 15,
                                  itemPadding:
                                      const EdgeInsets.only(right: 2.0),
                                  itemBuilder: (context, _) => const Icon(
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
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Container(),
                          //     TextButton(
                          //       onPressed: () {
                          //         Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //             builder: (context) =>
                          //                 ProductDetails(product: product),
                          //           ),
                          //         );
                          //       },
                          //       style: TextButton.styleFrom(
                          //         backgroundColor: const Color(0xFF141414),
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
        });
  }
}

class SmallWavyCollection extends StatelessWidget {
  const SmallWavyCollection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Product')
            .where('Category', isEqualTo: 'Wavy')
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
            List<Product> products = snapshot.data!.docs.map((product) {
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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 350,
                crossAxisCount: 4,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              itemBuilder: (context, index) {
                Product product = products[index];

                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductInfo(product: product),
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 200,
                                child: Image.network(product.imageUrl[0]),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                product.productName,
                                style: kAppBarTextStyle,
                                overflow: TextOverflow.ellipsis,
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
                                  itemSize: 15,
                                  itemPadding:
                                      const EdgeInsets.only(right: 2.0),
                                  itemBuilder: (context, _) => const Icon(
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
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Container(),
                          //     TextButton(
                          //       onPressed: () {
                          //         Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //             builder: (context) =>
                          //                 ProductDetails(product: product),
                          //           ),
                          //         );
                          //       },
                          //       style: TextButton.styleFrom(
                          //         backgroundColor: const Color(0xFF141414),
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
        });
  }
}

class SmallStraightCollection extends StatelessWidget {
  const SmallStraightCollection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Product')
            .where('Category', isEqualTo: 'Straight')
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
            List<Product> products = snapshot.data!.docs.map((product) {
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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 350,
                crossAxisCount: 4,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              itemBuilder: (context, index) {
                Product product = products[index];

                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductInfo(product: product),
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 200,
                                child: Image.network(product.imageUrl[0]),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                product.productName,
                                style: kAppBarTextStyle,
                                overflow: TextOverflow.ellipsis,
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
                                  itemSize: 15,
                                  itemPadding:
                                      const EdgeInsets.only(right: 2.0),
                                  itemBuilder: (context, _) => const Icon(
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
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Container(),
                          //     TextButton(
                          //       onPressed: () {
                          //         Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //             builder: (context) =>
                          //                 ProductDetails(product: product),
                          //           ),
                          //         );
                          //       },
                          //       style: TextButton.styleFrom(
                          //         backgroundColor: const Color(0xFF141414),
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
        });
  }
}

class SmallCurlyCollection extends StatelessWidget {
  const SmallCurlyCollection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Product')
            .where('Category', isEqualTo: 'Curly')
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
            List<Product> products = snapshot.data!.docs.map((product) {
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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 350,
                crossAxisCount: 4,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              itemBuilder: (context, index) {
                Product product = products[index];

                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductInfo(product: product),
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 200,
                                child: Image.network(product.imageUrl[0]),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                product.productName,
                                style: kAppBarTextStyle,
                                overflow: TextOverflow.ellipsis,
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
                                  itemSize: 15,
                                  itemPadding:
                                      const EdgeInsets.only(right: 2.0),
                                  itemBuilder: (context, _) => const Icon(
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
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Container(),
                          //     TextButton(
                          //       onPressed: () {
                          //         Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //             builder: (context) =>
                          //                 ProductDetails(product: product),
                          //           ),
                          //         );
                          //       },
                          //       style: TextButton.styleFrom(
                          //         backgroundColor: const Color(0xFF141414),
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
        });
  }
}

class SmallCartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const SmallCartItemWidget({
    Key? key,
    required this.cartItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage(cartItem.product.imageUrl[0]),
                  fit: BoxFit.contain),
            ),
          ),
          const SizedBox(
            width: 25,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.product.productName,
                    style: kCollectionText.copyWith(
                        fontSize: 15,
                        color: const Color(0xFF141414),
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '#${cartItem.product.productPrice}',
                    style: kAppBarTextStyle.copyWith(
                        fontWeight: FontWeight.w500, fontSize: 12),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: const Color(0xFF141414),
                        radius: 15,
                        child: IconButton(
                          onPressed: () {
                            cart.decreaseItemQuantity(cartItem.product);
                          },
                          icon: const Icon(Icons.remove, color: Colors.white),
                          iconSize: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        cartItem.quantity.toString(),
                        style: kAppBarTextStyle,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CircleAvatar(
                        backgroundColor: const Color(0xFF141414),
                        radius: 15,
                        child: IconButton(
                          onPressed: () {
                            cart.addItem(cartItem.product);
                          },
                          icon: const Icon(Icons.add, color: Colors.white),
                          iconSize: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      // IconButton(
                      //   onPressed: () {
                      //     cart.removeItem(cartItem);
                      //   },
                      //   icon: const Icon(
                      //     Icons.delete,
                      //     size: 15,
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SmallReviewPage extends StatefulWidget {
  final String productID;

  const SmallReviewPage({Key? key, required this.productID}) : super(key: key);

  @override
  State<SmallReviewPage> createState() => _SmallReviewPageState();
}

class _SmallReviewPageState extends State<SmallReviewPage> {
  final TextEditingController _reviewController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();

  storeData(
    String review,
    String rating,
    DateTime now,
  ) {
    FirebaseFirestore.instance
        .collection('Product')
        .doc(widget.productID)
        .collection('Reviews')
        .add({
      'Review': review,
      'Rating': rating,
      'time-stamp': now,
    }).then((value) {
      if (kDebugMode) {
        print(value.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            onPressed: () {
              // setstate to screen for customers to write reviews and provide rating
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      'Write your Review',
                      style: kAppBarTextStyle.copyWith(
                          fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Enter your rating',
                          style: kAppBarTextStyle.copyWith(
                              fontWeight: FontWeight.w400, fontSize: 10),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: 100,
                          child: TextField(
                            controller: _ratingController,
                            textInputAction: TextInputAction.next,
                            cursorColor: const Color(0xFF141414),
                            style: kAppBarTextStyle.copyWith(fontSize: 12),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 20,
                              ),
                              filled: true,
                              fillColor: const Color(0xFFFFFFFF),
                              hintText: 'Rating',
                              hintStyle: TextStyle(
                                color: const Color(0xFF141414).withOpacity(0.5),
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Color(0xFF707070), width: 1.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Color(0xFF141414),
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        TextField(
                          controller: _reviewController,
                          textInputAction: TextInputAction.done,
                          maxLines: 10,
                          cursorColor: const Color(0xFF141414),
                          style: kAppBarTextStyle.copyWith(fontSize: 12),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 20,
                            ),
                            filled: true,
                            fillColor: const Color(0xFFFFFFFF),
                            hintText: 'Write your review here',
                            hintStyle: TextStyle(
                              color: const Color(0xFF141414).withOpacity(0.5),
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Color(0xFF707070), width: 1.5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color(0xFF141414),
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Color(0xFF141414),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        onPressed: () {
                          storeData(
                            _reviewController.text,
                            _ratingController.text,
                            DateTime.now(),
                          );
                          Navigator.of(context).pop();
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFF141414),
                        ),
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFF141414),
              elevation: 2.5,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              fixedSize: const Size(200, 50),
            ),
            child: ListTile(
              leading: const Icon(
                Icons.edit,
                color: Colors.white,
                size: 12,
              ),
              title: Text(
                'Write a Review',
                style: kAppBarTextStyle.copyWith(
                    color: Colors.white, fontSize: 12),
              ),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          // streams of reviews from firebase in a card widget in listview
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Product')
                .doc(widget.productID)
                .collection('Reviews')
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
                return ListView(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    children: snapshot.data!.docs
                        .map(
                          (productReview) => Card(
                            margin: const EdgeInsets.all(10),
                            child: ListTile(
                              title: Padding(
                                padding: const EdgeInsets.only(
                                    left: 50, right: 50, top: 50, bottom: 10),
                                child: Text(
                                  productReview.get('Review'),
                                  style: kAppBarTextStyle.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(
                                    left: 50, right: 50, top: 10, bottom: 50),
                                child: RatingBar.builder(
                                    initialRating: double.parse(
                                      productReview.get('Rating'),
                                    ),
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 15,
                                    itemPadding:
                                        const EdgeInsets.only(right: 2.0),
                                    itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 5,
                                        ),
                                    onRatingUpdate: (rating) {
                                      if (kDebugMode) {
                                        print(rating);
                                      }
                                    }),
                              ),
                            ),
                          ),
                        )
                        .toList());
              }
              return Center(
                child: Text(
                  'There is no Review',
                  style: kAppBarTextStyle.copyWith(fontSize: 12),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class SmallQuestionPage extends StatefulWidget {
  final String productID;

  const SmallQuestionPage({Key? key, required this.productID})
      : super(key: key);

  @override
  State<SmallQuestionPage> createState() => _SmallQuestionPageState();
}

class _SmallQuestionPageState extends State<SmallQuestionPage> {
  final TextEditingController _questionController = TextEditingController();

  storeData(
    String question,
    DateTime now,
  ) {
    FirebaseFirestore.instance
        .collection('Product')
        .doc(widget.productID)
        .collection('Questions')
        .add({
      'Question': question,
      'time-stamp': now,
    }).then((value) {
      if (kDebugMode) {
        print(value.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            onPressed: () {
              // setstate to screen for customers to ask questions
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      'Ask a Question',
                      style: kAppBarTextStyle.copyWith(
                          fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    content: TextField(
                      controller: _questionController,
                      textInputAction: TextInputAction.done,
                      maxLines: 10,
                      cursorColor: const Color(0xFF141414),
                      style: kAppBarTextStyle.copyWith(fontSize: 12),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 20,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFFFFFFF),
                        hintText: 'Type your question here',
                        hintStyle: TextStyle(
                          color: const Color(0xFF141414).withOpacity(0.5),
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Color(0xFF707070), width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF141414),
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Color(0xFF141414),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        onPressed: () {
                          storeData(
                            _questionController.text,
                            DateTime.now(),
                          );
                          Navigator.of(context).pop();
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFF141414),
                        ),
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFF141414),
              elevation: 2.5,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              fixedSize: const Size(200, 50),
            ),
            child: ListTile(
              leading: const Icon(
                Icons.edit,
                color: Colors.white,
                size: 12,
              ),
              title: Text(
                'Ask a Question',
                style: kAppBarTextStyle.copyWith(
                    color: Colors.white, fontSize: 12),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Product')
                  .doc(widget.productID)
                  .collection('Questions')
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
                  return ListView(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      children: snapshot.data!.docs
                          .map(
                            (productQuestion) => Card(
                              margin: const EdgeInsets.all(10),
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 50, right: 50, top: 50, bottom: 10),
                                  child: Text(
                                    productQuestion.get('Question'),
                                    style: kAppBarTextStyle.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 50, right: 50, top: 10, bottom: 50),
                                  child: Text(
                                    productQuestion.get('Answer'),
                                    style: kAppBarTextStyle.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList());
                }
                return Center(
                  child: Text(
                    'Ask your Question',
                    style: kAppBarTextStyle.copyWith(fontSize: 12),
                  ),
                );
              })
        ],
      ),
    );
  }
}
