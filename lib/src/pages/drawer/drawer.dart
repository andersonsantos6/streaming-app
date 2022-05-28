import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            ListTile(
              leading: Icon(
                Icons.info_rounded,
                color: Theme.of(context).accentColor,
              ),
              title: Text(
                'Sobre nós',
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).accentColor,
                ),
                textAlign: TextAlign.justify,
              ),
              subtitle: const Text(
                'A VêTV é uma ONG que tem como objetivo, levar acesso a informação por meio da retransmissão de canais de TV aberta, utilizando ferramentas disponibilizadas pelas mesmas e seguindo os princípos da lei. Todo conteúdo é de total responsabilidade da produtora.\n\nPara mais informações, reclamação ou solicitação de remoção de conteúdo, entre em contato com vetv.br@gmail.com',
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.justify,
              ),
            )
          ],
        ),
      ),
    );
  }
}
