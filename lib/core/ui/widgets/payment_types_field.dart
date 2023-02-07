import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';

import '../../../models/payment_type_model.dart';
import '../styles/text_styles.dart';

class PaymentTypesField extends StatefulWidget {
  final ValueChanged<int> valueChanged;
  final List<PaymentTypeModel> paymentsType;
  final bool valid;

  const PaymentTypesField(
      {super.key,
      required this.paymentsType,
      required this.valueChanged,
      required this.valid});

  @override
  State<PaymentTypesField> createState() => _PaymentTypesFieldState();
}

class _PaymentTypesFieldState extends State<PaymentTypesField> {
  String selectedTitle = 'Selecione a forma de Pagamento';

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      const SizedBox(height: 10),
      SmartSelect<String>.single(
        title: selectedTitle,
        selectedValue: selectedTitle,
        modalType: S2ModalType.bottomSheet,
        onChange: (selected) {
          widget.valueChanged(int.parse(selected.value));
          selectedTitle = selected.title!;
        },
        choiceItems: S2Choice.listFrom<String, Map<String, String>>(
          source: widget.paymentsType
              .map((payment) =>
                  {'value': payment.id.toString(), 'title': payment.name})
              .toList(),
          value: (index, item) => item['value']!,
          title: (index, item) => item['title']!,
          group: (index, item) => '',
        ),
        choiceType: S2ChoiceType.radios,
        choiceGrouped: true,
        modalFilter: false,
        placeholder: '',
        groupCounter: false,
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
                        selectedTitle,
                        style: (selectedTitle ==
                                'Selecione a forma de Pagamento')
                            ? context.textStyles.medium
                                .copyWith(fontSize: 18, color: Colors.red)
                            : context.textStyles.medium.copyWith(fontSize: 18),
                      ),
                      const Icon(Icons.arrow_drop_down_circle_outlined)
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      )
    ]);
  }
}
