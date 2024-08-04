import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../Screen.dart';
import '../constants.dart';
import '../custom_model.dart';

class SmallSearchScreen extends StatefulWidget {
  final List<Product> searchResults;

  const SmallSearchScreen({
    Key? key,
    required this.searchResults,
  }) : super(key: key);

  @override
  State<SmallSearchScreen> createState() => _SmallSearchScreenState();
}

class _SmallSearchScreenState extends State<SmallSearchScreen> {
  @override
  Widget build(BuildContext context) {
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
            child: Row(
              children: [
                Text(
                  'Search results..',
                  style: kAppBarTextStyle.copyWith(fontSize: 12),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 150,
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    cursorColor: const Color(0xFF141414),
                    style: kAppBarTextStyle,
                    decoration: searchTextField,
                    onSubmitted: (value) {
                      smallSearchProducts(value, context);
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 50,
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: widget.searchResults.isEmpty
            ? Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Center(
                  child: Text(
                    'No results found..',
                    style: kCollectionText.copyWith(
                        color: const Color(0xFF141414),
                        fontSize: 12,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.searchResults.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductInfo(
                                product: widget.searchResults[index]),
                          ),
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Row(
                          children: [
                            Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                  image: NetworkImage(
                                      widget.searchResults[index].imageUrl[0]),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.searchResults[index].productName,
                                  style: kLargeH2text.copyWith(fontSize: 15),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                RatingBar.builder(
                                    initialRating: double.parse(
                                      widget.searchResults[index].productRating,
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
                                const SizedBox(
                                  height: 50,
                                ),
                                Text(
                                  '#${widget.searchResults[index].productPrice}',
                                  style:
                                      kAppBarTextStyle.copyWith(fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
