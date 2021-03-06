#include once "RotationElimination.bi"
#include once "PrintMatrix.bi"

Function RotationElimination OverLoad(ByRef A As Matrix)As Matrix
	
	var TempA = A
	
	For Row As Integer = 0 To TempA.RowsCount - 1
		For NextRow As Integer = Row + 1 To TempA.RowsCount - 1
			
			Dim TempTempA As Matrix = Type<Matrix>(2, TempA.ColsCount) 
			Scope
				var a11 = TempA.GetValue(Row, Row)
				var a21 = TempA.GetValue(NextRow, Row)
				var DivisorSqr = Sqr(a11 * a11 + a21 * a21)
				
				var Cosinus = a11 / DivisorSqr
				var Sinus = a21 / DivisorSqr
				
				Dim TempTempA2 As Matrix = Type<Matrix>(2, TempA.ColsCount) 
				For Col As Integer = 0 To TempA.ColsCount - 1
					TempTempA2.SetValue(0, Col, Cosinus * TempA.GetValue(Row,     Col))
					TempTempA2.SetValue(1, Col,   Sinus * TempA.GetValue(NextRow, Col))
					
					TempTempA.SetValue(0, Col, TempTempA2.GetValue(0, Col) + TempTempA2.GetValue(1, Col))
					
					TempTempA2.SetValue(0, Col, - Sinus * TempA.GetValue(Row,     Col))
					TempTempA2.SetValue(1, Col, Cosinus * TempA.GetValue(NextRow, Col))
					
					TempTempA.SetValue(1, Col, TempTempA2.GetValue(0, Col) + TempTempA2.GetValue(1, Col))
				Next
			End Scope
			
			For Col As Integer = 0 To TempA.ColsCount - 1
				TempA.SetValue(Row, Col, TempTempA.GetValue(0, Col))
				TempA.SetValue(NextRow, Col, TempTempA.GetValue(1, Col))
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
