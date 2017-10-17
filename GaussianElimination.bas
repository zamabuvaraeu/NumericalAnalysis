#include once "GaussianElimination.bi"
#include once "Rational.bi"
#include once "PrintMatrix.bi"

Function GaussianElimination OverLoad(ByRef A As Matrix)As Matrix
	var TempA = A
	
	For Row As Integer = 0 To TempA.RowsCount - 1
		
		Scope
			var Norm = TempA.GetValue(Row, Row)
			
			For Col As Integer = Row To TempA.ColsCount - 1
				
				var NewValue = TempA.GetValue(Row, Col) / Norm
				TempA.SetValue(Row, Col, NewValue)
				
			Next
		End Scope
		
		For NextRow As Integer = Row + 1 To TempA.RowsCount - 1
			
			var ZeroingFactor = TempA.GetValue(NextRow, Row)
			
			For Col As Integer = Row To TempA.ColsCount - 1
				
				var NewValue = TempA.GetValue(NextRow, Col) - ZeroingFactor * TempA.GetValue(Row, Col)
				TempA.SetValue(NextRow, Col, NewValue)
				
			Next
			
		Next
		
	Next
	
#if __FB_DEBUG__ <> 0
	Print "Временная матрица"
	PrintMatrix(TempA)
	Print
#endif
	
	Dim ResultX As Matrix = Type<Matrix>(A.RowsCount, 1)
	
	For Row As Integer = TempA.RowsCount - 1 To 0 Step -1
		
		Dim subs As Double
		For NextCol As Integer = TempA.ColsCount - 2 To Row + 1 Step -1
			subs += ResultX.GetValue(NextCol, 0) * TempA.GetValue(Row, NextCol)
		Next
		
		var b = TempA.FreeMembersCols(Row)
		var x = (b - subs) / TempA.GetValue(Row, Row)
		ResultX.SetValue(Row, 0, x)
		
	Next
	
	Return ResultX
End Function
