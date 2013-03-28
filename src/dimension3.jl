immutable MyLittleVector3 <: AbstractLittleVector
    e1::Float64
    e2::Float64
    e3::Float64
end

immutable MyLittleMatrix3 <: AbstractLittleMatrix
    e11::Float64
    e12::Float64
    e13::Float64
    e21::Float64
    e22::Float64
    e23::Float64
    e31::Float64
    e32::Float64
    e33::Float64
end

immutable MyLittleDiagonal3 <: AbstractLittleMatrix
    e11::Float64
    e22::Float64
    e33::Float64
end


MyLittleMatrix3(A::MyLittleDiagonal3) = MyLittleMatrix3(A.e11,0.0,0.0,0.0,A.e22,0.0,0.0,0.0,A.e33)
MyLittleDiagonal3(V::MyLittleVector3) = MyLittleDiagonal3(V.e1, V.e2, V.e3)


function getindex(V::MyLittleVector3, i::Integer)
    if i==1
        return V.e1
    elseif i==2
        return V.e2
    elseif i==3
        return V.e3
    else
        throw(BoundsError())    
    end
end

function getindex(A::MyLittleMatrix3, i::Integer, j::Integer)
    if i==1
        return j==1 ? A.e11 : j==2 ? A.e12 : j==3 ? A.e13 : throw(BoundsError())
    elseif i==2
        return j==1 ? A.e21 : j==2 ? A.e22 : j==3 ? A.e23 : throw(BoundsError())
    elseif i==3
        return j==1 ? A.e31 : j==2 ? A.e32 : j==3 ? A.e33 : throw(BoundsError())
    else
        throw(BoundsError())    
    end
end

function getindex(A::MyLittleDiagonal3, i::Integer, j::Integer)
    if i==1
        return j==1 ? A.e11 : j==2 ? 0.0 : j==3 ? 0.0 : throw(BoundsError())
    elseif i==2
        return j==1 ? 0.0 : j==2 ? A.e22 : j==3 ? 0.0 : throw(BoundsError())
    elseif i==3
        return j==1 ? 0.0 : j==2 ? 0.0 : j==3 ? A.e33 : throw(BoundsError())
    else
        throw(BoundsError())    
    end
end


size(V::MyLittleVector3) = (3,)
size(A::MyLittleDiagonal3) = (3,3)
size(A::MyLittleMatrix3) = (3,3)
size(V::MyLittleVector3, N::Integer) = N==1 ? 3 : N>0 ? 1 : error("Invalid dimension")
size(A::MyLittleDiagonal3, N::Integer) = N==1 || N==2 ? 3 : N>0 ? 1 : error("Invalid dimension")
size(A::MyLittleMatrix3, N::Integer) = N==1 || N==2 ? 3 : N>0 ? 1 : error("Invalid dimension")
length(V::MyLittleVector3) = 3
length(A::MyLittleDiagonal3) = 9
length(A::MyLittleMatrix3) = 9


# Functions to make new things

zeros(T::Type{MyLittleVector3}) = MyLittleVector3(0.0, 0.0, 0.0)
zeros(T::Type{MyLittleDiagonal3}) = MyLittleDiagonal3(0.0, 0.0, 0.0)
zeros(T::Type{MyLittleMatrix3}) = MyLittleMatrix3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)

eye(T::Type{MyLittleDiagonal3}) = MyLittleDiagonal3(1.0,1.0,1.0)
eye(T::Type{MyLittleMatrix3}) = MyLittleMatrix3(1.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,1.0)

function RotX(theta::Real) 
    sT = sin(theta)
    cT = cos(theta)
    MyLittleMatrix3(1.0, 0.0, 0.0, 0.0, cT, -sT, 0.0, sT, cT)
end

function RotY(theta::Real) 
    sT = sin(theta)
    cT = cos(theta)
    MyLittleMatrix3(cT, 0.0, -sT, 0.0, 1.0, 0.0, sT, 0.0, cT)
end

function RotZ(theta::Real) 
    sT = sin(theta)
    cT = cos(theta)
    MyLittleMatrix3(cT, -sT, 0.0, sT, cT, 0.0, 0.0, 0.0, 1.0)
