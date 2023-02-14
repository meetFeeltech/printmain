import 'package:cheque_print/commonWidget/themeHelper.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:flutter/material.dart';


class GridDataCommonFunc {
  static GridColumn tableColumnsDataLayoutwithWidthHeight(
      {
        required String columnName,
        required String toolTipMessage,
        required String columnTitle,
        bool? isToolTipNeeded,
        bool? isFliteringNeeded,
        double? minColumnWidth,
        double? maxColumnWidth,
        double?  columnWidthMode,
        bool? visible
      }
      ) {
    return GridColumn(
      minimumWidth: minColumnWidth ?? 0,
      maximumWidth: maxColumnWidth ?? 0,
      filterIconPadding: const EdgeInsets.symmetric(horizontal: 2),
      allowFiltering: isFliteringNeeded ?? true,
      // columnWidthMode: ColumnWidthMode.fitByColumnName,
      columnName: columnName,
      label: (isToolTipNeeded ?? true)
          ? ThemeHelper.showToolTipWidget(
        message: toolTipMessage,
        child: Align(
            alignment: Alignment.center,
            child: Text(
              columnTitle,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13
              ),
            )
        ),
      )
          : Align(
          alignment: Alignment.center,
          child: Text(
            columnTitle,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13
            ),
          )
      ),
    );
  }

  static GridColumn tableColumnsDataLayout(
      {
        required String columnName,
        required String toolTipMessage,
        required String columnTitle,
        bool? isToolTipNeeded,
        bool? isFliteringNeeded,
        ColumnWidthMode? columnWidthModeData,
        bool? allowSorting,
        bool? visible
      }
      ) {
    return GridColumn(
      filterIconPadding: const EdgeInsets.symmetric(horizontal: 2),
      columnWidthMode: columnWidthModeData ?? ColumnWidthMode.none,
      visible : visible?? true,
      columnName: columnName,
      allowFiltering: isFliteringNeeded ?? true,
      label: (isToolTipNeeded ?? true)
          ? ThemeHelper.showToolTipWidget(
        message: toolTipMessage,
        child: Align(
            alignment: Alignment.center,
            child: Text(
              columnTitle,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13
              ),
            )
        ),
      )
          : Align(
          alignment: Alignment.center,
          child: Text(
            columnTitle,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13
            ),
          )
      ),
    );
  }
}


