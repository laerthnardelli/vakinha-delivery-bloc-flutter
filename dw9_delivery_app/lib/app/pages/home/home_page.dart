import 'package:dw9_delivery_app/app/core/ui/base_state/base_state.dart';
import 'package:dw9_delivery_app/app/pages/home/home_controller.dart';
import 'package:dw9_delivery_app/app/pages/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:shared_preferences/shared_preferences.dart';

import '../../core/ui/widgets/delivery_appbar.dart';
import 'widgets/delivery_product_tile.dart';
import 'widgets/shopping_bag_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeController> {
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     context.read<HomeController>().loadProducts();
  //   });
  // }

  @override
  void onReady() {
    // SharedPreferences.getInstance().then((value) => value.clear());
    controller.loadProducts();
    super.onReady();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppbar(),
      // floatingActionButton: FloatingActionButton(onPressed: () async {
      //   // showLoader();
      //   // await Future.delayed(const Duration(seconds: 2));
      //   //hideLoader();
      //   showError('Erro ao criar qualquer coisa!');
      //   await Future.delayed(const Duration(seconds: 2));
      //   showInfo('Erro ao criar qualquer coisa!');
      //   await Future.delayed(const Duration(seconds: 2));
      //   showSuccess('Erro ao criar qualquer coisa!');
      // }),
      body: BlocConsumer<HomeController, HomeState>(
        listener: (context, state) {
          state.status.matchAny(
              any: () => hideLoader(),
              loading: () => showLoader(),
              error: () {
                hideLoader();
                showError(state.errorMessage ?? 'Erro não informado');
              });
        },
        buildWhen: (previous, current) => current.status.matchAny(
          any: () => false,
          initial: () => true,
          loaded: () => true,
        ),
        builder: (context, state) {
          return Column(
            children: [
              //Text(state.shoppingBag.length.toString()),
              Expanded(
                child: ListView.builder(
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    final product = state.products[index];
                    final orders = state.shoppingBag
                        .where((order) => order.product == product);
                    return DeliveryProductTile(
                      product: product,
                      orderProduct: orders.isNotEmpty ? orders.first : null,
                    );
                  },
                ),
              ),
              Visibility(
                visible: state.shoppingBag.isNotEmpty,
                child: ShoppingBagWidget(bag: state.shoppingBag),
              ),
            ],
          );
        },
      ),
    );
  }
}
