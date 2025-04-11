// ignore_for_file: must_be_immutable

import 'dart:async';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:eagri_pro/core/constants/color_constants.dart';
import 'package:flutter/material.dart';


class SelectFieldWidget<T> extends StatefulWidget {
  SelectFieldWidget(
      {super.key,
      required this.items,
      this.onChanged,
      this.value,
      required this.labelText,
      this.compareFn,
      this.dropdownBuilder,
      required this.popupProps,
      this.validator,
      this.isError = false});
  final FutureOr<List<T>> Function(String, LoadProps?) items;
  final void Function(dynamic)? onChanged;
  final dynamic value;
  final String labelText;
  Widget Function(BuildContext, Object?)? dropdownBuilder;
  String Function(Object)? itemAsString;
  bool isError;
  bool Function(Object, Object)? compareFn;
  PopupProps<T> popupProps;
  final String? Function(dynamic)? validator;

  @override
  State<SelectFieldWidget> createState() => _SelectFieldWidgetState();
}

class _SelectFieldWidgetState<T> extends State<SelectFieldWidget> {
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: Colors.transparent,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: focusNode.hasFocus
            ? [
                BoxShadow(
                  color: widget.isError
                      ? Colors.red
                      : Colors.white,
                  blurRadius: 0,
                  offset: const Offset(0, 2), // Shadow position
                ),
              ]
            : null,
      ),
      child: DropdownSearch<T>(
        dropdownBuilder: widget.dropdownBuilder,
        popupProps: widget.popupProps as PopupProps<T>,
        items: widget.items as FutureOr<List<T>> Function(String, LoadProps?),
        selectedItem: widget.value,
        validator: widget.validator,
        onChanged: widget.onChanged,

        //  focusNode: focusNode,
        // hint: Text(
        //   widget.labelText,
        //   style: Theme.of(context).textTheme.bodySmall!.copyWith(
        //         color: ConstantColors.grayScale800,
        //         fontFamily: ConstantString.inter,
        //         fontWeight: FontWeight.w500,
        //       ),
        // ),
        // decoration: InputDecoration(
        //   fillColor: ConstantColors.primary,
        //   focusColor: ConstantColors.primary,
        //   //suffixIcon: widget.suffixIcon,
        //   // contentPadding: const EdgeInsets.symmetric(
        //   //   horizontal: 10.0,
        //   //   vertical: 15.0,
        //   // ),
        //   enabledBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(
        //       10,
        //     ),
        //     borderSide: BorderSide(
        //       color: !focusNode.hasFocus
        //           ? ConstantColors.grayScale200
        //           : Colors.transparent,
        //       width: 1.0,
        //     ),
        //   ),
        //   floatingLabelStyle: const TextStyle(
        //       color: ConstantColors.primary,
        //       fontWeight: FontWeight.bold,
        //       fontSize: 18),

        //   focusedBorder: OutlineInputBorder(
        //     borderSide: const BorderSide(
        //         color: ConstantColors.grayScale200, width: 0.0),
        //     borderRadius: BorderRadius.circular(10),
        //   ),
        //   contentPadding:
        //       const EdgeInsets.only(top: 8, bottom: 30, left: 12, right: 10),
        //   //floatingLabelBehavior: FloatingLabelBehavior.always,
        //   border: OutlineInputBorder(
        //     borderSide: const BorderSide(
        //         color: ConstantColors.grayScale200, width: 0.0),
        //     borderRadius: BorderRadius.circular(10),
        //   ),
        //   labelStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
        //         color: ConstantColors.grayScale800,
        //         fontFamily: ConstantString.inter,
        //         fontWeight: FontWeight.w500,
        //       ),

        //   //  hintText: widget.labelText,
        //   //labelText: widget.labelText,
        // ),
        // validator: (value) => value == null ? "Select a country" : null,
        // dropdownColor: Colors.white,
        //  value: selectedValue,
        // compareFn: widget.compareFn ?? (i1, i2) => i1 == i2,
        // itemAsString: widget.itemAsString,
        // value: widget.value,
      ),
    );
  }
}

DropDownDecoratorProps dropDownDecoratorPropsCustom(
        String label, BuildContext context) =>
    DropDownDecoratorProps(
        decoration: InputDecoration(
            label: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: ColorConstants.grayScale800,
                    // fontFamily: ConstantString.inter,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            hintText: "Rechercher",
            contentPadding: EdgeInsets.only(left: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )));

BoxConstraints constraintsSelectFieldCustom(BuildContext context) =>
    BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * 0.6,
    );

InputDecoration decorationSelectFieldCustom = InputDecoration(
  contentPadding: EdgeInsets.only(left: 10),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  labelText: "Rechercher",
  suffixIcon: Icon(
    Icons.search,
    color: ColorConstants.primaryColor,
  ),
);
