import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FilterButton extends StatelessWidget {
  final VoidCallback onTap;

  const FilterButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.grey),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Load the SVG icon
          SvgPicture.asset(
            'assets/icons/filter.svg',
            height: 16,
            width: 16,
            color: Colors.black,
          ),
          const SizedBox(width: 6),
          const Text(
            'Filter',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}


class FilterButtonWithPopup extends StatefulWidget {
  final Function(int categoryId) onCategorySelected;

  const FilterButtonWithPopup({Key? key, required this.onCategorySelected}) : super(key: key);

  @override
  State<FilterButtonWithPopup> createState() => _FilterButtonWithPopupState();
}

class _FilterButtonWithPopupState extends State<FilterButtonWithPopup> {
  int? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return FilterButton(
      onTap: () {
        showMenu(
          context: context,
          position: const RelativeRect.fromLTRB(100, 100, 0, 0), // Adjust position as needed
          items: [
            PopupMenuItem<int>(
              value: 1,
              child: const Text('Academic Pressure'),
            ),
            PopupMenuItem<int>(
              value: 2,
              child: const Text('Sleep Issues'),
            ),
            PopupMenuItem<int>(
              value: 3,
              child: const Text('Wellness Tips'),
            ),
            PopupMenuItem<int>(
              value: 4,
              child: const Text('Mental Health Tips'),
            ),
          ],
        ).then((value) {
          if (value != null) {
            setState(() {
              selectedCategory = value;
            });
            widget.onCategorySelected(value);
          }
        });
      },
    );
  }
}