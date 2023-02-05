import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';

import '../styles/text_styles.dart';

class PaymentTypesField extends StatefulWidget {
  const PaymentTypesField({super.key});

  @override
  State<PaymentTypesField> createState() => _PaymentTypesFieldState();
}

class _PaymentTypesFieldState extends State<PaymentTypesField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          SmartSelect<String>.single(
            title: 'Formas de Pagamento',
            selectedValue: '',
            modalType: S2ModalType.bottomSheet,
            onChange: (value) {},
            tileBuilder: (context, state) {
              return InkWell(
                onTap: state.showModal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            state.selected.title ?? 'Formas de pagamento',
                            style: context.textStyles.medium.copyWith(fontSize: 18),
                          ),
                          const Icon(Icons.arrow_drop_down_circle_outlined)
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            choiceItems: S2Choice.listFrom<String, Map<String, String>>(
              source: [
                {'value': 'VA', 'title': 'Vale Alimentação'},
                {'value': 'CC', 'title': 'Cartão de Crédito'},
                {'value': 'CD', 'title': 'Cartão de Débito'},
                {'value': 'PIX', 'title': 'PIX'},
              ],
              title: (index, item) => item['title'] ?? '',
              value: (index, item) => item['value'] ?? '',
              group: (index, item) => 'Selecione uma forma de pagamento',
            ),
            choiceType: S2ChoiceType.radios,
            choiceGrouped: true,
            modalFilter: false,
            placeholder: '',
            groupCounter: false,
          )
        ],
      ),
    );
  }
}
