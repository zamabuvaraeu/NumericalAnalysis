#include once "Residual.bi"

Function GetResidual OverLoad(ByRef A As Matrix, ByRef ResultX As Matrix)As Matrix
	var Residual = Type<Matrix>(ResultX.RowsCount, 1)
	
	For Row As Integer = 0 To A.RowsCount - 1
		Dim m As Double
		For Col As Integer = 0 To A.ColsCount - 2
			m += A.GetValue(Row, Col) * ResultX.GetValue(0, Col)
		Next
		Residual.SetValue(Row, 0, A.FreeMembersCols(Row) - m)
	Next
	
	Return Residual
End Function

Function GetResidual OverLoad(ByRef A As RationalMatrix, ByRef ResultX As RationalMatrix)As RationalMatrix
	var Residual = Type<RationalMatrix>(ResultX.RowsCount, 1)
	
	For Row As Integer = 0 To A.RowsCount - 1
		Dim m As Rational
		For Col As Integer = 0 To A.ColsCount - 2
			m += A.GetValue(Row, Col) * ResultX.GetValue(0, Col)
		Next
		Residual.SetValue(Row, 0, A.FreeMembersCols(Row) - m)
	Next
	
	Return Residual
End Function
