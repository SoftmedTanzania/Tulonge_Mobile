import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Loader extends StatelessWidget {
  final String type;

  Loader(this.type);

  @override
  Widget build(BuildContext context) {
    // Loader section for card list
    Widget cardListLoader = Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: Column(
          children: [0, 1, 2, 3, 4, 5, 6]
              .map((_) => Padding(
                    padding: const EdgeInsets.only(bottom: 50.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 100,
                                height: 8.0,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2.0),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                width: 200,
                                height: 8.0,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2.0),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 40.0,
                                    height: 8.0,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Container(
                                    width: 40.0,
                                    height: 8.0,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Container(
                                    width: 40.0,
                                    height: 8.0,
                                    color: Colors.white,
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ))
              .toList(),
        ),
      ),
    );

    Widget basicFormLabelLoader = Container(
      width: double.infinity,
//      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: Column(
          children: [0]
              .map((_) => Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 100.0,
                            height: 8.0,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Container(
                            width: 100.0,
                            height: 8.0,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Container(
                            width: 100.0,
                            height: 8.0,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ))
              .toList(),
        ),
      ),
    );

    switch (type) {
      case 'card_list':
        return cardListLoader;
        break;
      case 'basic_form':
        return basicFormLabelLoader;
        break;
      default:
        return cardListLoader;
    }
  }
}
