import 'package:flutter/material.dart';
import 'package:kasi_chat/core/core.dart';

class SearchTextfield extends StatefulWidget {
  const SearchTextfield({super.key});

  @override
  State<SearchTextfield> createState() => _SearchTextfieldState();
}

class _SearchTextfieldState extends State<SearchTextfield> {
  final _focusNode = FocusNode();
  String _searchQuery = '';

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xlg,
      ),
      child: AppTextField(
        focusNode: _focusNode,
        filled: true,
        textInputAction: TextInputAction.search,
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
        suffixIcon: _searchQuery.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear, color: AppColors.grey),
                onPressed: () {
                  setState(() { // TODO Will be replace by bloc/cubit 
                    _searchQuery = '';
                  });
                  _focusNode.unfocus();
                },
              )
            : null,

        prefixIcon: const Icon(
          Icomoon.searchS,
          color: AppColors.grey,
          size: 24,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: AppSpacing.sm,
          horizontal: AppSpacing.sm,
        ),
        border: InputBorder.none,
      ),
    );
  }
}
