immutable MyVector2 <: AbstractLittleVector
    e1::Float64
    e2::Float64
end

immutable MyMatrix2 <: AbstractLittleMatrix
    e11::Float64
    e12::Float64
    e21::Float64
    e22::Float64
end

immutable MyDiagonal2 <: AbstractLittleMatrix
    e11::Float64
    e22::Float64
end


MyMatrix2(A::MyDiagonal2) = MyMatrix2(A.e11,0.0,0.0,A.e22)
MyDiagonal2(V::MyVector2) = MyDiagonal2(V.e1, V.e2)


function getindex(V::MyVector2, i::Integer)
    if i==1
        return V.e1
    elseif i==2
        return V.e2
    else
        error("Invalid index")    
    end
end

function getindex(A::MyMatrix2, i::Integer, j::Integer)
    if i==1
        return j==1 ? A.e11 : j==2 ? A.e12 : error("Invalid index")
    elseif i==2
        return j==1 ? A.e21 : j==2 ? A.e22 : error("Invalid index")
    else
        error("Invalid index")    
    end
end

function getindex(A::MyDiagonal2, i::Integer, j::Integer)
    if i==1
        return j==1 ? A.e11 : j==2 ? 0.0 : error("Invalid index")
    elseif i==2
        return j==1 ? 0.0 : j==2 ? A.e22 : error("Invalid index")
    else
        error("Invalid index")    
    end
end


size(V::MyVector2) = (2,)
size(A::MyDiagonal2) = (2,2)
size(A::MyMatrix2) = (2,2)
size(V::MyVector2, N::Integer) = N==1 ? 2 : error("Invalid dimension")
size(A::MyDiagonal2, N::Integer) = N==1 || N==2 ? 2 : error("Invalid dimension")
size(A::MyMatrix2, N::Integer) = N==1 || N==2 ? 2 : error("Invalid dimension")
length(V::MyVector2) = 2
length(A::MyDiagonal2) = 4
length(A::MyMatrix2) = 4


# Functions to make new things

zeros(T::Type{MyVector2}) = MyVector2(0.0, 0.0)
zeros(T::Type{MyDiagonal2}) = MyDiagonal2(0.0, 0.0)
zeros(T::Type{MyMatrix2}) = MyMatrix2(0.0, 0.0, 0.0, 0.0)

eye(T::Type{MyDiagonal2}) = MyDiagonal2(1.0,1.0)
eye(T::Type{MyMatrix2}) = MyMatrix2(1.0,0.0,0.0,1.0)

function Rot(theta::Real) 
    sT = sin(theta)
    cT = cos(theta)
    MyMatrix2(cT, -sT, sT, cT)
end




# Vector functions
norm(V::MyVector2) = sqrt(V.e1^2 + V.e2^2)
dot(A::MyVector2, B::MyVector2) = A.e1*B.e1 + A.e2*B.e2


# Matrix functions
transpose(A::MyDiagonal2) = A
transpose(A::MyMatrix2) = MyMatrix2(A.e11, A.e21, A.e12, A.e22)

# Unary operators
-(V::MyVector2) = MyVector2(-V.e1, -V.e2)
-(A::MyDiagonal2) = MyDiagonal2(-A.e11, -A.e22)
-(A::MyMatrix2) = MyMatrix2(-A.e11,-A.e12,-A.e21,-A.e22)


# Scalar-vector operations
*(a::Real, V::MyVector2) = MyVector2(a*V.e1, a*V.e2)
*(V::MyVector2, a::Real) = *(a,V)
+(a::Real, V::MyVector2) = MyVector2(a+V.e1, a+V.e2)
+(V::MyVector2, a::Real) = +(a,V)
-(a::Real, V::MyVector2) = MyVector2(a-V.e1, a-V.e2)
-(V::MyVector2, a::Real) = MyVector2(V.e1-a, V.e2-a)
/(V::MyVector2, a::Real) = MyVector2(V.e1/a, V.e2/a)
./(a::Real, V::MyVector2) = MyVector2(a/V.e1, a/V.e2)
.^(V::MyVector2, a::Real) = MyVector2(V.e1^a, V.e2^a)
.^(a::Real, V::MyVector2) = MyVector2(a^V.e1, a^V.e2)

# Scalar-diagonal operations
*(a::Real, V::MyDiagonal2) = MyDiagonal2(a*V.e1, a*V.e2)
*(V::MyDiagonal2, a::Real) = *(a,V)
+(a::Real, V::MyDiagonal2) = MyDiagonal2(a+V.e1, a+V.e2)
+(V::MyDiagonal2, a::Real) = +(a,V)
-(a::Real, V::MyDiagonal2) = MyDiagonal2(a-V.e1, a-V.e2)
-(V::MyDiagonal2, a::Real) = MyDiagonal2(V.e1-a, V.e2-a)
/(V::MyDiagonal2, a::Real) = MyDiagonal2(V.e1/a, V.e2/a)
./(a::Real, V::MyDiagonal2) = MyDiagonal2(a/V.e1, a/V.e2)
.^(V::MyDiagonal2, a::Real) = MyDiagonal2(V.e1^a, V.e2^a)
.^(a::Real, V::Matrix) = MyDiagonal2(a^V.e1, a^V.e2)


# Matrix-vector products

*(A::MyDiagonal2, V::MyVector2) = MyVector2(A.e11*V.e1, A.e22*V.e2)

function *(A::MyMatrix2, V::MyVector2)
    v1 = A.e11 * V.e1 + A.e12 * V.e2
    v2 = A.e21 * V.e1 + A.e22 * V.e2
    return MyVector2(v1, v2)
end


# Matrix-matrix products

*(A::MyDiagonal2, B::MyDiagonal2) = MyDiagonal2(A.e11*B.e11, A.e22*B.e22)

function *(A::MyMatrix2, B::MyDiagonal2)
    c11 = A.e11 * B.e11
    c12 = A.e12 * B.e22
    c21 = A.e21 * B.e11
    c22 = A.e22 * B.e22
    return MyMatrix2(c11,c12,c21,c22)
end

function *(A::MyMatrix2, B::MyDiagonal2)
    c11 = A.e11 * B.e11
    c12 = A.e11 * B.e12
    c21 = A.e22 * B.e21
    c22 = A.e22 * B.e22
    return MyMatrix2(c11,c12,c21,c22)
end

function *(A::MyMatrix2, B::MyMatrix2)
    c11 = A.e11 * B.e11  +  A.e12 * B.e21
    c12 = A.e11 * B.e12  +  A.e12 * B.e22
    c21 = A.e21 * B.e11  +  A.e22 * B.e21
    c22 = A.e21 * B.e12  +  A.e22 * B.e22
    return MyMatrix2(c11,c12,c21,c22)
end
