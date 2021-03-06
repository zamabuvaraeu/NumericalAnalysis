#include once "RationalMatrix.bi"
#include once "crt.bi"

Constructor RationalMatrix(ByVal Rows As Integer, Cols As Integer)
	This.Rows = Rows
	This.Cols = Cols
	A = Allocate(Cols * Rows * SizeOf(Rational))
End Constructor

Constructor RationalMatrix(ByRef rhs As RationalMatrix)
	Dim ArrayLength As Integer = rhs.Cols * rhs.Rows * SizeOf(Rational)
	A = Allocate(ArrayLength)
	memcpy(A, rhs.A, ArrayLength)
	This.Rows = rhs.Rows
	This.Cols = rhs.Cols
End Constructor

Operator RationalMatrix.Let(ByRef rhs As RationalMatrix)
	If @This <> @rhs Then
		Deallocate(A)
		Dim ArrayLength As Integer = rhs.Cols * rhs.Rows * SizeOf(Rational)
		A = Allocate(ArrayLength)
		memcpy(A, rhs.A, ArrayLength)
		This.Rows = rhs.Rows
		This.Cols = rhs.Cols
	End	If
End Operator

Destructor RationalMatrix()
	If A <> 0 Then
		DeAllocate(A)
	End If
End Destructor

Property RationalMatrix.RowsCount()As Integer
	Return Rows
End Property

Property RationalMatrix.ColsCount()As Integer
	Return Cols
End Property

Property RationalMatrix.FreeMembersCols(ByVal Row As Integer)As Rational
	Return A[Cols * Row + Cols - 1]
End Property

Function RationalMatrix.GetValue(ByVal Row As Integer, ByVal Col As Integer)As Rational
	Return A[Cols * Row + Col]
End Function

Sub RationalMatrix.SetValue(ByVal Row As Integer, ByVal Col As Integer, ByVal NewValue As Rational)
	A[Cols * Row + Col] = NewValue
End Sub
