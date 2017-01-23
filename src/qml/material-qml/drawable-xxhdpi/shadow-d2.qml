import QtQuick 2.0

Item {
  BorderImage {
    source: "shadow-d2.png"

    anchors {
      fill: parent
      leftMargin: -border.left; topMargin: -border.top
      rightMargin: -border.right; bottomMargin: -border.bottom
    }

    border.left: 24; border.top: 17
    border.right: 22; border.bottom: 37
  }
}
