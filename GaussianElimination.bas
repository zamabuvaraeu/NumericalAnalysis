#include once "Matrix.bi"
#include once "GaussianElimination.bi"

Sub GaussianElimination(ByRef A As Matrix)
	var TempA = A
	
	For Row As Integer = 0 To TempA.RowsCount - 2
		
		If TempA.GetValue(0, Row) = 0 Then
			Continue For
		End If
		
		For NextRow As Integer = Row + 1 To TempA.RowsCount - 1
			
			var m = TempA.GetValue(NextRow, Row) / TempA.GetValue(0, Row)
			
			For Col As Integer = Row To TempA.ColsCount - 1
				
				var NewValue = TempA.GetValue(NextRow, Col) - m * TempA.GetValue(0, Col)
				TempA.SetValue(NextRow, Col, NewValue)
				
			Next
			
		Next
		
	Next
	
	Dim x As Matrix = Type<Matrix>(1, A.ColsCount - 1)
	
	For Row As Integer = 0 To A.RowsCount - 1
		' For NextRow As Integer = Row + 1 To A.RowsCount - 1
		' Next
	Next
	
End Sub
