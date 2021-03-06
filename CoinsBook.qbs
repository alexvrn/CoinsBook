import qbs

Project {
  
  CppApplication {
    name: "CoinsBook"
    type: "application"

    files: [ "src/*",
             "src/qml/material-qml/*",
             "src/qml/material-qml/calculator/*",
             "src/qml/material-qml/timepicker/*",
             "src/qml/*",
             "src/qml/icons/*",
             "src/qml/picker/*",
             "src/qml/picker/Global/*",
             "src/qml/picker/Other/*"]

    cpp.includePaths: [ "src" ]

    Depends { name: "cpp" }
    Depends { name: "Qt"; submodules: [ "core", "gui", "sql", "widgets", "quick", "qml" ] }

    Properties {
      condition: qbs.toolchain.contains('gcc')
      cpp.cxxFlags: [ "-std=c++11" ]
    }

    Group {     // Properties for the produced executable
      fileTagsFilter: product.type
      qbs.install: true
      qbs.installDir: "bin"
    }
  }
}
