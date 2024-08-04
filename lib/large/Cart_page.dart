import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../Screen.dart';
import '../constants.dart';
import '../custom_model.dart';
import '../services/paystack_integration.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _promoCodeController = TextEditingController();
  late CartItem item;
  final List<GlobalKey<FormState>> _formKey = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  String generateRef() {
    final randomCode = DateTime.now().millisecondsSinceEpoch;
    return 'ref-$randomCode';
  }

  storeData(
    String firstName,
    String lastName,
    String email,
    String phoneNumber,
    String promoCode,
    String price,
    String address,
    String reference,
    List<String> imgUrl,
    List<String> productName,
    List<String> productPrice,
    List<String> quantity,
    DateTime now,
  ) {
    FirebaseFirestore.instance.collection('Orders').add({
      'First Name': firstName,
      'Last Name': lastName,
      'Email': email,
      'Phone Number': phoneNumber,
      'Promo Code': promoCode,
      'Price': price,
      'Address': address,
      'Reference': reference,
      'imgUrl': imgUrl,
      'Product Name': productName,
      'Product Price': productPrice,
      'Quantity': quantity,
      'uid': _auth.currentUser?.uid,
      'time-stamp': now,
    }).then((value) {
      if (kDebugMode) {
        print(value.id);
      }
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? _firstName;
  String? _lastName;

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

  @override
  void initState() {
    _getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    // final auth = Provider.of<Auth>(context);
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFE9E9E9),
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () {
            Navigator.popAndPushNamed(context, 'home');
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 50, right: 50, top: 10),
            child: SizedBox(
              width: 150,
              child: Image(
                image: AssetImage('images/hairlogo.png'),
              ),
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
                  isSelected: false,
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
                  isSelected: false,
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
                  isSelected: false,
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
                        onTap: () {},
                      ),
                      if (cart.itemCount > 0)
                        Positioned(
                          top: 5,
                          right: 5,
                          child: Container(
                            decoration: BoxDecoration(
                              color: kWhiteColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 15,
                              maxHeight: 15,
                            ),
                            child: Center(
                              child: Text(
                                '${cart.itemCount}',
                                style: kAppBarTextStyle.copyWith(
                                    fontSize: 10, fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              ),
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
                      ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: size.width,
              height: size.height / 2,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/cart.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Text(
                  'CART',
                  style: kCollectionText,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 50),
              child: cart.itemCount > 0
                  ? Column(
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cart.itemCount,
                            itemBuilder: (context, index) {
                              final item = cart.items.values.toList()[index];
                              return CartWidget(cartItem: item);
                            }),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: kCollectionText.copyWith(
                                color: const Color(0xFF707070),
                              ),
                            ),
                            const Spacer(),
                            Chip(
                              labelPadding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              backgroundColor: const Color(0xFF707070),
                              label: Text(
                                '#${cart.totalAmount.toStringAsFixed(2)}',
                                style: kCollectionText.copyWith(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        Button(
                          onTap: () {
                            _auth.currentUser != null
                                ? showModalBottomSheet<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 100, vertical: 25),
                                        width: size.width,
                                        height: 1600,
                                        color: kBColor,
                                        child: ListView(
                                          shrinkWrap: true,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Form(
                                                  key: _formKey[0],
                                                  child: SizedBox(
                                                    width: 250,
                                                    child: TextFormField(
                                                        controller:
                                                            _firstNameController,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter
                                                              .allow(
                                                            RegExp(
                                                                r"[a-zA-Z]+|\s"),
                                                          )
                                                        ],
                                                        validator: (value) {
                                                          if (_firstNameController
                                                              .value
                                                              .text
                                                              .isEmpty) {
                                                            return 'Enter your first name';
                                                          } else {
                                                            return null;
                                                          }
                                                        },
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        cursorColor:
                                                            const Color(
                                                                0xFF141414),
                                                        style: kAppBarTextStyle,
                                                        keyboardType:
                                                            TextInputType.name,
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            vertical: 20,
                                                            horizontal: 20,
                                                          ),
                                                          filled: true,
                                                          fillColor:
                                                              const Color(
                                                                  0xFFFFFFFF),
                                                          hintText:
                                                              'First Name',
                                                          hintStyle: TextStyle(
                                                            color: const Color(
                                                                    0xFF141414)
                                                                .withOpacity(
                                                                    0.5),
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Color(
                                                                        0xFF707070),
                                                                    width: 1.5),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            borderSide:
                                                                const BorderSide(
                                                              color: Color(
                                                                  0xFF141414),
                                                              width: 1.5,
                                                            ),
                                                          ),
                                                        )),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 100,
                                                ),
                                                Form(
                                                  key: _formKey[1],
                                                  child: SizedBox(
                                                    width: 250,
                                                    child: TextFormField(
                                                        controller:
                                                            _lastNameController,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter
                                                              .allow(
                                                            RegExp(
                                                                r"[a-zA-Z]+|\s"),
                                                          )
                                                        ],
                                                        validator: (value) {
                                                          if (_lastNameController
                                                              .value
                                                              .text
                                                              .isEmpty) {
                                                            return 'Enter your last name';
                                                          } else {
                                                            return null;
                                                          }
                                                        },
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        cursorColor:
                                                            const Color(
                                                                0xFF141414),
                                                        style: kAppBarTextStyle,
                                                        keyboardType:
                                                            TextInputType.name,
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            vertical: 20,
                                                            horizontal: 20,
                                                          ),
                                                          filled: true,
                                                          fillColor:
                                                              const Color(
                                                                  0xFFFFFFFF),
                                                          hintText: 'Last Name',
                                                          hintStyle: TextStyle(
                                                            color: const Color(
                                                                    0xFF141414)
                                                                .withOpacity(
                                                                    0.5),
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Color(
                                                                        0xFF707070),
                                                                    width: 1.5),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            borderSide:
                                                                const BorderSide(
                                                              color: Color(
                                                                  0xFF141414),
                                                              width: 1.5,
                                                            ),
                                                          ),
                                                        )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 25,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Form(
                                                  key: _formKey[2],
                                                  child: SizedBox(
                                                    width: 600,
                                                    child: TextFormField(
                                                      controller:
                                                          _emailController,
                                                      validator: (value) {
                                                        RegExp regex = RegExp(
                                                            r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

                                                        if (_emailController
                                                            .value
                                                            .text
                                                            .isEmpty) {
                                                          return 'Enter your email';
                                                        } else if (!(_emailController
                                                            .value.text
                                                            .contains(regex))) {
                                                          return 'Enter a valid email';
                                                        } else {
                                                          return null;
                                                        }
                                                      },
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      cursorColor: const Color(
                                                          0xFF141414),
                                                      style: kAppBarTextStyle,
                                                      keyboardType:
                                                          TextInputType
                                                              .emailAddress,
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          vertical: 20,
                                                          horizontal: 20,
                                                        ),
                                                        filled: true,
                                                        fillColor: const Color(
                                                            0xFFFFFFFF),
                                                        hintText: 'Email',
                                                        hintStyle: TextStyle(
                                                          color: const Color(
                                                                  0xFF141414)
                                                              .withOpacity(0.5),
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Color(
                                                                      0xFF707070),
                                                                  width: 1.5),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide:
                                                              const BorderSide(
                                                            color: Color(
                                                                0xFF141414),
                                                            width: 1.5,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 25,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Form(
                                                      key: _formKey[3],
                                                      child: SizedBox(
                                                        width: 400,
                                                        child: TextFormField(
                                                          controller:
                                                              _phoneController,
                                                          inputFormatters: [
                                                            FilteringTextInputFormatter
                                                                .allow(
                                                              RegExp(r"[0-9]"),
                                                            )
                                                          ],
                                                          validator: (value) {
                                                            RegExp regex =
                                                                RegExp(
                                                                    r"[0-9]");

                                                            if (_phoneController
                                                                .value
                                                                .text
                                                                .isEmpty) {
                                                              return 'Enter your phone number';
                                                            } else if (!(_phoneController
                                                                .value.text
                                                                .contains(
                                                                    regex))) {
                                                              return 'Enter a valid phone number';
                                                            } else {
                                                              return null;
                                                            }
                                                          },
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          cursorColor:
                                                              const Color(
                                                                  0xFF141414),
                                                          style:
                                                              kAppBarTextStyle,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              InputDecoration(
                                                            contentPadding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                              vertical: 20,
                                                              horizontal: 20,
                                                            ),
                                                            filled: true,
                                                            fillColor:
                                                                const Color(
                                                                    0xFFFFFFFF),
                                                            hintText:
                                                                'Phone Number',
                                                            hintStyle:
                                                                TextStyle(
                                                              color: const Color(
                                                                      0xFF141414)
                                                                  .withOpacity(
                                                                      0.5),
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color: Color(
                                                                          0xFF707070),
                                                                      width:
                                                                          1.5),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              borderSide:
                                                                  const BorderSide(
                                                                color: Color(
                                                                    0xFF141414),
                                                                width: 1.5,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 50,
                                                    ),
                                                    SizedBox(
                                                      width: 150,
                                                      child: TextFormField(
                                                        initialValue: cart
                                                            .totalAmount
                                                            .toStringAsFixed(0),
                                                        readOnly: true,
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        cursorColor:
                                                            const Color(
                                                                0xFF141414),
                                                        style: kAppBarTextStyle,
                                                        keyboardType:
                                                            TextInputType.name,
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            vertical: 20,
                                                            horizontal: 20,
                                                          ),
                                                          filled: true,
                                                          fillColor:
                                                              const Color(
                                                                  0xFFFFFFFF),
                                                          hintText:
                                                              'Total Amount',
                                                          hintStyle: TextStyle(
                                                            color: const Color(
                                                                    0xFF141414)
                                                                .withOpacity(
                                                                    0.5),
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Color(
                                                                        0xFF707070),
                                                                    width: 1.5),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            borderSide:
                                                                const BorderSide(
                                                              color: Color(
                                                                  0xFF141414),
                                                              width: 1.5,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 25,
                                                ),
                                                SizedBox(
                                                  width: 600,
                                                  child: TextFormField(
                                                      controller:
                                                          _promoCodeController,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      cursorColor: const Color(
                                                          0xFF141414),
                                                      style: kAppBarTextStyle,
                                                      keyboardType:
                                                          TextInputType.name,
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          vertical: 20,
                                                          horizontal: 20,
                                                        ),
                                                        filled: true,
                                                        fillColor: const Color(
                                                            0xFFFFFFFF),
                                                        hintText: 'Promo Code',
                                                        hintStyle: TextStyle(
                                                          color: const Color(
                                                                  0xFF141414)
                                                              .withOpacity(0.5),
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Color(
                                                                      0xFF707070),
                                                                  width: 1.5),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide:
                                                              const BorderSide(
                                                            color: Color(
                                                                0xFF141414),
                                                            width: 1.5,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                                const SizedBox(
                                                  height: 25,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      width: 600,
                                                      child: TextFormField(
                                                        controller:
                                                            _addressController,
                                                        textInputAction:
                                                            TextInputAction
                                                                .done,
                                                        maxLines: 5,
                                                        cursorColor:
                                                            const Color(
                                                                0xFF141414),
                                                        style: kAppBarTextStyle,
                                                        keyboardType:
                                                            TextInputType
                                                                .streetAddress,
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            vertical: 20,
                                                            horizontal: 20,
                                                          ),
                                                          filled: true,
                                                          fillColor:
                                                              const Color(
                                                                  0xFFFFFFFF),
                                                          hintText:
                                                              'Delivery Address',
                                                          hintStyle: TextStyle(
                                                            color: const Color(
                                                                    0xFF141414)
                                                                .withOpacity(
                                                                    0.5),
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Color(
                                                                        0xFF707070),
                                                                    width: 1.5),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            borderSide:
                                                                const BorderSide(
                                                              color: Color(
                                                                  0xFF141414),
                                                              width: 1.5,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 100,
                                                ),
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    final ref = generateRef();
                                                    final discount =
                                                        cart.totalAmount * 0.85;
                                                    final amount =
                                                        _promoCodeController
                                                                    .text ==
                                                                'WBZIL15'
                                                            ? discount
                                                            : cart.totalAmount;
                                                    if (_formKey[0].currentState!.validate() &&
                                                        _formKey[1]
                                                            .currentState!
                                                            .validate() &&
                                                        _formKey[2]
                                                            .currentState!
                                                            .validate() &&
                                                        _formKey[3]
                                                            .currentState!
                                                            .validate()) {
                                                      await PaystackPopup
                                                          .openPaystackPopup(
                                                        email: _emailController
                                                            .text,
                                                        amount: (amount * 100)
                                                            .toString(),
                                                        ref: ref,
                                                        onClosed: () {
                                                          debugPrint(
                                                              'Could\'nt finish payment');
                                                        },
                                                        onSuccess: () {
                                                          debugPrint(
                                                              'successful payment');
                                                          storeData(
                                                            _firstNameController
                                                                .text,
                                                            _lastNameController
                                                                .text,
                                                            _emailController
                                                                .text,
                                                            _phoneController
                                                                .text,
                                                            _promoCodeController
                                                                .text,
                                                            cart.totalAmount
                                                                .toString(),
                                                            _addressController
                                                                .text,
                                                            ref,
                                                            cart.items.values
                                                                .map((item) => item
                                                                    .product
                                                                    .imageUrl[0])
                                                                .toList(),
                                                            cart.items.values
                                                                .map((item) => item
                                                                    .product
                                                                    .productName)
                                                                .toList(),
                                                            cart.items.values
                                                                .map((item) => item
                                                                    .product
                                                                    .productPrice)
                                                                .toList(),
                                                            cart.items.values
                                                                .map((item) => item
                                                                    .quantity
                                                                    .toString())
                                                                .toList(),
                                                            DateTime.now(),
                                                          );
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      );
                                                    }
                                                  },
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(const Color(
                                                                  0xFF141414)),
                                                      fixedSize:
                                                          MaterialStateProperty
                                                              .all(const Size(
                                                                  600, 50))),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 20),
                                                    child: Center(
                                                      child: Text(
                                                        'Pay Now',
                                                        style: kAppBarTextStyle
                                                            .copyWith(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 50,
                                            ),
                                          ],
                                        ),
                                      );
                                    })
                                : showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          'Continue as Guest?',
                                          style: kAppBarTextStyle.copyWith(
                                              fontWeight: FontWeight.w500),
                                          textAlign: TextAlign.center,
                                        ),
                                        actions: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  showModalBottomSheet<void>(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      100,
                                                                  vertical: 25),
                                                          width: size.width,
                                                          height: 1600,
                                                          color: kBColor,
                                                          child: ListView(
                                                            shrinkWrap: true,
                                                            physics:
                                                                const BouncingScrollPhysics(),
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Form(
                                                                    key:
                                                                        _formKey[
                                                                            0],
                                                                    child:
                                                                        SizedBox(
                                                                      width:
                                                                          250,
                                                                      child: TextFormField(
                                                                          controller: _firstNameController,
                                                                          inputFormatters: [
                                                                            FilteringTextInputFormatter.allow(
                                                                              RegExp(r"[a-zA-Z]+|\s"),
                                                                            )
                                                                          ],
                                                                          validator: (value) {
                                                                            if (_firstNameController.value.text.isEmpty) {
                                                                              return 'Enter your first name';
                                                                            } else {
                                                                              return null;
                                                                            }
                                                                          },
                                                                          textInputAction: TextInputAction.next,
                                                                          cursorColor: const Color(0xFF141414),
                                                                          style: kAppBarTextStyle,
                                                                          keyboardType: TextInputType.name,
                                                                          decoration: InputDecoration(
                                                                            contentPadding:
                                                                                const EdgeInsets.symmetric(
                                                                              vertical: 20,
                                                                              horizontal: 20,
                                                                            ),
                                                                            filled:
                                                                                true,
                                                                            fillColor:
                                                                                const Color(0xFFFFFFFF),
                                                                            hintText:
                                                                                'First Name',
                                                                            hintStyle:
                                                                                TextStyle(
                                                                              color: const Color(0xFF141414).withOpacity(0.5),
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.normal,
                                                                            ),
                                                                            border:
                                                                                OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              borderSide: const BorderSide(color: Color(0xFF707070), width: 1.5),
                                                                            ),
                                                                            focusedBorder:
                                                                                OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              borderSide: const BorderSide(
                                                                                color: Color(0xFF141414),
                                                                                width: 1.5,
                                                                              ),
                                                                            ),
                                                                          )),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 100,
                                                                  ),
                                                                  Form(
                                                                    key:
                                                                        _formKey[
                                                                            1],
                                                                    child:
                                                                        SizedBox(
                                                                      width:
                                                                          250,
                                                                      child: TextFormField(
                                                                          controller: _lastNameController,
                                                                          inputFormatters: [
                                                                            FilteringTextInputFormatter.allow(
                                                                              RegExp(r"[a-zA-Z]+|\s"),
                                                                            )
                                                                          ],
                                                                          validator: (value) {
                                                                            if (_lastNameController.value.text.isEmpty) {
                                                                              return 'Enter your last name';
                                                                            } else {
                                                                              return null;
                                                                            }
                                                                          },
                                                                          textInputAction: TextInputAction.next,
                                                                          cursorColor: const Color(0xFF141414),
                                                                          style: kAppBarTextStyle,
                                                                          keyboardType: TextInputType.name,
                                                                          decoration: InputDecoration(
                                                                            contentPadding:
                                                                                const EdgeInsets.symmetric(
                                                                              vertical: 20,
                                                                              horizontal: 20,
                                                                            ),
                                                                            filled:
                                                                                true,
                                                                            fillColor:
                                                                                const Color(0xFFFFFFFF),
                                                                            hintText:
                                                                                'Last Name',
                                                                            hintStyle:
                                                                                TextStyle(
                                                                              color: const Color(0xFF141414).withOpacity(0.5),
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.normal,
                                                                            ),
                                                                            border:
                                                                                OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              borderSide: const BorderSide(color: Color(0xFF707070), width: 1.5),
                                                                            ),
                                                                            focusedBorder:
                                                                                OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              borderSide: const BorderSide(
                                                                                color: Color(0xFF141414),
                                                                                width: 1.5,
                                                                              ),
                                                                            ),
                                                                          )),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 25,
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Form(
                                                                    key:
                                                                        _formKey[
                                                                            2],
                                                                    child:
                                                                        SizedBox(
                                                                      width:
                                                                          600,
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            _emailController,
                                                                        validator:
                                                                            (value) {
                                                                          RegExp
                                                                              regex =
                                                                              RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

                                                                          if (_emailController
                                                                              .value
                                                                              .text
                                                                              .isEmpty) {
                                                                            return 'Enter your email';
                                                                          } else if (!(_emailController
                                                                              .value
                                                                              .text
                                                                              .contains(regex))) {
                                                                            return 'Enter a valid email';
                                                                          } else {
                                                                            return null;
                                                                          }
                                                                        },
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        cursorColor:
                                                                            const Color(0xFF141414),
                                                                        style:
                                                                            kAppBarTextStyle,
                                                                        keyboardType:
                                                                            TextInputType.emailAddress,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          contentPadding:
                                                                              const EdgeInsets.symmetric(
                                                                            vertical:
                                                                                20,
                                                                            horizontal:
                                                                                20,
                                                                          ),
                                                                          filled:
                                                                              true,
                                                                          fillColor:
                                                                              const Color(0xFFFFFFFF),
                                                                          hintText:
                                                                              'Email',
                                                                          hintStyle:
                                                                              TextStyle(
                                                                            color:
                                                                                const Color(0xFF141414).withOpacity(0.5),
                                                                            fontSize:
                                                                                15,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                          ),
                                                                          border:
                                                                              OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                            borderSide:
                                                                                const BorderSide(color: Color(0xFF707070), width: 1.5),
                                                                          ),
                                                                          focusedBorder:
                                                                              OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                            borderSide:
                                                                                const BorderSide(
                                                                              color: Color(0xFF141414),
                                                                              width: 1.5,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 25,
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Form(
                                                                        key: _formKey[
                                                                            3],
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              400,
                                                                          child:
                                                                              TextFormField(
                                                                            controller:
                                                                                _phoneController,
                                                                            inputFormatters: [
                                                                              FilteringTextInputFormatter.allow(
                                                                                RegExp(r"[0-9]"),
                                                                              )
                                                                            ],
                                                                            validator:
                                                                                (value) {
                                                                              RegExp regex = RegExp(r"[0-9]");

                                                                              if (_phoneController.value.text.isEmpty) {
                                                                                return 'Enter your phone number';
                                                                              } else if (!(_phoneController.value.text.contains(regex))) {
                                                                                return 'Enter a valid phone number';
                                                                              } else {
                                                                                return null;
                                                                              }
                                                                            },
                                                                            textInputAction:
                                                                                TextInputAction.next,
                                                                            cursorColor:
                                                                                const Color(0xFF141414),
                                                                            style:
                                                                                kAppBarTextStyle,
                                                                            keyboardType:
                                                                                TextInputType.number,
                                                                            decoration:
                                                                                InputDecoration(
                                                                              contentPadding: const EdgeInsets.symmetric(
                                                                                vertical: 20,
                                                                                horizontal: 20,
                                                                              ),
                                                                              filled: true,
                                                                              fillColor: const Color(0xFFFFFFFF),
                                                                              hintText: 'Phone Number',
                                                                              hintStyle: TextStyle(
                                                                                color: const Color(0xFF141414).withOpacity(0.5),
                                                                                fontSize: 15,
                                                                                fontWeight: FontWeight.normal,
                                                                              ),
                                                                              border: OutlineInputBorder(
                                                                                borderRadius: BorderRadius.circular(10),
                                                                                borderSide: const BorderSide(color: Color(0xFF707070), width: 1.5),
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
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            50,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            150,
                                                                        child:
                                                                            TextFormField(
                                                                          initialValue: cart
                                                                              .totalAmount
                                                                              .toStringAsFixed(0),
                                                                          readOnly:
                                                                              true,
                                                                          textInputAction:
                                                                              TextInputAction.next,
                                                                          cursorColor:
                                                                              const Color(0xFF141414),
                                                                          style:
                                                                              kAppBarTextStyle,
                                                                          keyboardType:
                                                                              TextInputType.name,
                                                                          decoration:
                                                                              InputDecoration(
                                                                            contentPadding:
                                                                                const EdgeInsets.symmetric(
                                                                              vertical: 20,
                                                                              horizontal: 20,
                                                                            ),
                                                                            filled:
                                                                                true,
                                                                            fillColor:
                                                                                const Color(0xFFFFFFFF),
                                                                            hintText:
                                                                                'Total Amount',
                                                                            hintStyle:
                                                                                TextStyle(
                                                                              color: const Color(0xFF141414).withOpacity(0.5),
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.normal,
                                                                            ),
                                                                            border:
                                                                                OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              borderSide: const BorderSide(color: Color(0xFF707070), width: 1.5),
                                                                            ),
                                                                            focusedBorder:
                                                                                OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              borderSide: const BorderSide(
                                                                                color: Color(0xFF141414),
                                                                                width: 1.5,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 25,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 600,
                                                                    child: TextFormField(
                                                                        controller: _promoCodeController,
                                                                        textInputAction: TextInputAction.next,
                                                                        cursorColor: const Color(0xFF141414),
                                                                        style: kAppBarTextStyle,
                                                                        keyboardType: TextInputType.name,
                                                                        decoration: InputDecoration(
                                                                          contentPadding:
                                                                              const EdgeInsets.symmetric(
                                                                            vertical:
                                                                                20,
                                                                            horizontal:
                                                                                20,
                                                                          ),
                                                                          filled:
                                                                              true,
                                                                          fillColor:
                                                                              const Color(0xFFFFFFFF),
                                                                          hintText:
                                                                              'Promo Code',
                                                                          hintStyle:
                                                                              TextStyle(
                                                                            color:
                                                                                const Color(0xFF141414).withOpacity(0.5),
                                                                            fontSize:
                                                                                15,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                          ),
                                                                          border:
                                                                              OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                            borderSide:
                                                                                const BorderSide(color: Color(0xFF707070), width: 1.5),
                                                                          ),
                                                                          focusedBorder:
                                                                              OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                            borderSide:
                                                                                const BorderSide(
                                                                              color: Color(0xFF141414),
                                                                              width: 1.5,
                                                                            ),
                                                                          ),
                                                                        )),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 25,
                                                                  ),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      SizedBox(
                                                                        width:
                                                                            600,
                                                                        child:
                                                                            TextFormField(
                                                                          controller:
                                                                              _addressController,
                                                                          textInputAction:
                                                                              TextInputAction.done,
                                                                          maxLines:
                                                                              5,
                                                                          cursorColor:
                                                                              const Color(0xFF141414),
                                                                          style:
                                                                              kAppBarTextStyle,
                                                                          keyboardType:
                                                                              TextInputType.streetAddress,
                                                                          decoration:
                                                                              InputDecoration(
                                                                            contentPadding:
                                                                                const EdgeInsets.symmetric(
                                                                              vertical: 20,
                                                                              horizontal: 20,
                                                                            ),
                                                                            filled:
                                                                                true,
                                                                            fillColor:
                                                                                const Color(0xFFFFFFFF),
                                                                            hintText:
                                                                                'Delivery Address',
                                                                            hintStyle:
                                                                                TextStyle(
                                                                              color: const Color(0xFF141414).withOpacity(0.5),
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.normal,
                                                                            ),
                                                                            border:
                                                                                OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              borderSide: const BorderSide(color: Color(0xFF707070), width: 1.5),
                                                                            ),
                                                                            focusedBorder:
                                                                                OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              borderSide: const BorderSide(
                                                                                color: Color(0xFF141414),
                                                                                width: 1.5,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 100,
                                                                  ),
                                                                  ElevatedButton(
                                                                    onPressed:
                                                                        () async {
                                                                      final ref =
                                                                          generateRef();
                                                                      final discount =
                                                                          (cart.totalAmount *
                                                                              0.85);
                                                                      final amount = _promoCodeController.text ==
                                                                              'WBZIL15'
                                                                          ? discount
                                                                          : cart
                                                                              .totalAmount;
                                                                      if (_formKey[0].currentState!.validate() &&
                                                                          _formKey[1]
                                                                              .currentState!
                                                                              .validate() &&
                                                                          _formKey[2]
                                                                              .currentState!
                                                                              .validate() &&
                                                                          _formKey[3]
                                                                              .currentState!
                                                                              .validate()) {
                                                                        await PaystackPopup
                                                                            .openPaystackPopup(
                                                                          email:
                                                                              _emailController.text,
                                                                          amount:
                                                                              (amount * 100).toString(),
                                                                          ref:
                                                                              ref,
                                                                          onClosed:
                                                                              () {
                                                                            debugPrint('Could\'nt finish payment');
                                                                          },
                                                                          onSuccess:
                                                                              () {
                                                                            debugPrint('successful payment');
                                                                            storeData(
                                                                              _firstNameController.text,
                                                                              _lastNameController.text,
                                                                              _emailController.text,
                                                                              _phoneController.text,
                                                                              _promoCodeController.text,
                                                                              cart.totalAmount.toString(),
                                                                              _addressController.text,
                                                                              ref,
                                                                              cart.items.values.map((item) => item.product.imageUrl[0]).toList(),
                                                                              cart.items.values.map((item) => item.product.productName).toList(),
                                                                              cart.items.values.map((item) => item.product.productPrice).toList(),
                                                                              cart.items.values.map((item) => item.quantity.toString()).toList(),
                                                                              DateTime.now(),
                                                                            );
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                        );
                                                                      }
                                                                    },
                                                                    style: ButtonStyle(
                                                                        backgroundColor:
                                                                            MaterialStateProperty.all(const Color(
                                                                                0xFF141414)),
                                                                        fixedSize: MaterialStateProperty.all(const Size(
                                                                            600,
                                                                            50))),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              20),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          'Pay Now',
                                                                          style: kAppBarTextStyle.copyWith(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.w500),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 50,
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      });
                                                },
                                                style: TextButton.styleFrom(
                                                  backgroundColor:
                                                      const Color(0xFF141414),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 25,
                                                      vertical: 5),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Yes',
                                                    style: kAppBarTextStyle
                                                        .copyWith(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const SignIn(),
                                                      ));
                                                },
                                                style: TextButton.styleFrom(
                                                  backgroundColor:
                                                      const Color(0xFF141414),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 25,
                                                      vertical: 5),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'No',
                                                    style: kAppBarTextStyle
                                                        .copyWith(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    });
                          },
                          title: 'Checkout',
                          width: 150,
                          height: 50,
                          style: kLargeButtonStyle,
                        ),
                      ],
                    )
                  : Center(
                      child: Text(
                        'Your cart is empty',
                        style: kAppBarTextStyle.copyWith(
                            fontWeight: FontWeight.w500),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