end


# Vector functions
norm(V::MyLittleVector3) = sqrt(V.e1^2 + V.e2^2 + V.e3^2)
dot(A::MyLittleVector3, B::MyLittleVector3) = A.e1*B.e1 + A.e2*B.e2 + A.e3*B.e3
function cross(A::MyLittleVector3, B::MyLittleVector3)
    v1 = A.e2*B.e3 - A.e3*B.e2
    v2 = A.e1*B.e3 - A.e3*B.e1
    v3 = A.e1*B.e2 - A.e2*B.e1
    MyLittleVector3(v1,v2,v3)
end
cos(A::MyLittleVector3, B::MyLittleVector3) = dot(A,B) / norm(A) / norm(B)

# Matrix functions
transpose(A::MyLittleDiagonal3) = A
transpose(A::MyLittleMatrix3) = MyLittleMatrix3(A.e11, A.e21, A.e31, A.e12, A.e22, A.e32, A.e13, A.e23, A.e33)

# Unary operators
-(V::MyLittleVector3) = MyLittleVector3(-V.e1, -V.e2, -V.e3)
-(A::MyLittleDiagonal3) = MyLittleDiagonal3(-A.e11, -A.e22, -A.e33)
-(A::MyLittleMatrix3) = MyLittleMatrix3(-A.e11,-A.e12,-A.e13,-A.e21,-A.e22,-A.e23,-A.e31,-A.e32,-A.e33)


# vector-vector operations
+(A::MyLittleVector3, B::MyLittleVector3) = MyLittleVector3(A.e1+B.e1, A.e2+B.e2, A.e3+B.e3)
-(A::MyLittleVector3, B::MyLittleVector3) = MyLittleVector3(A.e1-B.e1, A.e2-B.e2, A.e3-B.e3)
.*(A::MyLittleVector3, B::MyLittleVector3) = MyLittleVector3(A.e1*B.e1, A.e2*B.e2, A.e3*B.e3)
./(A::MyLittleVector3, B::MyLittleVector3) = MyLittleVector3(A.e1/B.e1, A.e2/B.e2, A.e3/B.e3)
.^(A::MyLittleVector3, B::MyLittleVector3) = MyLittleVector3(A.e1^B.e1, A.e2^B.e2, A.e3^B.e3)


# Scalar-vector operations
*(a::Real, V::MyLittleVector3) = MyLittleVector3(a*V.e1, a*V.e2, a*V.e3)
*(V::MyLittleVector3, a::Real) = *(a,V)
+(a::Real, V::MyLittleVector3) = MyLittleVector3(a+V.e1, a+V.e2, a+V.e3)
+(V::MyLittleVector3, a::Real) = +(a,V)
-(a::Real, V::MyLittleVector3) = MyLittleVector3(a-V.e1, a-V.e2, a-V.e3)
-(V::MyLittleVector3, a::Real) = MyLittleVector3(V.e1-a, V.e2-a, V.e3-a)

/(V::MyLittleVector3, a::Real) = MyLittleVector3(V.e1/a, V.e2/a, V.e3/a)
./(V::MyLittleVector3, a::Real) = MyLittleVector3(V.e1/a, V.e2/a, V.e3/a)
/(a::Real, V::MyLittleVector3) = MyLittleVector3(a/V.e1, a/V.e2, a/V.e3)
./(a::Real, V::MyLittleVector3) = MyLittleVector3(a/V.e1, a/V.e2, a/V.e3)

.^(V::MyLittleVector3, a::Real) = MyLittleVector3(V.e1^a, V.e2^a, V.e3^a)
.^(a::Real, V::MyLittleVector3) = MyLittleVector3(a^V.e1, a^V.e2, a^V.e3)

