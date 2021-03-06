#include once "Matrix.bi"
#include once "crt.bi"
#include once "win\shlwapi.bi"
#include once "win\shellapi.bi"

#include once "ConsoleReadLine.bi"
#include once "Matrix.bi"

Const vbCrLf = !"\r\n"

Constructor Matrix(ByVal Rows As Integer, Cols As Integer)
	This.Rows = Rows
	This.Cols = Cols
	A = Allocate(Cols * Rows * SizeOf(Double))
End Constructor

Constructor Matrix(ByRef rhs As Matrix)
	Dim ArrayLength As Integer = rhs.Cols * rhs.Rows * SizeOf(Double)
	A = Allocate(ArrayLength)
	memcpy(A, rhs.A, ArrayLength)
	This.Rows = rhs.Rows
	This.Cols = rhs.Cols
End Constructor

Operator Matrix.Let(ByRef rhs As Matrix)
	If @This <> @rhs Then
		Deallocate(A)
		Dim ArrayLength As Integer = rhs.Cols * rhs.Rows * SizeOf(Double)
		A = Allocate(ArrayLength)
		memcpy(A, rhs.A, ArrayLength)
		This.Rows = rhs.Rows
		This.Cols = rhs.Cols
	End	If
End Operator

Destructor Matrix()
	If A <> 0 Then
		DeAllocate(A)
	End If
End Destructor

Property Matrix.RowsCount()As Integer
	Return Rows
End Property

Property Matrix.ColsCount()As Integer
	Return Cols
End Property

Property Matrix.FreeMembersCols(ByVal Row As Integer)As Double
	Return A[Cols * Row + Cols - 1]
End Property

Function Matrix.GetValue(ByVal Row As Integer, ByVal Col As Integer)As Double
	Return A[Cols * Row + Col]
End Function

Sub Matrix.SetValue(ByVal Row As Integer, ByVal Col As Integer, ByVal NewValue As Double)
	A[Cols * Row + Col] = NewValue
End Sub
