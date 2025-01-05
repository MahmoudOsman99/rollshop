import 'package:flutter/material.dart';

// Reusable function for a simple custom Snackbar
void showCustomSnackBar({
  required BuildContext context,
  required String message,
  Color? color,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(Icons.info_outline, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
  );
}

// // Custom widget for a more complex Snackbar
// class CustomSnackBarContent extends StatelessWidget {
//   final String message;
//   final IconData? icon;
//   final Color? backgroundColor;
//   final Color? textColor;

//   const CustomSnackBarContent({
//     Key? key,
//     required this.message,
//     this.icon = Icons.info_outline,
//     this.backgroundColor = Colors.orange,
//     this.textColor = Colors.black,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: backgroundColor,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.black, width: 2),
//       ),
//       child: Row(
//         children: [
//           Icon(icon, color: textColor),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Text(
//               message,
//               style: TextStyle(
//                 color: textColor,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
