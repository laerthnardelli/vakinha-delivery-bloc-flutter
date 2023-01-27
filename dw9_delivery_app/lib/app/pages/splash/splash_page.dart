import 'package:dw9_delivery_app/app/core/config/env/env.dart';
import 'package:dw9_delivery_app/app/core/ui/helpers/size_extensions.dart';
import 'package:flutter/material.dart';

import '../../core/ui/widgets/delivery_button.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Splash Page'),
      ),
      body: Column(
        children: [
          Container(),
          DeliveryButton(
            width: 200,
            height: 200,
            label: Env.i['backend_base_url'] ?? '',
            onPressed: () {},
          ),
          Text(context.screenWidth.toString()),
          Text(context.screenHeight.toString()),
          Row(
            children: [
              Container(
                color: Colors.red,
                width: context.screenWidth * .5,
                height: 200,
              ),
              Container(
                color: Colors.blue,
                width: context.percentWidth(.5),
                height: 200,
              ),
            ],
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'text'),
          ),
        ],
      ),
    );
  }
}
