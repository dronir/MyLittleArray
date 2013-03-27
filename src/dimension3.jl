immutable MyVector3 <: AbstractLittleVector
    e1::Float64
    e2::Float64
    e3::Float64
end

immutable MyMatrix3 <: AbstractLittleMatrix
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

immutable MyDiagonal3 <: AbstractLittleMatrix
    e11::Float64
    e22::Float64
    e33::Float64
end


MyMatrix3(A::MyDiagonal3) = MyMatrix3(A.e11,0.0,0.0,0.0,A.e22,0.0,0.0,0.0,A.e33)
MyDiagonal3(V::MyVector3) = MyDiagonal3(V.e1, V.e2, V.e3)


function getindex(V::MyVector3, i::Integer)
    if i==1
        return V.e1
    elseif i==2
        return V.e2
    elseif i==3
        return V.e3
    else
        error("Invalid index")    
    end
end

function getindex(A::MyMatrix3, i::Integer, j::Integer)
    if i==1
        return j==1 ? A.e11 : j==2 ? A.e12 : j==3 ? A.e13 : error("Invalid index")
    elseif i==2
        return j==1 ? A.e21 : j==2 ? A.e22 : j==3 ? A.e23 : error("Invalid index")
    elseif i==3
        return j==1 ? A.e31 : j==2 ? A.e32 : j==3 ? A.e33 : error("Invalid index")
    else
        error("Invalid index")    
    end
end

function getindex(A::MyDiagonal3, i::Integer, j::Integer)
    if i==1
        return j==1 ? A.e11 : j==2 ? 0.0 : j==3 ? 0.0 : error("Invalid index")
    elseif i==2
        return j==1 ? 0.0 : j==2 ? A.e22 : j==3 ? 0.0 : error("Invalid index")
    elseif i==3
        return j==1 ? 0.0 : j==2 ? 0.0 : j==3 ? A.e33 : error("Invalid index")
    else
        error("Invalid index")    
    end
end


size(V::MyVector3) = (3,)
size(A::MyDiagonal3) = (3,3)
size(A::MyMatrix3) = (3,3)
size(V::MyVector3, N::Integer) = N==1 ? 3 : error("Invalid dimension")
size(A::MyDiagonal3, N::Integer) = N==1 || N==2 ? 3 : error("Invalid dimension")
size(A::MyMatrix3, N::Integer) = N==1 || N==2 ? 3 : error("Invalid dimension")
length(V::MyVector3) = 3
length(A::MyDiagonal3) = 9
length(A::MyMatrix3) = 9


# Functions to make new things

zeros(T::Type{MyVector3}) = MyVector3(0.0, 0.0, 0.0)
zeros(T::Type{MyDiagonal3}) = MyDiagonal3(0.0, 0.0, 0.0)
zeros(T::Type{MyMatrix3}) = MyMatrix3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)

eye(T::Type{MyDiagonal3}) = MyDiagonal3(1.0,1.0,1.0)
eye(T::Type{MyMatrix3}) = MyMatrix3(1.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,1.0)

function RotX(theta::Real) 
    sT = sin(theta)
    cT = cos(theta)
    MyMatrix3(1.0, 0.0, 0.0, 0.0, cT, -sT, 0.0, sT, cT)
end

function RotY(theta::Real) 
    sT = sin(theta)
    cT = cos(theta)
    MyMatrix3(cT, 0.0, -sT, 0.0, 1.0, 0.0, sT, 0.0, cT)
end

function RotZ(theta::Real) 
    sT = sin(theta)
    cT = cos(theta)
    MyMatrix3(cT, -sT, 0.0, sT, cT, 0.0, 0.0, 0.0, 1.0)
end


# Vector functions
norm(V::MyVector3) = sqrt(V.e1^2 + V.e2^2 + V.e3^2)
dot(A::MyVector3, B::MyVector3) = A.e1*B.e1 + A.e2*B.e2 + A.e3*B.e3


# Matrix functions
transpose(A::MyDiagonal3) = A
transpose(A::MyMatrix3) = MyMatrix3(A.e11, A.e21, A.e31, A.e12, A.e22, A.e32, A.e13, A.e23, A.e33)

# Unary operators
-(V::MyVector3) = MyVector3(-V.e1, -V.e2, -V.e3)
-(A::MyDiagonal3) = MyDiagonal3(-A.e11, -A.e22, -A.e33)
-(A::MyMatrix3) = MyMatrix3(-A.e11,-A.e12,-A.e13,-A.e21,-A.e22,-A.e23,-A.e31,-A.e32,-A.e33)


