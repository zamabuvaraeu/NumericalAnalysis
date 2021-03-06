#ifndef __rational__
#define __rational__

' Рациональное число
Type Rational
	Declare Constructor()
	Declare Constructor(ByVal m As Integer, ByVal n As Integer)
	' Числитель, целое
	Dim m As Integer
	' Знаменатель, натуральное
	Dim n As Integer
	
	' Сокращение дробей
	Declare Sub Reduction()
End Type

Declare Operator -(ByRef leftRational As Rational, ByRef rigthRational As Rational)As Rational

Declare Operator -(ByRef leftRational As Rational)As Rational

Declare Operator +(ByRef leftRational As Rational, ByRef rigthRational As Rational)As Rational

Declare Operator *(ByRef leftRational As Rational, ByRef rigthRational As Rational)As Rational

Declare Operator *(ByRef leftRational As Integer, ByRef rigthRational As Rational)As Rational

Declare Operator \(ByRef leftRational As Rational, ByRef rigthRational As Rational)As Rational

Declare Operator /(ByRef leftRational As Rational, ByRef rigthRational As Rational)As Rational

Declare Operator Abs(ByRef leftRational As Rational)As Rational

Declare Operator >(ByRef leftRational As Rational, ByRef rigthRational As Rational)As Boolean

Declare Function GreatestCommonDivisor(ByVal a As Integer, ByVal b As Integer)As Integer

#endif