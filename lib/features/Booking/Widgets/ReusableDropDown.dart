import 'package:flutter/material.dart';

class ReusableDropdownButton<T> extends StatefulWidget {
  final List<T> items;
  final T? selectedItem;
  final String hint;
  final Function(T?)? onChanged;
  final bool isExpanded;
  final String title;

  const ReusableDropdownButton({
    super.key,
    required this.items,
    required this.hint,
    this.selectedItem,
    this.onChanged,
    this.isExpanded = true,
    required this.title,
  });

  @override
  _ReusableDropdownButtonState<T> createState() =>
      _ReusableDropdownButtonState<T>();
}

class _ReusableDropdownButtonState<T> extends State<ReusableDropdownButton<T>> {
  T? _selectedItem;

  @override
  @override
  void initState() {
    super.initState();
    if (widget.selectedItem != null) {
      _selectedItem = widget.selectedItem;
    } else if (widget.items.isNotEmpty) {
      _selectedItem = widget.items.first;
    } else {
      _selectedItem = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 7.0, top: 2, bottom: 2),
            child: Text(widget.title),
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFEBEDED),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton<T>(
              value: _selectedItem,
              hint: Text(widget.hint),
              icon: const Padding(
                padding: EdgeInsets.only(right: 13.0),
                child: Icon(Icons.arrow_drop_down),
              ),
              underline: Container(
                height: 0,
                color: Colors.transparent,
              ),
              isExpanded: widget.isExpanded,
              items: widget.items.map((T item) {
                return DropdownMenuItem<T>(
                  value: item,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Text(item.toString()),
                  ),
                );
              }).toList(),
              onChanged: (T? value) {
                setState(() {
                  _selectedItem = value;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