# Scalar-diagonal operations
*(a::Real, V::MyLittleDiagonal3) = MyLittleDiagonal3(a*V.e11, a*V.e22, a*V.e33)
*(V::MyLittleDiagonal3, a::Real) = *(a,V)
+(a::Real, V::MyLittleDiagonal3) = MyLittleDiagonal3(a+V.e11, a+V.e22, a+V.e33)
+(V::MyLittleDiagonal3, a::Real) = +(a,V)
-(a::Real, V::MyLittleDiagonal3) = MyLittleDiagonal3(a-V.e11, a-V.e22, a-V.e33)
-(V::MyLittleDiagonal3, a::Real) = MyLittleDiagonal3(V.e11-a, V.e22-a, V.e33-a)
/(V::MyLittleDiagonal3, a::Real) = MyLittleDiagonal3(V.e11/a, V.e22/a, V.e33/a)
./(a::Real, V::MyLittleDiagonal3) = MyLittleDiagonal3(a/V.e11, a/V.e22, a/V.e33)
.^(V::MyLittleDiagonal3, a::Real) = MyLittleDiagonal3(V.e11^a, V.e22^a, V.e33^a)
.^(a::Real, V::MyLittleDiagonal3) = MyLittleDiagonal3(a^V.e1, a^V.e2, a^V.e3)


# Matrix-vector products

*(A::MyLittleDiagonal3, V::MyLittleVector3) = MyLittleVector3(A.e11*V.e1, A.e22*V.e2, A.e33*V.e3)

function *(A::MyLittleMatrix3, V::MyLittleVector3)
    v1 = A.e11 * V.e1 + A.e12 * V.e2 + A.e13 * V.e3
    v2 = A.e21 * V.e1 + A.e22 * V.e2 + A.e23 * V.e3
    v3 = A.e31 * V.e1 + A.e32 * V.e2 + A.e33 * V.e3
    return MyLittleVector3(v1, v2, v3)
end


# Matrix-matrix products

*(A::MyLittleDiagonal3, B::MyLittleDiagonal3) = MyLittleDiagonal3(A.e11*B.e11, A.e22*B.e22, A.e33*B.e33)

function *(A::MyLittleMatrix3, B::MyLittleDiagonal3)
    c11 = A.e11 * B.e11
    c12 = A.e12 * B.e22
    c13 = A.e13 * B.e33
    c21 = A.e21 * B.e11
    c22 = A.e22 * B.e22
    c23 = A.e23 * B.e33
    c31 = A.e31 * B.e11
    c32 = A.e32 * B.e22
    c33 = A.e33 * B.e33
    return MyLittleMatrix3(c11,c12,c13,c21,c22,c23,c31,c32,c33)
end

function *(A::MyLittleMatrix3, B::MyLittleDiagonal3)
    c11 = A.e11 * B.e11
    c12 = A.e11 * B.e12
    c13 = A.e11 * B.e13
    c21 = A.e22 * B.e21
    c22 = A.e22 * B.e22
    c23 = A.e22 * B.e23
    c31 = A.e33 * B.e31
    c32 = A.e33 * B.e32
    c33 = A.e33 * B.e33
    return MyLittleMatrix3(c11,c12,c13,c21,c22,c23,c31,c32,c33)
end

function *(A::MyLittleMatrix3, B::MyLittleMatrix3)
    c11 = A.e11 * B.e11  +  A.e12 * B.e21  +  A.e13 * B.e31
    c12 = A.e11 * B.e12  +  A.e12 * B.e22  +  A.e13 * B.e32
    c13 = A.e11 * B.e13  +  A.e12 * B.e23  +  A.e13 * B.e33
    c21 = A.e21 * B.e11  +  A.e22 * B.e21  +  A.e23 * B.e31
    c22 = A.e21 * B.e12  +  A.e22 * B.e22  +  A.e23 * B.e32
    c23 = A.e21 * B.e13  +  A.e22 * B.e23  +  A.e23 * B.e33
    c31 = A.e31 * B.e11  +  A.e32 * B.e21  +  A.e33 * B.e31
    c32 = A.e31 * B.e12  +  A.e32 * B.e22  +  A.e33 * B.e32
    c33 = A.e31 * B.e13  +  A.e32 * B.e23  +  A.e33 * B.e33
    return MyLittleMatrix3(c11,c12,c13,c21,c22,c23,c31,c32,c33)
end
