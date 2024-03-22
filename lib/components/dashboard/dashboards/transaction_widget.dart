import 'package:flutter/material.dart';

class RecentTransactionsWidget extends StatelessWidget {
  final List<String> transactions;

  const RecentTransactionsWidget({Key? key, this.transactions = const []}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.payment),
            title: Text(transactions[index]),
            trailing: Icon(Icons.arrow_forward_ios),
          );
        },
      ),
    );
  }
}
