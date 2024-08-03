import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  final Function(String)? onSubmitted;
  final Function()? onSuffixTap;
  final String? placeholder;
  final TextEditingController? controller;
  const SearchBox({
    super.key,
    this.onSubmitted,
    this.onSuffixTap,
    this.placeholder,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CupertinoSearchTextField(
            padding: const EdgeInsetsDirectional.fromSTEB(5.5, 12, 5.5, 12),
            placeholder: placeholder,
            prefixIcon: const Icon(
              CupertinoIcons.search,
              size: 16,
            ),
            style: Theme.of(context).textTheme.bodySmall,
            controller: controller,
            onSubmitted: onSubmitted,
            autocorrect: false,
            onSuffixTap: onSuffixTap,
          ),
        ),
      ],
    );
  }
}
