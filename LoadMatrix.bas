#ifndef unicode
#define unicode
#endif
#include once "windows.bi"
#include once "win\shlwapi.bi"
#include once "win\shellapi.bi"

#include once "ConsoleReadLine.bi"
#include once "Matrix.bi"

Const vbCrLf = !"\r\n"

Sub LoadRowFromString(ByRef A As Matrix, ByVal CurrentRow As Integer, ByVal MatrixString As WString Ptr)
	Dim WordsCount As Long = Any
	Dim Lines As WString Ptr Ptr = CommandLineToArgvW(MatrixString, @WordsCount)
	
	For i As Integer = 0 To A.ColsCount - 1
		A.SetValue(CurrentRow, i, CDbl(*Lines[i]))
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
