Attribute VB_Name = "Module1"
Sub rm_duprow()
    With ActiveSheet
        .Range(.Cells(1, 1), .Cells.SpecialCells(xlCellTypeLastCell)).RemoveDuplicates Columns:=Array(1), Header:=xlYes
    End With
End Sub

Sub rm_rw_blnk_col()
    With ActiveSheet
        .Range(.Cells(1, 1), .Cells.SpecialCells(xlCellTypeLastCell)).Select
    End With
    
    Selection.SpecialCells(xlCellTypeBlanks).Select
    Selection.EntireRow.Delete
End Sub

Sub clean_csv()
    rm_duprow
    rm_rw_blnk_col
End Sub
