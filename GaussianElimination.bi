#include once "Matrix.bi"
#include once "RationalMatrix.bi"

Declare Function GaussianElimination OverLoad(ByRef A As Matrix)As Matrix
Declare Function GaussianElimination OverLoad(ByRef A As RationalMatrix)As RationalMatrix
