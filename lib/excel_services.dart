import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';

import 'components.dart';

Excel getExcel(String filePath) {
  var bytes = File(filePath).readAsBytesSync();
  return Excel.decodeBytes(bytes);
}

void saveExcel(Excel? excel, String? filePath, BuildContext context) {
  try {
    var bytes = excel!.encode()!;
    File(filePath!).writeAsBytesSync(bytes);
  } catch (e) {
    dialogBox(context, "Notification", "error");
  }
}

Sheet? getSheetFromExcel(Excel excel) {
  if (excel.tables.isNotEmpty) {
    return excel.tables.values.first;
  }

  return null;
}

List<String> getFirstColumnValues(Sheet? sheet) {
  var values = <String>[];

  for (var i = 0; i < sheet!.maxCols; i++) {
    var cellValue = sheet
        .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
        .value;
    if (cellValue != null) {
      values.add(cellValue.toString());
    } else {
      values.add(''); // Adiciona uma string vazia se a célula for nula
    }
  }

  return values;
}

int searchInColumn(Sheet? sheet, String columnName, dynamic searchValue) {
  var columnIndex = getColumnByName(sheet!, columnName);

  if (columnIndex != -1) {
    for (var i = 1; i <= sheet.maxRows - 1; i++) {
      var cellValue = sheet
          .cell(
              CellIndex.indexByColumnRow(columnIndex: columnIndex, rowIndex: i))
          .value;
      if (cellValue != null) {
        if (searchValue is String) {
          if (cellValue.toString().toLowerCase() == searchValue.toLowerCase()) {
            return i;
          }
        }
      }
    }
  }
  return -1;
}

dynamic valueByIndex(Sheet sheet, int rowIndex, String columnName) {
  var columnIndex = getColumnByName(sheet, columnName);

  if (columnIndex != -1 && rowIndex < sheet.maxRows) {
    // Obter o valor da célula
    return sheet
        .cell(CellIndex.indexByColumnRow(
            columnIndex: columnIndex, rowIndex: rowIndex))
        .value;
  }

  return null;
}

int getColumnByName(Sheet sheet, String columnName) {
  var columnIndex = -1;
  columnName = columnName.toLowerCase();

  for (var i = 0; i < sheet.maxCols; i++) {
    var cellValue = sheet
        .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
        .value;
    if (cellValue != null && cellValue.toString().toLowerCase() == columnName) {
      columnIndex = i;
      return columnIndex;
    }
  }
  return -1;
}

String searchName(Sheet sheet, String columnName, int index) {
  var columnIndex = getColumnByName(sheet, columnName);

  if (columnIndex != -1 && index < sheet.maxRows) {
    var cellValue = sheet
        .cell(CellIndex.indexByColumnRow(
            columnIndex: columnIndex, rowIndex: index))
        .value;
    if (cellValue != null) {
      return cellValue.toString();
    }
  }
  return '';
}

String registerPresence({
  required Sheet? sheet,
  required String id,
  required String? columnID,
  required String? columnPresence,
  required String value,
  String? columnName,
}) {
  if (sheet == null || columnID == null || columnPresence == null) {
    return '-1';
  }
  var columnIndex = getColumnByName(sheet, columnPresence);
  var rowIndex = searchInColumn(sheet, columnID, id);
  if (columnIndex >= 0 && rowIndex >= 0) {
    var cell = sheet.cell(CellIndex.indexByColumnRow(
        columnIndex: columnIndex, rowIndex: rowIndex));

    cell.value = value;

    if (columnName != null) {
      return searchName(sheet, columnName, rowIndex);
    } else {
      return 'Nome Desconhecido';
    }
  }
  return '-1';
}

String addNewRecord(
    {required Sheet? sheet,
    required String name,
    String? id,
    String? rfid,
    required String? columnName,
    String? columnID,
    String? columnRFID}) {
  if (sheet == null || columnName == null) {
    return 'error';
  }
  int columnIndex = getColumnByName(sheet, columnName);

  if (columnIndex >= 0) {
    int rowIndex = 1;
    while (true) {
      var cellValue = valueByIndex(sheet, rowIndex, columnName);
      if (cellValue == null || cellValue.isEmpty) {
        break;
      }
      rowIndex++;
    }

    sheet
        .cell(CellIndex.indexByColumnRow(
            columnIndex: columnIndex, rowIndex: rowIndex))
        .value = name;

    if (columnID != null) {
      int columnIndexID = getColumnByName(sheet, columnID);
      sheet
          .cell(CellIndex.indexByColumnRow(
              columnIndex: columnIndexID, rowIndex: rowIndex))
          .value = id;
    }

    if (columnRFID != null) {
      int columnIndexRFID = getColumnByName(sheet, columnRFID);
      sheet
          .cell(CellIndex.indexByColumnRow(
              columnIndex: columnIndexRFID, rowIndex: rowIndex))
          .value = id;
    }
    return 'Registrado com Sucesso';
  }
  return 'falha ao registrar';
}
