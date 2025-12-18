import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedDropdown extends StatefulWidget {
  final Function(String?) onChanged;

  AnimatedDropdown({required this.onChanged});
  @override
  _AnimatedDropdownState createState() => _AnimatedDropdownState();
}

class _AnimatedDropdownState extends State<AnimatedDropdown> {
  bool _isExpanded = false;
  String _selectedItem = 'Role';
  final List<String> _options = ['Genie', 'Customer'];

  void _toggleDropdown() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _selectItem(String item) {
    setState(() {
      _selectedItem = item;
      _isExpanded = false;
    });
    widget.onChanged(_selectedItem);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Dropdown Button
        GestureDetector(
          onTap: _toggleDropdown,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color.fromRGBO(0, 0, 0, 0.12),
                  offset: Offset(
                    0.0,
                    ScreenUtil().setWidth(3.0),
                  ), //(x,y)
                  blurRadius: ScreenUtil().setWidth(6.0),
                ),
              ],
              borderRadius: _isExpanded ? BorderRadius.only(topLeft: Radius.circular(ScreenUtil().setWidth(7),), topRight: Radius.circular(ScreenUtil().setWidth(7)))
              : BorderRadius.all(Radius.circular(
                ScreenUtil().setWidth(20),
              )),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.account_circle_rounded,
                  color: Color(0xFF252B37),
                ),
                Expanded(child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    _selectedItem,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                )),
                Icon(_isExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down, color: Colors.indigo,),
              ],
            ),
          ),
        ),

        // Animated Dropdown List
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: _isExpanded ? (_options.length * 50) : 0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color.fromRGBO(0, 0, 0, 0.12),
                  offset: Offset(
                    0.0,
                    ScreenUtil().setWidth(3.0),
                  ), //(x,y)
                  blurRadius: ScreenUtil().setWidth(6.0),
                ),
              ],
              borderRadius: _isExpanded ? BorderRadius.only(bottomLeft: Radius.circular(ScreenUtil().setWidth(7),), bottomRight: Radius.circular(ScreenUtil().setWidth(7)))
              : BorderRadius.all(Radius.circular(
                ScreenUtil().setWidth(7),
              )),
            ),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _options.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_options[index]),
                  onTap: () => _selectItem(_options[index]),
                  dense: true,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
