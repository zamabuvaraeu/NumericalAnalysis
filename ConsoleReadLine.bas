#include once "ConsoleReadLine.bi"

#include once "win\shlwapi.bi"

Const EOFChar As Integer = 26

Const vbCrLf = !"\r\n"

' Читает строку из консоли и записывает её в буфер
' Если вывод перенаправлен, то читает из стандартного потока ввода
' При этом перекодирует байты в соответствии с текущей кодировкой
' Возвращает False если ввод завершён
Function ConsoleReadLine(ByVal InHandle As Handle, ByVal ReadedLine As WString Ptr)As Boolean
	
	Dim CharsReaded As DWORD = Any
	
	If ReadConsole(InHandle, ReadedLine, ReadConsoleBufferMaxLength, @CharsReaded, 0) <> 0 Then
		ReadedLine[CharsReaded] = 0
		
		Dim wEOF As WString Ptr = StrChr(ReadedLine, EOFChar)
		If wEOF <> 0 Then
			wEOF[0] = 0
			Return False
		End If
		
		' Dim wCrLf As WString Ptr = StrStr(ReadedLine, @vbCrLf)
		' If wCrLf <> 0 Then
			' wCrLf[0] = 0
		' End If
		
	Else
		Dim FileBytes As ZString * (ReadConsoleBufferMaxLength + 1) = Any
		Dim BytesReaded As DWORD = Any
		
		If ReadFile(InHandle, @FileBytes, ReadConsoleBufferMaxLength, @BytesReaded, 0) = 0 Then
			ReadedLine[0] = 0
			Return False
		End If
		
		If BytesReaded = 0 Then
			ReadedLine[0] = 0
			Return False
		End If
		
		FileBytes[BytesReaded] = 0
		
		MultiByteToWideChar(GetConsoleCP(), 0, @FileBytes, -1, ReadedLine, ReadConsoleBufferMaxLength + 1)
		
	End If
	
	Return True
	
End Function
