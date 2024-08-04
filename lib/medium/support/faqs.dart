import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../Screen.dart';
import '../../constants.dart';
import '../../custom_model.dart';

class MidFAQs extends StatefulWidget {
  const MidFAQs({Key? key}) : super(key: key);

  @override
  State<MidFAQs> createState() => _MidFAQsState();
}

class _MidFAQsState extends State<MidFAQs> {
  static const IconData copyright =
      IconData(0xe198, fontFamily: 'MaterialIcons');
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
                  'FAQs',
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Here are some frequently asked questions (FAQs):',
                    textAlign: TextAlign.left,
                    style:
                        kAppBarTextStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'How do I know which wig to choose?',
                    textAlign: TextAlign.left,
                    style:
                        kAppBarTextStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'We offer a wide variety of wigs in different styles, colors, lengths, and textures to suit your preferences and needs. If you need help choosing the perfect wig, our team of experts is always available to assist you. You can also check our online wig guide for more information.',
                    textAlign: TextAlign.left,
                    style: kAppBarTextStyle,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Can I wear my wig while swimming?',
                    textAlign: TextAlign.left,
                    style:
                        kAppBarTextStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'It is not recommended to wear your wig while swimming as chlorine and saltwater can damage the fibers. However, if you must swim with your wig, wear a swim cap or cover your wig with a scarf to protect it.',
                    textAlign: TextAlign.left,
                    style: kAppBarTextStyle,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'How often should I clean my wig?',
                    textAlign: TextAlign.left,
                    style:
                        kAppBarTextStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'It is recommended to clean your wig at least once a week, depending on how often you wear it. If you use a lot of styling products or live in a humid climate, you may need to clean it more frequently.',
                    textAlign: TextAlign.left,
                    style: kAppBarTextStyle,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Can I heat style my wig?',
                    textAlign: TextAlign.left,
                    style:
                        kAppBarTextStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Synthetic wigs cannot be heat styled as they can melt, but human hair wigs can be heat styled with a low to medium heat setting. However, we recommend avoiding heat styling whenever possible to prolong the life of your wig.',
                    textAlign: TextAlign.left,
                    style: kAppBarTextStyle,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'How do I store my wig when I am not wearing it?',
                    textAlign: TextAlign.left,
                    style:
                        kAppBarTextStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'We recommend storing your wig on a wig stand or mannequin to maintain its shape and prevent tangling. Keep your wig away from direct sunlight, heat sources, and high humidity.',
                    textAlign: TextAlign.left,
                    style: kAppBarTextStyle,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'How long will my wig last?',
                    textAlign: TextAlign.left,
                    style:
                        kAppBarTextStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'The lifespan of your wig depends on several factors, including how often you wear it, how well you maintain it, and the quality of the wig. With proper care, synthetic wigs can last up to six months, while human hair wigs can last up to a year or more.',
                    textAlign: TextAlign.left,
                    style: kAppBarTextStyle,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'What is the difference between synthetic and human hair wigs?',
                    textAlign: TextAlign.left,
                    style:
                        kAppBarTextStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    ' Synthetic wigs are made from synthetic fibers, while human hair wigs are made from real human hair. Human hair wigs offer a more natural look and can be heat styled, while synthetic wigs are more affordable and require less maintenance.',
                    textAlign: TextAlign.left,
                    style: kAppBarTextStyle,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'If you have any other questions or concerns, please do not hesitate to contact us.',
                    textAlign: TextAlign.left,
                    style: kAppBarTextStyle,
                  ),
                ],
              ),
            ),
            Container(
              width: 300,
              height: 200,
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
                            onTap: () {},
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
                              if (_formKey.currentState!.validate()) {
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
