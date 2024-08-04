import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../Screen.dart';
import '../../constants.dart';
import '../../custom_model.dart';

class MidOrderStatus extends StatefulWidget {
  const MidOrderStatus({Key? key}) : super(key: key);

  @override
  State<MidOrderStatus> createState() => _MidOrderStatusState();
}

class _MidOrderStatusState extends State<MidOrderStatus> {
  static const IconData copyright =
      IconData(0xe198, fontFamily: 'MaterialIcons');

  final _emailController = TextEditingController();
  final _orderNumberController = TextEditingController();
  final List<GlobalKey<FormState>> _formKey = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

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

  storeData(
    String orderNumber,
    String email,
    DateTime now,
  ) {
    FirebaseFirestore.instance.collection('Order Status').add({
      'Order Number': orderNumber,
      'Email': email,
      'uid': _auth.currentUser?.uid,
      'time-stamp': now,
    }).then((value) {
      if (kDebugMode) {
        print(value.id);
      }
    });
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

  void clearField() {
    _orderNumberController.clear();
    _emailController.clear();
  }

  @override
  void initState() {
    _getUserData();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _orderNumberController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            padding: EdgeInsets.only(left: 40, top: 10, right: 20),
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
                  width: 20,
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
                  width: 20,
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
            padding: const EdgeInsets.only(left: 50, top: 15, bottom: 10),
            child: SizedBox(
              width: 250,
              child: TextField(
                textInputAction: TextInputAction.search,
                cursorColor: const Color(0xFF141414),
                style: kAppBarTextStyle,
                decoration: searchTextField,
                onSubmitted: (value) {
                  mediumSearchProducts(value, context);
                },
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 40),
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
                          maxWidth: 120,
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
                              style: kAppBarTextStyle.copyWith(fontSize: 12),
                            ),
                          ),
                          PopupMenuItem(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Text(
                              'Sign out',
                              style: kAppBarTextStyle.copyWith(fontSize: 12),
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
                  image: AssetImage('images/main.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Text(
                  'ORDER STATUS',
                  style: kCollectionText,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
              child: Column(
                children: [
                  Text(
                    'View or Manage Your Order',
                    style: kCollectionText.copyWith(
                      color: const Color(0xFF141414),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 400,
                    child: Text(
                      'To check the status of your order, please enter your order number and your email address.',
                      style: kAppBarTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 400,
                    child: TextFormField(
                      controller: _orderNumberController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      cursorColor: const Color(0xFF141414),
                      style: kAppBarTextStyle,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 20,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFFFFFFF),
                        hintText: 'Order Number*',
                        hintStyle: TextStyle(
                          color: const Color(0xFF141414).withOpacity(0.2),
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: const Color(0xFF707070).withOpacity(0.3),
                              width: 1.5),
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
                    height: 20,
                  ),
                  Form(
                    key: _formKey[0],
                    child: SizedBox(
                      width: 400,
                      child: TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          RegExp regex =
                              RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

                          if (_emailController.value.text.isEmpty) {
                            return 'Enter your email';
                          } else if (!(_emailController.value.text
                              .contains(regex))) {
                            return 'Enter a valid email';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        cursorColor: const Color(0xFF141414),
                        style: kAppBarTextStyle,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 20,
                          ),
                          filled: true,
                          fillColor: const Color(0xFFFFFFFF),
                          hintText: 'Email*',
                          hintStyle: TextStyle(
                            color: const Color(0xFF141414).withOpacity(0.2),
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: const Color(0xFF707070).withOpacity(0.3),
                                width: 1.5),
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
                    height: 50,
                  ),

                  // sign in button
                  TextButton(
                    onPressed: () {
                      if (_formKey[0].currentState!.validate()) {
                        storeData(
                          _orderNumberController.text,
                          _emailController.text,
                          DateTime.now(),
                        );
                        clearField();
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  'Check your email for your order status.',
                                  style: kAppBarTextStyle,
                                  textAlign: TextAlign.center,
                                ),
                                titlePadding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 50),
                              );
                            });
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF141414),
                      shadowColor: const Color(0xFF141414).withOpacity(0.3),
                      fixedSize: const Size(400, 50),
                    ),
                    child: Text(
                      'Submit',
                      style: kAppBarTextStyle.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                left: 50,
                right: 50,
                top: 50,
                bottom: 100,
              ),
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
                              fontSize: 15,
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
                                color: Colors.white,
                                fontSize: 12,
                              ),
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
                              'Hair care guide',
                              style: kAppBarTextStyle.copyWith(
                                color: Colors.white,
                                fontSize: 12,
                              ),
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
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Partner program',
                              style: kAppBarTextStyle.copyWith(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Text(
                            'Supports',
                            style: kLargeHeaderText.copyWith(
                              color: const Color(0xFF707070),
                              fontSize: 15,
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
                                color: Colors.white,
                                fontSize: 12,
                              ),
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
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Order Status',
                              style: kAppBarTextStyle.copyWith(
                                color: Colors.white,
                                fontSize: 12,
                              ),
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
                                color: Colors.white,
                                fontSize: 12,
                              ),
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
                                color: Colors.white,
                                fontSize: 12,
                              ),
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
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
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
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'Sign up for all the latest updates and deals!',
                            style: kAppBarTextStyle.copyWith(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Form(
                            key: _formKey[1],
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
                                    fontSize: 12, color: Colors.white),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 20,
                                  ),
                                  hintText: 'Enter your email',
                                  hintStyle: const TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12,
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
                          TextButton(
                            onPressed: () {
                              if (_formKey[1].currentState!.validate()) {
                                saveData(_emailController.text, DateTime.now());
                                _emailController.clear();
                              }
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              fixedSize: const Size(120, 40),
                            ),
                            child: Text(
                              'Subscribe',
                              style: kAppBarTextStyle.copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            ),
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
