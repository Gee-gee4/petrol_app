import 'package:flutter/material.dart';
import 'package:petrol_app/model/cart_item_model.dart';
import 'package:petrol_app/model/product_model.dart';
import 'package:petrol_app/model/services_model.dart';
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

  void _showAddItemDialog() async {
    String? name;
    double? price;

    final formKey = GlobalKey<FormState>();

    await showDialog(
      barrierDismissible: false,
      context: context,
      builder:
          (_) => AlertDialog(
            backgroundColor: hexToColor('d7eaee'),
            title: Text('Add ${widget.appBarTitle}'),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? 'Enter a name'
                                : null,
                    onSaved: (value) => name = value,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Price'),
                    keyboardType: TextInputType.number,
                    validator:
                        (value) =>
                            value == null || double.tryParse(value) == null
                                ? 'Enter valid price'
                                : null,
                    onSaved: (value) => price = double.tryParse(value ?? '0'),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: hexToColor('005954')),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: hexToColor('005954'),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    Navigator.pop(context);
                    _addNewItem(name!, price!);
                  }
                },
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
    );
  }

  void _addNewItem(String name, double price) {
    final newId = DateTime.now().millisecondsSinceEpoch.toString();

    if (T == ProductModel) {
      final product = ProductModel(
        productName: name,
        productId: newId,
        productPrice: price,
        productQuantity: 1,
        productTotalPrice: price,
      );
      setState(() {
        items.add(product as T);
      });
    } else if (T == ServicesModel) {
      final service = ServicesModel(
        serviceName: name,
        serviceId: newId,
        servicePrice: price,
        serviceQuantity: 1,
        servicesTotalPrice: price,
      );
      setState(() {
        items.add(service as T);
      });
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Unsupported item type')));
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
        centerTitle: true,
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
                childAspectRatio: narrowPhone ? .75 : .88,
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
                    cardOnTap: () {
                      addVariableToCart(item);
                    },
                    onPressed: () {
                      addVariableToCart(item);
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                backgroundColor: hexToColor('005954'),
                onPressed: _showAddItemDialog,
                child: Icon(Icons.add, size: 32, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void addVariableToCart(T item) {
    final cartItem =
        widget.convertToCartItemModel != null
            ? widget.convertToCartItemModel!(item)
            : widget.convertToCartItem(item);
    final isAdded = cartModule.addOrUpdateCartItem(cartItem);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isAdded ? 'Added to cart' : 'Error adding to cart!'),
        duration: const Duration(milliseconds: 700),
        behavior: SnackBarBehavior.floating,
        backgroundColor: isAdded ? hexToColor('005954') : Colors.grey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
