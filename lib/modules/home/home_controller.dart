import 'package:get/get.dart';
import '../../models/transaction_model.dart';


class HomeController extends GetxController {
  final isLoading = true.obs;
  final balance = 9983.75.obs;
  final transactions = <TransactionModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 600));
    transactions.assignAll([
      TransactionModel(title: "Amazon", date: "Jan 20, 2024", amount: -103.68, image: 'assets/a.png'),
      TransactionModel(title: "McDonalds", date: "Jan 19, 2024", amount: -54.70, image: 'assets/mac.png'),
      TransactionModel(title: "Sarah Johnson", date: "Jan 18, 2024", amount: 150.00, image: 'assets/g.jpg'),
      TransactionModel(title: "Salary Deposit", date: "Jan 15, 2024", amount: 3500.00, image: ''),
      TransactionModel(title: "Netflix", date: "Jan 10, 2024", amount: -15.99, image: 'assets/net.png'),
      TransactionModel(title: "Amazon", date: "Jan 20, 2024", amount: -103.68, image: 'assets/a.png'),
      TransactionModel(title: "McDonalds", date: "Jan 19, 2024", amount: -54.70, image: 'assets/mac.png'),
      TransactionModel(title: "Sarah Johnson", date: "Jan 18, 2024", amount: 150.00, image: 'assets/g.jpg'),
      TransactionModel(title: "Salary Deposit", date: "Jan 15, 2024", amount: 3500.00, image: ''),
      TransactionModel(title: "Netflix", date: "Jan 10, 2024", amount: -15.99, image: 'assets/net.png'),

    ]);
    isLoading.value = false;
  }
}
