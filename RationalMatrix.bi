#ifndef __rationalmatrix__
#define __rationalmatrix__

#include once "Rational.bi"

Type RationalMatrix
	Declare Constructor(ByVal Rows As Integer, Cols As Integer)
	Declare Constructor(ByRef rhs As RationalMatrix)
	Declare Destructor()
	Declare Operator Let(ByRef rhs As RationalMatrix)
	
	Declare Property RowsCount()As Integer
	Declare Property ColsCount()As Integer
	
	Declare Property FreeMembersCols(ByVal Row As Integer)As Rational
	
	Declare Function GetValue(ByVal Row As Integer, ByVal Col As Integer)As Rational
	Declare Sub SetValue(ByVal Row As Integer, ByVal Col As Integer, ByVal NewValue As Rational)
	
	
	Private:
		Dim A As Rational Ptr
		Dim Rows As Integer
		Dim Cols As Integer
End Type

#endif