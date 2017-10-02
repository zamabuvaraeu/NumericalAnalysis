#ifndef unicode
#define unicode
#endif
#include once "windows.bi"
#include once "Matrix.bi"
#include once "GaussianElimination.bi"
#include once "LoadMatrix.bi"

Sub PrintMatrix(ByRef A As Matrix)
	For Row As Integer = 0 To A.RowsCount - 1
		For Col As Integer = 0 To A.ColsCount - 1
			Print A.GetValue(Row, Col),
		Next
		Print
	Next
End Sub

var A = GetMatrix(GetStdHandle(STD_INPUT_HANDLE))
PrintMatrix(A)

Print

GaussianElimination(A)
PrintMatrix(A)
