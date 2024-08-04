import 'package:flutter/material.dart';
import 'package:untitled1/large/Screens.dart';
import 'package:untitled1/large/curly_collection.dart';
import 'package:untitled1/large/login_page.dart';
import 'package:untitled1/large/order_screen.dart';
import 'package:untitled1/large/our_company/about_us.dart';
import 'package:untitled1/large/our_company/hair_guide_page.dart';
import 'package:untitled1/large/our_company/location.dart';
import 'package:untitled1/large/product_detail_page.dart';
import 'package:untitled1/large/reset_password.dart';
import 'package:untitled1/large/search_page.dart';
import 'package:untitled1/large/signup_page.dart';
import 'package:untitled1/large/straight_collection.dart';
import 'package:untitled1/large/support/contact_us.dart';
import 'package:untitled1/large/support/faqs.dart';
import 'package:untitled1/large/support/order_status.dart';
import 'package:untitled1/large/support/payment_options.dart';
import 'package:untitled1/large/support/returns.dart';
import 'package:untitled1/large/support/shipping_delivery.dart';
import 'package:untitled1/large/wavy_collection.dart';
import 'package:untitled1/medium/curly_collection.dart';
import 'package:untitled1/medium/login_page.dart';
import 'package:untitled1/medium/order_screen.dart';
import 'package:untitled1/medium/our_company/about_us.dart';
import 'package:untitled1/medium/our_company/hair_guide_page.dart';
import 'package:untitled1/medium/our_company/location.dart';
import 'package:untitled1/medium/product_detail_page.dart';
import 'package:untitled1/medium/search_page.dart';
import 'package:untitled1/medium/signup_page.dart';
import 'package:untitled1/medium/straight_collection.dart';
import 'package:untitled1/medium/support/contact_us.dart';
import 'package:untitled1/medium/support/faqs.dart';
import 'package:untitled1/medium/support/order_status.dart';
import 'package:untitled1/medium/support/returns.dart';
import 'package:untitled1/medium/support/shipping_delivery.dart';
import 'package:untitled1/medium/wavy_collection.dart';
import 'package:untitled1/small/Cart_page.dart';
import 'package:untitled1/small/Screens.dart';
import 'package:untitled1/small/best_seller_catalog.dart';
import 'package:untitled1/small/curly_collection.dart';
import 'package:untitled1/small/login_page.dart';
import 'package:untitled1/small/new_arrival_catalog.dart';
import 'package:untitled1/small/order_screen.dart';
import 'package:untitled1/small/our_company/about_us.dart';
import 'package:untitled1/small/our_company/hair_guide_page.dart';
import 'package:untitled1/small/our_company/location.dart';
import 'package:untitled1/small/product_detail_page.dart';
import 'package:untitled1/small/reset_password.dart';
import 'package:untitled1/small/search_page.dart';
import 'package:untitled1/small/shop_catalog.dart';
import 'package:untitled1/small/signup_page.dart';
import 'package:untitled1/small/small_screen.dart';
import 'package:untitled1/small/straight_collection.dart';
import 'package:untitled1/small/support/contact_us.dart';
import 'package:untitled1/small/support/faqs.dart';
import 'package:untitled1/small/support/order_status.dart';
import 'package:untitled1/small/support/payment_options.dart';
import 'package:untitled1/small/support/returns.dart';
import 'package:untitled1/small/support/shipping_delivery.dart';
import 'package:untitled1/small/wavy_collection.dart';

import 'custom_model.dart';
import 'large/Cart_page.dart';
import 'large/best_seller_catalog.dart';
import 'large/large_screen.dart';
import 'large/new_arrival_catalog.dart';
import 'large/shop_catalog.dart';
import 'medium/Cart_page.dart';
import 'medium/Screens.dart';
import 'medium/best_seller_catalog.dart';
import 'medium/medium_screen.dart';
import 'medium/new_arrival_catalog.dart';
import 'medium/reset_password.dart';
import 'medium/shop_catalog.dart';
import 'medium/support/payment_options.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const LargeScreen();
        } else if (constraints.maxWidth > 800) {
          return const MediumScreen();
        } else {
          return const SmallScreen();
        }
      },
    );
  }
}

