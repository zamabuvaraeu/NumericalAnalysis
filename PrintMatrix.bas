#include once "PrintMatrix.bi"

Sub PrintMatrix OverLoad(ByRef A As Matrix)
	For Row As Integer = 0 To A.RowsCount - 1
		For Col As Integer = 0 To A.ColsCount - 1
			Print CSng(A.GetValue(Row, Col)),
		Next
		Print
	Next
End Sub

Sub PrintMatrix Overload(ByRef A As RationalMatrix)
	For Row As Integer = 0 To A.RowsCount - 1
		For Col As Integer = 0 To A.ColsCount - 1
			var fractional = A.GetValue(Row, Col)
			Print fractional.m; " /"; fractional.n,
		Next
		Print
	Next
End Sub
