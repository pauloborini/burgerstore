import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';

import '../../../models/payment_type_model.dart';
import '../styles/text_styles.dart';

class PaymentTypesField extends StatelessWidget {
  final ValueChanged<int> valueChanged;
  final List<PaymentTypeModel> paymentsType;
  final bool valid;

  const PaymentTypesField(
      {super.key,
      required this.paymentsType,
      required this.valueChanged,
      required this.valid});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        SmartSelect<String>.single(
          title: 'Selecione a forma de Pagamento',
          selectedValue: '',
          modalType: S2ModalType.bottomSheet,
          onChange: (selected) {
            valueChanged(int.parse(selected.value));
          },
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
                          state.selected.title ??
                              'Selecione a forma de Pagamento',
                          style: (state.selected.title == null)
                              ? context.textStyles.medium
                                  .copyWith(fontSize: 18, color: Colors.red)
                              : context.textStyles.medium
                                  .copyWith(fontSize: 18),
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
            source: paymentsType
                .map((payment) =>
                    {'value': payment.id.toString(), 'title': payment.name})
                .toList(),
            title: (index, item) => item['title'] ?? '',
            value: (index, item) => item['value'] ?? '',
            group: (index, item) => '',
          ),
          choiceType: S2ChoiceType.radios,
          choiceGrouped: true,
          modalFilter: false,
          placeholder: '',
          groupCounter: false,
        )
      ],
    );
  }
}
