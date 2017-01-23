import QtQuick 2.3
import QtQuick.Controls 1.2

import "icons.js" as Icons

import "material-qml" as Material
import "material-qml/calculator" as Calculator
import "material-qml/timepicker" as Time
import "material-qml/density.js" as Density
import "StyleColor.js" as StyleColor

Item {
  id: root

  property int __currentIndex: financesTabView.current
  property int __margin: 2*Density.dp
  property color __currentColor: "#ffd54f"

  signal back
  signal changeCategory(string color)

  function getColor(index) {
    if (index === 0)
      return "#ffd54f"; // Счёт
    else if (index === 1)
      return "#66bb6a"; // Доход
    else if (index === 2)
      return "#f44336"; // Расход
    else
      return "black";
  }

  onVisibleChanged: {
    if (visible)
    {
      var color = getColor(__currentIndex)
      changeCategory(color)
    }
  }


  // TODO: не работает
  function setStatus(index) {
    if (index < 0 || index > 2) {
      console.error("Неверное значение")
      return
    }

    var color = getColor(index)
    __currentColor = color
    //changeCategory(color)
    financesTabView.current = index
  }

  Connections {
    target: DBController      
  }

  Rectangle {
    id: background
    color: "white"
    anchors.fill: root
  }

  Material.PaperTextField {
    id: searchCategoryText
    anchors {
      left: root.left
      right: root.right
      top: root.top
    }
    height: 40*Density.dp
    textColor: "#90a4ae"
    //font.pixelSize: 12 * Density.dp
    //font.bold: false
    placeholderText: "Напишите название новой категории"
    //horizontalAlignment: Text.AlignHCenter
    //verticalAlignment: Text.AlignVCenter
  }

  ListModel {
    id: coinsTotalModel
  }

  ListModel {
    id: coinsIncomeModel
  }

  ListModel {
    id: coinsExpenseModel
  }

  FinancesDelegate {
    id: totalDelegate
  }

  FinancesDelegate {
    id: incomeDelegate
  }

  FinancesDelegate {
    id: expenseDelegate
  }

  Material.PaperTabView {
    id: financesTabView

    tabBackgroundColor: "#cfd8dc"
    tabTextColor: "black"
    highlightColor: __currentColor
    cellWidth: width / 3
    cellHeight: 30*Density.dp
    tabFontSize: 7*Density.dp

    anchors {
      top: searchCategoryText.bottom
      bottom: root.bottom
      left: root.left
      right: root.right
      bottomMargin: 54*Density.dp
      margins: __margin
    }

    onCurrentChanged: {
      __currentColor = getColor(current)
      changeCategory(getColor(current))
    }

    Material.PaperTab {
      title: "Счёт"
      Item
      {
        anchors.fill: parent
        Text {
          text: "Счёт"
          color: "#ffee58"
          font.bold: true
          anchors {
            left: parent.left
            right: parent.right
            top: parent.top
          }
        }
        // небольшой костыль. возможно можно как-то граммотно сделать
        Text {
          id: infoTotalItem
          anchors {
            left: parent.left
            right: parent.right
            top: parent.top
          }
          text: "          - это типа категории, который характеризует ваши расходы"
          color: "#616161"
          font.pixelSize: 12 * Density.dp
          wrapMode: Text.WordWrap
        }

        FinancesListView {
          id: coinsTotalView
          anchors {
            left: parent.left
            right: parent.right
            top: infoTotalItem.bottom
            bottom: parent.bottom
          }
          financesModel: coinsTotalModel
          financesDelegate: totalDelegate
        }
      } // Item
    }
    Material.PaperTab {
      title: "Доход"
      Item {
        id: textIncomeItem

        FinancesListView {
          id: coinsAdditionView
          anchors {
            left: textIncomeItem.left
            right: textIncomeItem.right
            top: textIncomeItem.top
            bottom: textIncomeItem.bottom
          }
          financesModel: coinsIncomeModel
          financesDelegate: incomeDelegate
        }
      }
    }
    Material.PaperTab {
      title: "Расход"
      Item {
        anchors.fill: parent
        Text {
          text: "Расход"
          color: "#f44336"
          font.bold: true
        }
        Text {
          id: textExpenseItem
          anchors {
            left: parent.left
            right: parent.right
          }
          text: "              - это типа категории, который характеризует ваши расходы"
          color: "#616161"
          font.pixelSize: 12 * Density.dp
          wrapMode: Text.WordWrap
        }

        FinancesListView {
          id: coinsExpenseView
          anchors {
            left: parent.left
            right: parent.right
            top: textExpenseItem.bottom
            bottom: parent.bottom
          }
          financesModel: coinsExpenseModel
          financesDelegate: expenseDelegate
        }
      }// Item
    }
  }// TabView
}
