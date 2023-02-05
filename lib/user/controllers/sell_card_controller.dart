import 'package:get/get.dart';


class SellCardController extends GetxController
{

  RxInt _qtyCard = 1.obs;


  int get qty => _qtyCard.value;

  setQtyCard(int qtyOfCard){
    _qtyCard.value = qtyOfCard;
  }


}


