import 'package:flutter/material.dart';
import 'package:flutter_application_ngrk/core/utils/text_style.dart';
import 'package:flutter_application_ngrk/domain/entities/article.dart';

class ProductItem extends StatelessWidget {
  final Article product;
  const ProductItem({super.key, required this.product});
  static const imgUrl = 'http://192.168.246.24:5000/images';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        height: 300,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 3),
            borderRadius: BorderRadius.circular(15)),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  '$imgUrl/${product.image}',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                )),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12))),
              height: 50,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: 80,
                        child: Text(
                          product.nom,
                          style: ConstTextStyle.productItemTitleTextStyle,
                          overflow: TextOverflow.ellipsis,
                        )),
                    Text(
                      '${product.prix.toString()}DT',
                      style: ConstTextStyle.productItemTitleTextStyle,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
