import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_zapix_ahead/secret.dart';
import 'package:gerencianet/gerencianet.dart';

class SandBoxScreen extends StatefulWidget {
  const SandBoxScreen({Key? key}) : super(key: key);

  @override
  State<SandBoxScreen> createState() => _SandBoxScreenState();
}

class _SandBoxScreenState extends State<SandBoxScreen> {
  final Map<String, dynamic> config = {
    'client_id': Secrets.client_id,
    'client_secret': Secrets.client_secret,
    'sandbox': false,
    'pix_cert': '',
    'pix_private_key': ''
  };

  late Gerencianet gerencianet;

  @override
  void initState() {
    //gerencianet = Gerencianet(config);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            pressedButton();
          },
          child: const Text("Vamos Gerencianetiar!"),
        ),
      ),
    );
  }

  pressedButton() async {
    File file = File("certificates/homologacao-406253-Dotcode-H.p12");

    config['pix_cert'] = file.readAsBytes();
    gerencianet = Gerencianet(config);

    print(gerencianet);

    // pixCreateCharge(gerencianet, "", "").then((value) {
    //   print(value);
    // });
  }

  Future<dynamic> pixCreateCharge(
      Gerencianet gn, String txId, String key) async {
    Map<String, dynamic> params = {"txid": txId};

    dynamic body = {
      "calendario": {"expiracao": 3600},
      "devedor": {"cpf": "04267484171", "nome": "Gorbadoc Oldbuck"},
      "valor": {"original": "0.01"},
      "chave": key,
      "solicitacaoPagador": "Cobrança dos serviços prestados."
    };
    return await gn.call('pixCreateCharge', params: params, body: body);
  }
}
