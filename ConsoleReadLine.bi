#ifndef unicode
#define unicode
#endif
#include once "windows.bi"

' Длина строки для чтения данных с консоли
Const ReadConsoleBufferMaxLength As Integer = 32767

' Читает строку из консоли и записывает её в буфер
' Если вывод перенаправлен, то читает из стандартного потока ввода
' При этом перекодирует байты в соответствии с текущей кодировкой
' Возвращает False если ввод завершён
Declare Function ConsoleReadLine(ByVal InHandle As Handle, ByVal ReadedLine As WString Ptr)As Boolean
