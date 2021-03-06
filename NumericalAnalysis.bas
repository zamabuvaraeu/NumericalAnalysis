#include once "NumericalAnalysis.bi"

Sub PrintHelp()
	Print "Использование: NumericalAnalysis.exe <метод решения>"
	Print "На стандартный ввод подаётся матрица m * n"
	Print "где <метод решения>:"
	Print "gaussian", "метод Гаусса"
	Print "gaussian2", "метод Гаусса с выбором главного элемента по столбцу"
	Print "rotation", "метод вращений"
	Print "squares", "метод квадратных корней"
End Sub

Sub Gaussian(ByRef A As Matrix)
	var ResultX = GaussianElimination(A)
	Print "Решение"
	PrintMatrix(ResultX)
	
	Print
	
	var Residual = GetResidual(A, ResultX)
	Print "Вектор невязки"
	PrintMatrix(Residual)
End Sub

Sub Gaussian2(ByRef A As Matrix)
	var ResultX = GaussianEliminationWithMainColumns(A)
	Print "Решение"
	PrintMatrix(ResultX)
	
	Print
	
	var Residual = GetResidual(A, ResultX)
	Print "Вектор невязки"
	PrintMatrix(Residual)
End Sub

Sub Rotation(ByRef A As Matrix)
	var ResultX = RotationElimination(A)
	Print "Решение"
	PrintMatrix(ResultX)
	
	Print
	
	var Residual = GetResidual(A, ResultX)
	Print "Вектор невязки"
	PrintMatrix(Residual)
End Sub

Sub Squares(ByRef A As Matrix)
	For Row As Integer = 1 To A.RowsCount - 1
		For Col As Integer = 1 To A.ColsCount - 2
			If Abs(A.GetValue(Row, Col) - A.GetValue(Col, Row)) > 0.0000000000001d Then
				Print "Несимметричная матрица"
				Exit Sub
			End If
		Next
	Next
	
	var ResultX = SquaresElimination(A)
	' Print "Решение"
	' PrintMatrix(ResultX)
	
	Print
	
	var Residual = GetResidual(A, ResultX)
	' Print "Вектор невязки"
	' PrintMatrix(Residual)
End Sub

Dim LinesCount As Long = Any
Dim Lines As WString Ptr Ptr = CommandLineToArgvW(GetCommandLine(), @LinesCount)

If LinesCount < 2 Then
	PrintHelp()
	End(0)
End If

var A = GetMatrix(GetStdHandle(STD_INPUT_HANDLE))
PrintMatrix(A)

Print

Select Case *Lines[1]
	Case "gaussian"
		Gaussian(A)
	Case "gaussian2"
		Gaussian2(A)
	Case "rotation"
		Rotation(A)
	Case "squares"
		Squares(A)
End Select

LocalFree(Lines)