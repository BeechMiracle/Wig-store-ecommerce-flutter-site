import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../Screen.dart';
import '../../constants.dart';
import '../../custom_model.dart';

class SmallShippingandDelivery extends StatefulWidget {
  const SmallShippingandDelivery({Key? key}) : super(key: key);

  @override
  State<SmallShippingandDelivery> createState() =>
      _SmallShippingandDeliveryState();
}

class _SmallShippingandDeliveryState extends State<SmallShippingandDelivery> {
  static const IconData copyright =
      IconData(0xe198, fontFamily: 'MaterialIcons');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? _firstName;
  String? _lastName;
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFE9E9E9),
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () {
            Navigator.popAndPushNamed(context, 'home');
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 8, top: 5, right: 8),
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
            padding: const EdgeInsets.only(left: 8, top: 15, bottom: 10),
            child: SizedBox(
              width: 100,
              child: TextField(
                textInputAction: TextInputAction.search,
                cursorColor: const Color(0xFF141414),
                style: kAppBarTextStyle.copyWith(fontSize: 12),
                decoration: searchTextField,
                onSubmitted: (value) {
                  smallSearchProducts(value, context);
                },
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
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
            width: 8,
          ),
          CustomIconButton(
            icon: const Icon(
              Icons.menu,
              size: 20,
            ),
            onTap: () => _scaffoldKey.currentState!.openEndDrawer(),
          ),
          const SizedBox(
            width: 24,
          ),
        ],
      ),
      endDrawer: Container(
        width: size.width / 1.5,
        color: Colors.white,
        child: Drawer(
          child: _auth.currentUser != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.close,
                                  size: 20,
                                  color: Color(0xFF141414),
                                ),
                              ),
                            ],
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 15,
                          child: Text(
                            '${_firstName != null ? _firstName![0].toUpperCase() : ""}${_lastName != null ? _lastName![0].toUpperCase() : ""}',
                            style: kAppBarTextStyle.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Shop(),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.white),
                          child: Text(
                            'Shop',
                            style: kCollectionText.copyWith(
                                color: const Color(0xFF141414),
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Carts(),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.white),
                          child: Text(
                            'Cart',
                            style: kCollectionText.copyWith(
                                color: const Color(0xFF141414),
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Orders(),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.white),
                          child: Text(
                            'My Orders',
                            style: kCollectionText.copyWith(
                                color: const Color(0xFF141414),
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const About(),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.white),
                          child: Text(
                            'About Us',
                            style: kCollectionText.copyWith(
                                color: const Color(0xFF141414),
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Locations(),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.white),
                          child: Text(
                            'Location',
                            style: kCollectionText.copyWith(
                                color: const Color(0xFF141414)),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _auth.signOut();
                            });
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: const Color(0xFF141414),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10)),
                          child: Text(
                            'Sign out',
                            style: kAppBarTextStyle.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                    Container(
                      width: 150,
                      height: 100,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/wig.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.close,
                                  size: 20,
                                  color: Color(0xFF141414),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Shop(),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.white),
                          child: Text(
                            'Shop',
                            style: kCollectionText.copyWith(
                                color: const Color(0xFF141414),
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Carts(),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.white),
                          child: Text(
                            'Cart',
                            style: kCollectionText.copyWith(
                                color: const Color(0xFF141414),
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const About(),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.white),
                          child: Text(
                            'About Us',
                            style: kCollectionText.copyWith(
                                color: const Color(0xFF141414),
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Locations(),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.white),
                          child: Text(
                            'Location',
                            style: kCollectionText.copyWith(
                                color: const Color(0xFF141414)),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignIn(),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: const Color(0xFF141414),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10)),
                          child: Text(
                            'Sign in',
                            style: kAppBarTextStyle.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                    Container(
                      width: 150,
                      height: 100,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/wig.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: size.width,
              height: size.height / 3,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/main.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Text(
                  'SHIPPING & DELIVERY',
                  style: kCollectionText,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'INFORMATION CONCERNING SHIPPING',
                    style: kCollectionText.copyWith(
                        fontSize: 15, color: const Color(0xFF141414)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'At SIMPHAIR, we strive to provide fast and reliable shipping for all of our customers. Here are the details about our shipping and delivery policies:',
                    style: kAppBarTextStyle.copyWith(fontSize: 12),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Text(
                        ' \u2022',
                        style: TextStyle(fontSize: 30),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          'We offer free standard shipping on all orders within the State',
                          style: kAppBarTextStyle.copyWith(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Text(
                        ' \u2022',
                        style: TextStyle(fontSize: 30),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          'Most orders are processed and shipped within 1-2 business days of receiving payment.',
                          style: kAppBarTextStyle.copyWith(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Text(
                        ' \u2022',
                        style: TextStyle(fontSize: 30),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          'We process and deliver orders Monday-Friday (excluding holidays). Saturday and/or Sunday deliveries may be available for some orders.',
                          style: kAppBarTextStyle.copyWith(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Text(
                        ' \u2022',
                        style: TextStyle(fontSize: 30),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          'We use a variety of shipping carriers to make sure we deliver your order as soon as possible.',
                          style: kAppBarTextStyle.copyWith(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Text(
                        ' \u2022',
                        style: TextStyle(fontSize: 30),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          'If you order multiple items, you may get multiple deliveries. We’ll send you a shipping confirmation email for each shipment, so you’ll know exactly what to expect and when to expect it.',
                          style: kAppBarTextStyle.copyWith(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Text(
                        ' \u2022',
                        style: TextStyle(fontSize: 30),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          'If you need your wig by a specific date, please contact our customer service team to inquire about expedited shipping options',
                          style: kAppBarTextStyle.copyWith(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'If you have any questions or concerns about our shipping and delivery policies, please do not hesitate to contact our customer service team. We are committed to providing you with high-quality wigs and excellent customer service.',
                    style: kAppBarTextStyle.copyWith(fontSize: 12),
                  ),
                ],
              ),
            ),
            Container(
              width: 200,
              height: 100,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/wig.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                top: 50,
                bottom: 50,
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
                            'OUR COMPANY',
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
                            height: 150,
                          ),
                          Text(
                            'SUPPORTS',
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
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const OrderDetails(),
                                ),
                              );
                            },
                            child: Text(
                              'Order status',
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
                            key: _formKey,
                            child: SizedBox(
                              width: 250,
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
                                    color: Colors.white,
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
                            width: 250,
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
                              if (_formKey.currentState!.validate()) {
                                saveData(_emailController.text, DateTime.now());
                                _emailController.clear();
                              }
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              fixedSize: const Size(100, 40),
                            ),
                            child: Text(
                              'Subscribe',
                              style: kAppBarTextStyle.copyWith(
                                  fontSize: 10, fontWeight: FontWeight.w600),
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
