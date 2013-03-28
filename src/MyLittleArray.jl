module MyLittleArray

importall Base

abstract AbstractLittleVector
abstract AbstractLittleMatrix

include("dimension3.jl")
include("dimension2.jl")
include("dimension4.jl")

unit(V::AbstractLittleVector) = V / norm(V)

MyLittleVector(a,b) = MyLittleVector2(a,b)
MyLittleVector(a,b,c) = MyLittleVector3(a,b,c)
MyLittleVector(a,b,c,d) = MyLittleVector4(a,b,c,d)

export AbstractLittleVector, AbstractLittleMatrix
export MyLittleVector
export MyLittleVector2, MyLittleMatrix2, MyLittleDiagonal2
export MyLittleVector3, MyLittleMatrix3, MyLittleDiagonal3
export MyLittleVector4, MyLittleMatrix4, MyLittleDiagonal4

end # module
