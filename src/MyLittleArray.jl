module MyLittleArray

importall Base

abstract AbstractLittleVector
abstract AbstractLittleMatrix

include("dimension3.jl")
include("dimension2.jl")

unit(V::AbstractLittleVector) = V / norm(V)

MyVector(a,b) = MyVector2(a,b)
MyVector(a,b,c) = MyVector3(a,b,c)

export AbstractLittleVector, AbstractLittleMatrix
export MyVector
export MyVector3, MyMatrix3, MyDiagonal3
export MyVector2, MyMatrix2, MyDiagonal2

end # module
