import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:untitled1/Screen.dart';

import '../constants.dart';
import '../custom_model.dart';

class SearchScreen extends StatefulWidget {
  final List<Product> searchResults;

  const SearchScreen({
    Key? key,
    required this.searchResults,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
            padding: const EdgeInsets.only(left: 100, top: 15, bottom: 10),
            child: Row(
              children: [
                Text(
                  'Search results..',
                  style: kAppBarTextStyle,
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 600,
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
              ],
            ),
          ),
          const SizedBox(
            width: 100,
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
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 50),
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
                              height: 300,
                              width: 300,
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
                              width: 100,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.searchResults[index].productName,
                                  style: kLargeH2text,
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
                                    itemSize: 20,
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
                                  style: kAppBarTextStyle,
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
