#ifndef unicode
#define unicode
#endif
#include once "windows.bi"
#include once "win\shlwapi.bi"
#include once "win\shellapi.bi"

#include once "LoadMatrix.bi"
#include once "ConsoleReadLine.bi"

Const vbCrLf = !"\r\n"

Sub LoadRowFromString(ByRef A As Matrix, ByVal CurrentRow As Integer, ByVal MatrixString As WString Ptr)
	Dim WordsCount As Long = Any
	Dim Lines As WString Ptr Ptr = CommandLineToArgvW(MatrixString, @WordsCount)
	
	For i As Integer = 0 To A.ColsCount - 1
		A.SetValue(CurrentRow, i, CDbl(*Lines[i]))
	Next
	
	LocalFree(Lines)
End Sub

Sub LoadRationalRowFromString(ByRef A As RationalMatrix, ByVal CurrentRow As Integer, ByVal MatrixString As WString Ptr)
	Dim WordsCount As Long = Any
	Dim Lines As WString Ptr Ptr = CommandLineToArgvW(MatrixString, @WordsCount)
	
	For i As Integer = 0 To A.ColsCount - 1
		var fractional = CDbl(*Lines[i])
		var m = CInt(*Lines[i])
		var n = 1
		
		Dim w As WString Ptr = StrStr(*Lines[i], ".")
		If w <> 0 Then
			w[0] = 0
			w += 1
			
			Dim k As Integer = Len(*w)
			n = 10 ^ k
			If m >= 0 Then
				m = Sgn(fractional) * Abs(m * n + CInt(*w))
			Else
				m = Sgn(fractional) * Abs(m * n - CInt(*w))
			End If
		End If
		
		A.SetValue(CurrentRow, i, Type<Rational>(m, n))
	Next
	
	LocalFree(Lines)
End Sub

Function GetMatrix(ByVal InHandle As Handle)As Matrix
	Dim MatrixString As WString * (ReadConsoleBufferMaxLength + 1) = Any
	Dim MatrixStringLength As Integer = 0
	
	' Прочитать данные до конца
	' Либо конец файла, либо конец консоли
	Do While ConsoleReadLine(InHandle, @MatrixString + MatrixStringLength)
		MatrixStringLength = Len(MatrixString)
	Loop
	
	Dim CurrentRow As Integer
	Dim wStart As WString Ptr = @MatrixString
	
	Dim wCrLf As WString Ptr = StrStr(wStart, @vbCrLf)
	If wCrLf <> 0 Then
		wCrLf[0] = 0
	End If
	
	Dim MatrixLength As Long = Any
	Dim Lines As WString Ptr Ptr = CommandLineToArgvW(wStart, @MatrixLength)
	
	Dim A As Matrix = Type<Matrix>(CInt(*Lines[0]), CInt(*Lines[1]))
	LocalFree(Lines)
	
	wStart = wCrLf + 2
	wCrLf = StrStr(wStart, @vbCrLf)
	
	Do
		wCrLf[0] = 0
		LoadRowFromString(A, CurrentRow, wStart)
		CurrentRow += 1
		
		wStart = wCrLf + 2
		
		wCrLf = StrStr(wStart, @vbCrLf)
		
	Loop While wCrLf <> 0
	
	If Len(*wStart) <> 0 Then
		LoadRowFromString(A, CurrentRow, wStart)
	End If
	
	Return A
End Function

Function GetRationalMatrix(ByVal InHandle As Handle)As RationalMatrix
	Dim MatrixString As WString * (ReadConsoleBufferMaxLength + 1) = Any
	Dim MatrixStringLength As Integer = 0
	
	' Прочитать данные до конца
	' Либо конец файла, либо конец консоли
	Do While ConsoleReadLine(InHandle, @MatrixString + MatrixStringLength)
		MatrixStringLength = Len(MatrixString)
	Loop
	
	Dim CurrentRow As Integer
	Dim wStart As WString Ptr = @MatrixString
	
	Dim wCrLf As WString Ptr = StrStr(wStart, @vbCrLf)
	If wCrLf <> 0 Then
		wCrLf[0] = 0
	End If
	
	Dim MatrixLength As Long = Any
	Dim Lines As WString Ptr Ptr = CommandLineToArgvW(wStart, @MatrixLength)
	
	Dim A As RationalMatrix = Type<RationalMatrix>(CInt(*Lines[0]), CInt(*Lines[1]))
	LocalFree(Lines)
	
	wStart = wCrLf + 2
	wCrLf = StrStr(wStart, @vbCrLf)
	
	Do
		wCrLf[0] = 0
		LoadRationalRowFromString(A, CurrentRow, wStart)
		CurrentRow += 1
		
		wStart = wCrLf + 2
		
		wCrLf = StrStr(wStart, @vbCrLf)
		
	Loop While wCrLf <> 0
	
	If Len(*wStart) <> 0 Then
		LoadRationalRowFromString(A, CurrentRow, wStart)
	End If
	
	Return A
End Function