class Shop extends StatefulWidget {
  const Shop({Key? key}) : super(key: key);

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const ShopCatalog();
        } else if (constraints.maxWidth > 800) {
          return const MidShopCatalog();
        } else {
          return const SmallShopCatalog();
        }
      },
    );
  }
}

class NewArrivals extends StatelessWidget {
  const NewArrivals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const NewArrival();
        } else if (constraints.maxWidth > 800) {
          return const MidNewArrival();
        } else {
          return const SmallNewArrival();
        }
      },
    );
  }
}

class BestSeller extends StatelessWidget {
  const BestSeller({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const BestSellers();
        } else if (constraints.maxWidth > 800) {
          return const MidBestSellers();
        } else {
          return const SmallBestSellers();
        }
      },
    );
  }
}

class Carts extends StatelessWidget {
  const Carts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const CartPage();
        } else if (constraints.maxWidth > 800) {
          return const MidCartPage();
        } else {
          return const SmallCartPage();
        }
      },
    );
  }
}

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const AboutUs();
        } else if (constraints.maxWidth > 800) {
          return const MidAboutUs();
        } else {
          return const SmallAboutUs();
        }
      },
    );
  }
}

class Locations extends StatelessWidget {
  const Locations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const Location();
        } else if (constraints.maxWidth > 800) {
          return const MidLocation();
        } else {
          return const SmallLocation();
        }
      },
    );
  }
}

class HairCare extends StatelessWidget {
  const HairCare({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const HairCareGuide();
        } else if (constraints.maxWidth > 800) {
          return const MidHairCareGuide();
        } else {
          return const SmallHairCareGuide();
        }
      },
    );
  }
}

class CurlyWigs extends StatelessWidget {
  const CurlyWigs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const CurlyScreen();
        } else if (constraints.maxWidth > 800) {
          return const MidCurlyScreen();
        } else {
          return const SmallCurlyScreen();
        }
      },
    );
  }
}

class StraightWigs extends StatelessWidget {
  const StraightWigs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const StraightScreen();
        } else if (constraints.maxWidth > 800) {
          return const MidStraightScreen();
        } else {
          return const SmallStraightScreen();
        }
      },
    );
  }
}

class WavyWigs extends StatelessWidget {
  const WavyWigs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const WavyScreen();
        } else if (constraints.maxWidth > 800) {
          return const MidWavyScreen();
        } else {
          return const SmallWavyScreen();
        }
      },
    );
  }
}

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const Login();
        } else if (constraints.maxWidth > 800) {
          return const MidLogin();
        } else {
          return const SmallLogin();
        }
      },
    );
  }
}

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const SignUpPage();
        } else if (constraints.maxWidth > 800) {
          return const MidSignUpPage();
        } else {
          return const SmallSignUpPage();
        }
      },
    );
  }
}

class Reset extends StatelessWidget {
  const Reset({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const ResetPassword();
        } else if (constraints.maxWidth > 800) {
          return const MidResetPassword();
        } else {
          return const SmallResetPassword();
        }
      },
    );
  }
}

class ProductInfo extends StatefulWidget {
  final Product product;

  const ProductInfo({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return ProductDetails(product: widget.product);
        } else if (constraints.maxWidth > 800) {
          return MidProductDetails(product: widget.product);
        } else {
          return SmallProductDetails(product: widget.product);
        }
      },
    );
  }
}

class Search extends StatefulWidget {
  final List<Product> searchResults;

  const Search({Key? key, required this.searchResults}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return SearchScreen(searchResults: widget.searchResults);
        } else if (constraints.maxWidth > 800) {
          return MediumSearchScreen(searchResults: widget.searchResults);
        } else {
          return SmallSearchScreen(searchResults: widget.searchResults);
        }
      },
    );
  }
}

class Orders extends StatelessWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const MyOrders();
        } else if (constraints.maxWidth > 800) {
          return const MidMyOrders();
        } else {
          return const SmallMyOrders();
        }
      },
    );
  }
}

