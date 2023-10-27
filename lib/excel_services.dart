import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';

import 'components.dart';

Excel getExcel(String filePath) {
  var bytes = File(filePath).readAsBytesSync();
  return Excel.decodeBytes(bytes);
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

int searchInColumn(Sheet? sheet, String nomeColuna, dynamic searchValue) {
  var columnIndex = getColumnByName(sheet!, nomeColuna);

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

String registerPresence({
  required Sheet? sheet,
  required String id,
  required String? columnID,
  required String? columnPresence,
  dynamic value,
}) {
  if (sheet == null || columnID == null || columnPresence == null) {
    return 'error';
  }
  var columnIndex = getColumnByName(sheet, columnPresence);
  var rowIndex = searchInColumn(sheet, columnID, id);
  if (columnIndex == -1) {
    return 'Erro no colunm index';
  }

  if (rowIndex == -1) {
    return 'Erro no rowIndex, verifique se a tabela esta tudo como texto';
  }
  if (columnIndex >= 0 && rowIndex >= 0) {
    var cell = sheet.cell(CellIndex.indexByColumnRow(
        columnIndex: columnIndex, rowIndex: rowIndex));

    // Set the value
    cell.value = value;

    // Print the cell value
    return 'registrado com sucesso';
  }
  return 'nao encontrado';
}

void saveExcel(Excel? excel, String? filePath, BuildContext context) {
  try {
    var bytes = excel!.encode()!;
    File(filePath!).writeAsBytesSync(bytes);
  } catch (e) {
    dialogBox(context, "Notification", "error");
  }
}
