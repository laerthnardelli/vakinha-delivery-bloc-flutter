import 'package:dw9_delivery_app/app/core/ui/helpers/loader.dart';
import 'package:dw9_delivery_app/app/core/ui/helpers/messages.dart';
import 'package:dw9_delivery_app/app/pages/home/home_controller.dart';
import 'package:dw9_delivery_app/app/pages/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/ui/widgets/delivery_appbar.dart';
import 'widgets/delivery_product_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with Loader, Messages {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<HomeController>().loadProducts();
    });
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
              Expanded(
                child: ListView.builder(
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    final products = state.products[index];
                    return DeliveryProductTile(product: products
                        // ProductModel(
                        //   id: 0,
                        //   name: 'Lanche X',
                        //   description:
                        //       'Lanche acompanha pão, hambúrguer, mussarela e maionese, ',
                        //   price: 15.0,
                        //   image:
                        //       "https://assets.unileversolutions.com/recipes-v2/106684.jpg?imwidth=800",
                        // ),
                        );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
