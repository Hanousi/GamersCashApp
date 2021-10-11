import 'package:flutter/material.dart';
import 'package:shopping_app/feature/discover/model/product.dart';
import 'package:shopping_app/resources/R.dart';

class CardProduct extends StatelessWidget {
  final Product product;
  final Function onTapCard;

  const CardProduct({Key key, @required this.product, this.onTapCard})
      : super(key: key);

  Color _getColor(String productType) {
    switch (productType) {
      case 'PC':
        return Colors.black;
      case 'PlayStation':
        return Colors.blueAccent;
      case 'Xbox':
        return Colors.green;
      case 'Nintendo':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTapCard,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            width: width * 0.6,
            height: height * 0.4,
            decoration: BoxDecoration(
                color: _getColor(product.productType),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child:Text(
                        product.productType ?? '',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                            fontSize: 18),
                      )),
                      Align(
                        alignment: Alignment.topRight,
                        child: Text('${product.price.toString()} JD',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                fontSize: 18)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    product.title,
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 20,
            bottom: 12,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                  width: width * 0.55,
                  height: height * 0.27,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image:
                              NetworkImage(product.images[0].originalSource)),
                      borderRadius: BorderRadius.all(Radius.circular(12.0)))),
            ),
          )
        ],
      ),
    );
  }
}
