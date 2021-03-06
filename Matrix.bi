#ifndef __matrix__
#define __matrix__

Type Matrix
	Declare Constructor(ByVal Rows As Integer, Cols As Integer)
	Declare Constructor(ByRef rhs As Matrix)
	Declare Destructor()
	Declare Operator Let(ByRef rhs As Matrix)
	
	Declare Property RowsCount()As Integer
	Declare Property ColsCount()As Integer
	
	Declare Property FreeMembersCols(ByVal Row As Integer)As Double
	
	Declare Function GetValue(ByVal Row As Integer, ByVal Col As Integer)As Double
	Declare Sub SetValue(ByVal Row As Integer, ByVal Col As Integer, ByVal NewValue As Double)
	
	
	Private:
		Dim A As Double Ptr
		Dim Rows As Integer
		Dim Cols As Integer
End Type

#endif