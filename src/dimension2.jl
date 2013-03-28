immutable MyLittleVector2 <: AbstractLittleVector
    e1::Float64
    e2::Float64
end

immutable MyLittleMatrix2 <: AbstractLittleMatrix
    e11::Float64
    e12::Float64
    e21::Float64
    e22::Float64
end

immutable MyLittleDiagonal2 <: AbstractLittleMatrix
    e11::Float64
    e22::Float64
end


MyLittleMatrix2(A::MyLittleDiagonal2) = MyLittleMatrix2(A.e11,0.0,0.0,A.e22)
MyLittleDiagonal2(V::MyLittleVector2) = MyLittleDiagonal2(V.e1, V.e2)


function getindex(V::MyLittleVector2, i::Integer)
    if i==1
        return V.e1
    elseif i==2
        return V.e2
    else
        throw(BoundsError)    
    end
end

function getindex(A::MyLittleMatrix2, i::Integer, j::Integer)
    if i==1
        return j==1 ? A.e11 : j==2 ? A.e12 : throw(BoundsError)
    elseif i==2
        return j==1 ? A.e21 : j==2 ? A.e22 : throw(BoundsError)
    else
        throw(BoundsError)    
    end
end

function getindex(A::MyLittleDiagonal2, i::Integer, j::Integer)
    if i==1
        return j==1 ? A.e11 : j==2 ? 0.0 : throw(BoundsError)
    elseif i==2
        return j==1 ? 0.0 : j==2 ? A.e22 : throw(BoundsError)
    else
        throw(BoundsError)    
    end
end


size(V::MyLittleVector2) = (2,)
size(A::MyLittleDiagonal2) = (2,2)
size(A::MyLittleMatrix2) = (2,2)
size(V::MyLittleVector2, N::Integer) = N==1 ? 2 : error("Invalid dimension")
size(A::MyLittleDiagonal2, N::Integer) = N==1 || N==2 ? 2 : error("Invalid dimension")
size(A::MyLittleMatrix2, N::Integer) = N==1 || N==2 ? 2 : error("Invalid dimension")
length(V::MyLittleVector2) = 2
length(A::MyLittleDiagonal2) = 4
length(A::MyLittleMatrix2) = 4


# Functions to make new things

zeros(T::Type{MyLittleVector2}) = MyLittleVector2(0.0, 0.0)
zeros(T::Type{MyLittleDiagonal2}) = MyLittleDiagonal2(0.0, 0.0)
zeros(T::Type{MyLittleMatrix2}) = MyLittleMatrix2(0.0, 0.0, 0.0, 0.0)

eye(T::Type{MyLittleDiagonal2}) = MyLittleDiagonal2(1.0,1.0)
eye(T::Type{MyLittleMatrix2}) = MyLittleMatrix2(1.0,0.0,0.0,1.0)

function Rot(theta::Real) 
    sT = sin(theta)
    cT = cos(theta)
    MyLittleMatrix2(cT, -sT, sT, cT)
end




# Vector functions
norm(V::MyLittleVector2) = sqrt(V.e1^2 + V.e2^2)
dot(A::MyLittleVector2, B::MyLittleVector2) = A.e1*B.e1 + A.e2*B.e2


# Matrix functions
transpose(A::MyLittleDiagonal2) = A
transpose(A::MyLittleMatrix2) = MyLittleMatrix2(A.e11, A.e21, A.e12, A.e22)

# Unary operators
-(V::MyLittleVector2) = MyLittleVector2(-V.e1, -V.e2)
-(A::MyLittleDiagonal2) = MyLittleDiagonal2(-A.e11, -A.e22)
-(A::MyLittleMatrix2) = MyLittleMatrix2(-A.e11,-A.e12,-A.e21,-A.e22)


# Scalar-vector operations
*(a::Real, V::MyLittleVector2) = MyLittleVector2(a*V.e1, a*V.e2)
*(V::MyLittleVector2, a::Real) = *(a,V)
+(a::Real, V::MyLittleVector2) = MyLittleVector2(a+V.e1, a+V.e2)
+(V::MyLittleVector2, a::Real) = +(a,V)
-(a::Real, V::MyLittleVector2) = MyLittleVector2(a-V.e1, a-V.e2)
-(V::MyLittleVector2, a::Real) = MyLittleVector2(V.e1-a, V.e2-a)
/(V::MyLittleVector2, a::Real) = MyLittleVector2(V.e1/a, V.e2/a)
./(a::Real, V::MyLittleVector2) = MyLittleVector2(a/V.e1, a/V.e2)
.^(V::MyLittleVector2, a::Real) = MyLittleVector2(V.e1^a, V.e2^a)
.^(a::Real, V::MyLittleVector2) = MyLittleVector2(a^V.e1, a^V.e2)

# Scalar-diagonal operations
*(a::Real, V::MyLittleDiagonal2) = MyLittleDiagonal2(a*V.e1, a*V.e2)
*(V::MyLittleDiagonal2, a::Real) = *(a,V)
+(a::Real, V::MyLittleDiagonal2) = MyLittleDiagonal2(a+V.e1, a+V.e2)
+(V::MyLittleDiagonal2, a::Real) = +(a,V)
-(a::Real, V::MyLittleDiagonal2) = MyLittleDiagonal2(a-V.e1, a-V.e2)
-(V::MyLittleDiagonal2, a::Real) = MyLittleDiagonal2(V.e1-a, V.e2-a)
/(V::MyLittleDiagonal2, a::Real) = MyLittleDiagonal2(V.e1/a, V.e2/a)
./(a::Real, V::MyLittleDiagonal2) = MyLittleDiagonal2(a/V.e1, a/V.e2)
.^(V::MyLittleDiagonal2, a::Real) = MyLittleDiagonal2(V.e1^a, V.e2^a)
.^(a::Real, V::Matrix) = MyLittleDiagonal2(a^V.e1, a^V.e2)


# Matrix-vector products

*(A::MyLittleDiagonal2, V::MyLittleVector2) = MyLittleVector2(A.e11*V.e1, A.e22*V.e2)

function *(A::MyLittleMatrix2, V::MyLittleVector2)
    v1 = A.e11 * V.e1 + A.e12 * V.e2
    v2 = A.e21 * V.e1 + A.e22 * V.e2
    return MyLittleVector2(v1, v2)
end


# Matrix-matrix products

*(A::MyLittleDiagonal2, B::MyLittleDiagonal2) = MyLittleDiagonal2(A.e11*B.e11, A.e22*B.e22)

function *(A::MyLittleMatrix2, B::MyLittleDiagonal2)
    c11 = A.e11 * B.e11
    c12 = A.e12 * B.e22
    c21 = A.e21 * B.e11
    c22 = A.e22 * B.e22
    return MyLittleMatrix2(c11,c12,c21,c22)
end

function *(A::MyLittleMatrix2, B::MyLittleDiagonal2)
    c11 = A.e11 * B.e11
    c12 = A.e11 * B.e12
    c21 = A.e22 * B.e21
    c22 = A.e22 * B.e22
    return MyLittleMatrix2(c11,c12,c21,c22)
end

function *(A::MyLittleMatrix2, B::MyLittleMatrix2)
    c11 = A.e11 * B.e11  +  A.e12 * B.e21
    c12 = A.e11 * B.e12  +  A.e12 * B.e22
    c21 = A.e21 * B.e11  +  A.e22 * B.e21
    c22 = A.e21 * B.e12  +  A.e22 * B.e22
    return MyLittleMatrix2(c11,c12,c21,c22)
end
