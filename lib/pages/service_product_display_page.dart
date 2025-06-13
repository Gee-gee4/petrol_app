import 'package:flutter/material.dart';
import 'package:petrol_app/model/cart_item_model.dart';
import 'package:petrol_app/modules/cart_module.dart';
import 'package:petrol_app/pages/transaction_page.dart';
import 'package:petrol_app/widgets/pump_card.dart';
import 'package:petrol_app/widgets/reusable_widgets.dart';

class ServiceProductDisplayPage<T> extends StatefulWidget {
  const ServiceProductDisplayPage({
    super.key,
    required this.appBarTitle,
    required this.imagePath,
    required this.loadItems,
    required this.getTitle,
    required this.getPrice,
    required this.convertToCartItem,
    this.convertToCartItemModel,
  });

  final String appBarTitle;
  final String imagePath;
  final Future<List<T>> Function() loadItems;
  final String Function(T) getTitle;
  final double Function(T) getPrice;
  final CartItemModel Function(T) convertToCartItem;
  final CartItemModel Function(T)? convertToCartItemModel;

  @override
  State<ServiceProductDisplayPage<T>> createState() =>
      _ServProdDisplayPageState<T>();
}

class _ServProdDisplayPageState<T> extends State<ServiceProductDisplayPage<T>> {
  final CartModule cartModule = CartModule.instance();
  List<T> items = [];
  bool isLoading = false;
  // Function declaration instead of variable assignment
  void _handleCartChanged() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _initialize() {
    loadItems();
    cartModule.addListener(_handleCartChanged);
  }

  @override
  void dispose() {
    cartModule.removeListener(_handleCartChanged);
    super.dispose();
  }

  Future<void> loadItems() async {
    if (!mounted) return;

    setState(() => isLoading = true);

    try {
      items = await widget.loadItems();
      if (mounted) setState(() => isLoading = false);
    } catch (e) {
      if (mounted) setState(() => isLoading = false);
      // Consider adding error handling here
    }
  }

  @override
  Widget build(BuildContext context) {
    bool narrowPhone = MediaQuery.of(context).size.width < 365;

    return Scaffold(
      extendBody: true,
      backgroundColor: hexToColor('d7eaee'),
      appBar: AppBar(
        title: Text(widget.appBarTitle),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [cartIconButton(context, cartModule)],
      ),
      body: Column(
        children: [
          if (isLoading)
            LinearProgressIndicator(
              color: hexToColor('005954'),
              backgroundColor: hexToColor('9fd8e1'),
            ),
          Expanded(
            child: GridView.builder(
              itemCount: items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: narrowPhone ? .8 : .9,
              ),
              itemBuilder: (context, index) {
                final item = items[index];
                return Padding(
                  padding: EdgeInsets.all(narrowPhone ? 0 : 8),
                  child: PumpCard(
                    model: item,
                    title: widget.getTitle(item),
                    imagePath: widget.imagePath,
                    imageWidth: 50,
                    priceText: Text(
                      'Ksh: ${widget.getPrice(item).toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    buttonName: 'Add to cart',
                    cardOnTap: () {},
                    onPressed: () {
                      final cartItem =
                          widget.convertToCartItemModel != null
                              ? widget.convertToCartItemModel!(item)
                              : widget.convertToCartItem(item);
                      final isAdded = cartModule.addOrUpdateCartItem(cartItem);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isAdded ? 'Added to cart' : 'Error adding to cart!',
                          ),
                          duration: const Duration(milliseconds: 700),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor:
                              isAdded ? hexToColor('005954') : Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
