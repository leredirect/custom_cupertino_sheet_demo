# cupertino_sheet_fork

As of Flutter 3.32.4, the default CupertinoBottomSheet does not support nested scroll to dissmis when it's child is Scrollable.

To address this limitation, I created a custom implementation that adds full scroll to dissmis + scrollable support by listening to ScrollNotifications.
The implementation also handles a corner case where the down gesture accidentally scrolls the child scrollable. This is solved by dynamically providing a DampnedScrollPhysics down to the tree via ScrollConfiguration. DampnedScrollPhysics reduce scroll velocity to 1% of the real value, allowing the scroll to freeze without blocking ScrollNotifications.

If the bottom sheet’s child is Scrollable and you want to use bouncing srcolling - you must explicitly pass BottomSheetScrollPhysics (https://pub.dev/packages/bottom_sheet_scroll_physics) to it. BottomSheetScrollPhysics class included in file.

Both Scrollable and non-scrollable children allowed and can be swapped. This works via simultaneous listening to both ScrollNotifications and a RawGestureDetector, whose callbacks invoke the internal CupertinoDownGestureController methods.

👉 Gist with latest implementation
https://gist.github.com/leredirect/c5904d9c611388cf6c08449dccc1e91b

demo:
https://github.com/user-attachments/assets/fa56581e-6b98-4a56-a036-1b3a5c630438

