#include once "Rational.bi"

Constructor Rational()
	this.m = 0
	this.n = 1
End Constructor

Constructor Rational(ByVal m As Integer, ByVal n As Integer)
	this.m = m
	this.n = n
End Constructor

' Сокращение дробей
Sub Rational.Reduction()
	' Если числитель равен нулю, то единицу в знаменатель
	If m = 0 Then
		n = 1
		Exit Sub
	End If
	
	' Сокращение равных числителя и знаменателя
	If m = n Then
		m = 1
		n = 1
		Exit Sub
	End If
	
	' Перенести минус в числитель
	If n < 0 Then
		m *= -1
		n *= -1
	End If
	
	' Сохранить знак числителя
	Dim Sign As Integer = Any
	If m < 0 Then
		Sign = -1
		m *= Sign
	Else
		Sign = 1
	End If
	
	' Сокращение дробей
	Dim gcd As Integer = GreatestCommonDivisor(m, n)
	m \= gcd
	n \= gcd
	
	' Вернуть знак числителю
	m *= Sign
End Sub

Operator +(ByRef leftRational As Rational, ByRef rigthRational As Rational)As Rational
	Dim result As Rational = Any
	If leftRational.n = rigthRational.n Then
		result.n = leftRational.n
		result.m = leftRational.m + rigthRational.m
	Else
		' Привести к общему знаменателю
		result.n = leftRational.n * rigthRational.n
		result.m = leftRational.m * result.n \ leftRational.n + rigthRational.m * result.n \ rigthRational.n
	End If
	
	result.Reduction()
	Return result
End Operator

Operator -(ByRef leftRational As Rational, ByRef rigthRational As Rational)As Rational
	Dim result As Rational = Any
	If leftRational.n = rigthRational.n Then
		result.n = leftRational.n
		result.m = leftRational.m - rigthRational.m
	Else
		' Привести к общему знаменателю
		result.n = leftRational.n * rigthRational.n
		result.m = leftRational.m * result.n \ leftRational.n - rigthRational.m * result.n \ rigthRational.n
	End If
	
	result.Reduction()
	Return result
End Operator

Operator -(ByRef leftRational As Rational)As Rational
	Dim result As Rational = Any
	
	result.m = -leftRational.m
	result.n = leftRational.n
	
	Return result
End Operator

Operator *(ByRef leftRational As Rational, ByRef rigthRational As Rational)As Rational
	Dim result As Rational = Any
	
	result.m = leftRational.m * rigthRational.m
	result.n = leftRational.n * rigthRational.n
	
	result.Reduction()
	Return result
End Operator

Operator *(ByRef leftRational As Integer, ByRef rigthRational As Rational)As Rational
	Dim result As Rational = Any
	
	result.m = leftRational * rigthRational.m
	result.n = rigthRational.n
	
	result.Reduction()
	Return result
End Operator

Operator >(ByRef leftRational As Rational, ByRef rigthRational As Rational)As Boolean
	If leftRational.n = rigthRational.n Then
		If leftRational.m > rigthRational.m Then
			Return True
		End If
	Else
		var n = leftRational.n * rigthRational.n
		var m1 = leftRational.m * n \ leftRational.n
		var m2 = rigthRational.m * n \ rigthRational.n
		If m1 > m2 Then
			Return True
		End If
	End If
	
	Return False
End Operator

Operator \(ByRef leftRational As Rational, ByRef rigthRational As Rational)As Rational
	Dim result As Rational = Any
	
	result.m = leftRational.m * rigthRational.n
	result.n = leftRational.n * rigthRational.m
	
	result.Reduction()
	Return result
End Operator

Operator /(ByRef leftRational As Rational, ByRef rigthRational As Rational)As Rational
	Return leftRational \ rigthRational
End Operator

Operator Abs(ByRef leftRational As Rational)As Rational
	Dim result As Rational = Any
	
	result.m = Abs(leftRational.m)
	result.n = leftRational.n
	
	Return result
End Operator

Function GreatestCommonDivisor(ByVal a As Integer, ByVal b As Integer)As Integer
	Do While b <> 0
		Dim r As Integer = b
		b = a Mod b
		a = r
	Loop
	Return a
End Function
