import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/ui.dart';
import '../../data/models/product/product_model.dart';
import '../../logic/services/formatter.dart';
import '../screens/product/product_details_screen.dart';
import 'gap_widget.dart';

class ProductListView extends StatelessWidget {
  final List<ProductModel> products;

  const ProductListView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];

        return CupertinoButton(
          onPressed: () {
            Navigator.pushNamed(context, ProductDetailsScreen.routeName,
                arguments: product);
          },
          padding: EdgeInsets.zero,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CachedNetworkImage(
                width: MediaQuery.of(context).size.width / 3,
                imageUrl: "${product.images?[0]}",
              ),

              const GapWidget(size: 5,),

              // const GapWidget(),

              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${product.title}",
                      style: TextStyles.body1,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "${product.description}",
                      style:
                          TextStyles.body2.copyWith(color: AppColors.textLight),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const GapWidget(size: -10,),
                    Row(
                      children: [
                        Text(
                          Formatter.formatPrice(product.price! ),
                          style: TextStyles.body1.copyWith(fontWeight: FontWeight.w600),
                        ),

                        const GapWidget(size: -5,),
                        Text(
                          Formatter.formatPrice(product.price! * 1.57),
                          style: TextStyles.body1.copyWith(decoration: TextDecoration.lineThrough),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              
              Icon(CupertinoIcons.right_chevron, color: AppColors.textLight)
              
            ],
          ),
        );
      }, separatorBuilder: (context, index) {
        return const Divider();
    },
    );
  }
}