class Contacts extends StatelessWidget {
  const Contacts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const ContactUs();
        } else if (constraints.maxWidth > 800) {
          return const MidContactUs();
        } else {
          return const SmallContactUs();
        }
      },
    );
  }
}

class Faqs extends StatelessWidget {
  const Faqs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const FAQs();
        } else if (constraints.maxWidth > 800) {
          return const MidFAQs();
        } else {
          return const SmallFAQs();
        }
      },
    );
  }
}

class OrderDetails extends StatelessWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const OrderStatus();
        } else if (constraints.maxWidth > 800) {
          return const MidOrderStatus();
        } else {
          return const SmallOrderStatus();
        }
      },
    );
  }
}

class Payment extends StatelessWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const PaymentOptions();
        } else if (constraints.maxWidth > 800) {
          return const MidPaymentOptions();
        } else {
          return const SmallPaymentOptions();
        }
      },
    );
  }
}

class Return extends StatelessWidget {
  const Return({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const Returns();
        } else if (constraints.maxWidth > 800) {
          return const MidReturns();
        } else {
          return const SmallReturns();
        }
      },
    );
  }
}

class Shipping extends StatelessWidget {
  const Shipping({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const ShippingandDelivery();
        } else if (constraints.maxWidth > 800) {
          return const MidShippingandDelivery();
        } else {
          return const SmallShippingandDelivery();
        }
      },
    );
  }
}

class Featured extends StatelessWidget {
  const Featured({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const FeaturedScreen();
        } else if (constraints.maxWidth > 800) {
          return const MidFeaturedScreen();
        } else {
          return const SmallFeaturedScreen();
        }
      },
    );
  }
}

class BestSelling extends StatelessWidget {
  const BestSelling({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const BestSellingScreen();
        } else if (constraints.maxWidth > 800) {
          return const MidBestSellingScreen();
        } else {
          return const SmallBestSellingScreen();
        }
      },
    );
  }
}

class HighPrice extends StatelessWidget {
  const HighPrice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const HighPriceScreen();
        } else if (constraints.maxWidth > 800) {
          return const MidHighPriceScreen();
        } else {
          return const SmallHighPriceScreen();
        }
      },
    );
  }
}

class LowPrice extends StatelessWidget {
  const LowPrice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const LowPriceScreen();
        } else if (constraints.maxWidth > 800) {
          return const MidLowPriceScreen();
        } else {
          return const SmallLowPriceScreen();
        }
      },
    );
  }
}

class Curly extends StatelessWidget {
  const Curly({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const CurlyCollection();
        } else if (constraints.maxWidth > 800) {
          return const MidCurlyCollection();
        } else {
          return const SmallCurlyCollection();
        }
      },
    );
  }
}

class Straight extends StatelessWidget {
  const Straight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const StraightCollection();
        } else if (constraints.maxWidth > 800) {
          return const MidStraightCollection();
        } else {
          return const SmallStraightCollection();
        }
      },
    );
  }
}

class Wavy extends StatelessWidget {
  const Wavy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const WavyCollection();
        } else if (constraints.maxWidth > 800) {
          return const MidWavyCollection();
        } else {
          return const SmallWavyCollection();
        }
      },
    );
  }
}

class CartWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartWidget({Key? key, required this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return CartItemWidget(cartItem: cartItem);
        } else if (constraints.maxWidth > 800) {
          return MidCartItemWidget(cartItem: cartItem);
        } else {
          return SmallCartItemWidget(cartItem: cartItem);
        }
      },
    );
  }
}

class Review extends StatelessWidget {
  final String productID;

  const Review({Key? key, required this.productID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return ReviewPage(productID: productID);
        } else if (constraints.maxWidth > 800) {
          return MidReviewPage(productID: productID);
        } else {
          return SmallReviewPage(productID: productID);
        }
      },
    );
  }
}

class Question extends StatelessWidget {
  final String productID;

  const Question({Key? key, required this.productID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return QuestionPage(productID: productID);
        } else if (constraints.maxWidth > 800) {
          return MidQuestionPage(productID: productID);
        } else {
          return SmallQuestionPage(productID: productID);
        }
      },
    );
  }
}
