import 'package:flutter/material.dart';

class PhotoPickerPield extends StatelessWidget {
  const PhotoPickerPield({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
          spacing: 8,
          children: [
            Container(
              width: 90,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: Center(
                child: Icon(Icons.camera_alt_outlined),
              ),
            ),
            Expanded(
                child: Text('Upload Image',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    )
                )
            )
          ]
      ),
    );
  }
}