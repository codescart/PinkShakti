//
// import 'package:flutter/material.dart';
// import 'package:pinkPower/color.dart';
//
// class EntryField extends StatelessWidget {
//   final String? hint;
//   final IconData? prefixIcon;
//   final Color? color;
//   final Color? color2;
//   final TextEditingController? controller;
//   final String? initialValue;
//   final bool? readOnly;
//   final TextAlign? textAlign;
//   final IconData? suffixIcon;
//   final TextInputType? textInputType;
//   final String? label;
//   final int? maxLines;
//   final int? maxLength;
//   final bool? isDense;
//   final Function? onTap;
//   FormFieldValidator<String>? validator;
//   final TextInputType? keyboardType;
//   final bool? obscureText;
//   final Color? cursorColor;
//
//   EntryField(
//       {this.hint,
//         this.prefixIcon,
//         this.color,
//         this.color2,
//         this.controller,
//         this.initialValue,
//         this.readOnly,
//         this.textAlign,
//         this.suffixIcon,
//         this.textInputType,
//         this.label,
//         this.maxLines,
//         this.maxLength,
//         this.isDense,
//         this.onTap,
//         this.validator,
//         this.keyboardType,
//         this.obscureText,
//         this.cursorColor
//       });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         label != null
//             ? Text('\n' + label! + '\n',
//             style: Theme.of(context)
//                 .textTheme
//                 .subtitle2!
//                 .copyWith(color: Color(0xff808080)))
//             : SizedBox.shrink(),
//         TextFormField(
//           onTap: onTap as void Function()?,
//           controller: controller,
//           initialValue: initialValue,
//           readOnly: readOnly ?? false,
//           validator: validator,
//           maxLines: maxLines ?? 1,
//           maxLength: maxLength,
//           textAlign: textAlign ?? TextAlign.left,
//           keyboardType: textInputType,
//           cursorColor: Theme.of(context).primaryColor,
//           decoration: InputDecoration(
//               counter: Offstage(),
//               isDense: isDense ?? isDense,
//               prefixIcon: prefixIcon != null
//                   ? Icon(
//                 prefixIcon,
//                 color: Theme.of(context).primaryColor,
//                 size: 18.5,
//               )
//                   : null,
//               suffixIcon: Icon(suffixIcon),
//               hintText: hint,
//               hintStyle: Theme.of(context)
//                   .textTheme
//                   .bodyText1!
//                   .copyWith(color: color2 ?? PinkColors, fontSize: 15),
//               filled: true,
//               fillColor: color ?? Theme.of(context).primaryColorLight,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 borderSide: BorderSide.none,
//               )),
//         ),
//       ],
//     );
//   }
// }