# Scalar-vector operations
*(a::Real, V::MyVector3) = MyVector3(a*V.e1, a*V.e2, a*V.e3)
*(V::MyVector3, a::Real) = *(a,V)
+(a::Real, V::MyVector3) = MyVector3(a+V.e1, a+V.e2, a+V.e3)
+(V::MyVector3, a::Real) = +(a,V)
-(a::Real, V::MyVector3) = MyVector3(a-V.e1, a-V.e2, a-V.e3)
-(V::MyVector3, a::Real) = MyVector3(V.e1-a, V.e2-a, V.e3-a)
/(V::MyVector3, a::Real) = MyVector3(V.e1/a, V.e2/a, V.e3/a)
./(a::Real, V::MyVector3) = MyVector3(a/V.e1, a/V.e2, a/V.e3)
.^(V::MyVector3, a::Real) = MyVector3(V.e1^a, V.e2^a, V.e3^a)
.^(a::Real, V::MyVector3) = MyVector3(a^V.e1, a^V.e2, a^V.e3)

# Scalar-diagonal operations
*(a::Real, V::MyDiagonal3) = MyDiagonal3(a*V.e1, a*V.e2, a*V.e3)
*(V::MyDiagonal3, a::Real) = *(a,V)
+(a::Real, V::MyDiagonal3) = MyDiagonal3(a+V.e1, a+V.e2, a+V.e3)
+(V::MyDiagonal3, a::Real) = +(a,V)
-(a::Real, V::MyDiagonal3) = MyDiagonal3(a-V.e1, a-V.e2, a-V.e3)
-(V::MyDiagonal3, a::Real) = MyDiagonal3(V.e1-a, V.e2-a, V.e3-a)
/(V::MyDiagonal3, a::Real) = MyDiagonal3(V.e1/a, V.e2/a, V.e3/a)
./(a::Real, V::MyDiagonal3) = MyDiagonal3(a/V.e1, a/V.e2, a/V.e3)
.^(V::MyDiagonal3, a::Real) = MyDiagonal3(V.e1^a, V.e2^a, V.e3^a)
.^(a::Real, V::Matrix) = MyDiagonal3(a^V.e1, a^V.e2, a^V.e3)


# Matrix-vector products

*(A::MyDiagonal3, V::MyVector3) = MyVector3(A.e11*V.e1, A.e22*V.e2, A.e33*V.e3)

function *(A::MyMatrix3, V::MyVector3)
    v1 = A.e11 * V.e1 + A.e12 * V.e2 + A.e13 * V.e3
    v2 = A.e21 * V.e1 + A.e22 * V.e2 + A.e23 * V.e3
    v3 = A.e31 * V.e1 + A.e32 * V.e2 + A.e33 * V.e3
    return MyVector3(v1, v2, v3)
end


# Matrix-matrix products

*(A::MyDiagonal3, B::MyDiagonal3) = MyDiagonal3(A.e11*B.e11, A.e22*B.e22, A.e33*B.e33)

function *(A::MyMatrix3, B::MyDiagonal3)
    c11 = A.e11 * B.e11
    c12 = A.e12 * B.e22
    c13 = A.e13 * B.e33
    c21 = A.e21 * B.e11
    c22 = A.e22 * B.e22
    c23 = A.e23 * B.e33
    c31 = A.e31 * B.e11
    c32 = A.e32 * B.e22
    c33 = A.e33 * B.e33
    return MyMatrix3(c11,c12,c13,c21,c22,c23,c31,c32,c33)
end

function *(A::MyMatrix3, B::MyDiagonal3)
    c11 = A.e11 * B.e11
    c12 = A.e11 * B.e12
    c13 = A.e11 * B.e13
    c21 = A.e22 * B.e21
    c22 = A.e22 * B.e22
    c23 = A.e22 * B.e23
    c31 = A.e33 * B.e31
    c32 = A.e33 * B.e32
    c33 = A.e33 * B.e33
    return MyMatrix3(c11,c12,c13,c21,c22,c23,c31,c32,c33)
end

function *(A::MyMatrix3, B::MyMatrix3)
    c11 = A.e11 * B.e11  +  A.e12 * B.e21  +  A.e13 * B.e31
    c12 = A.e11 * B.e12  +  A.e12 * B.e22  +  A.e13 * B.e32
    c13 = A.e11 * B.e13  +  A.e12 * B.e23  +  A.e13 * B.e33
    c21 = A.e21 * B.e11  +  A.e22 * B.e21  +  A.e23 * B.e31
    c22 = A.e21 * B.e12  +  A.e22 * B.e22  +  A.e23 * B.e32
    c23 = A.e21 * B.e13  +  A.e22 * B.e23  +  A.e23 * B.e33
    c31 = A.e31 * B.e11  +  A.e32 * B.e21  +  A.e33 * B.e31
    c32 = A.e31 * B.e12  +  A.e32 * B.e22  +  A.e33 * B.e32
    c33 = A.e31 * B.e13  +  A.e32 * B.e23  +  A.e33 * B.e33
    return MyMatrix3(c11,c12,c13,c21,c22,c23,c31,c32,c33)
end
