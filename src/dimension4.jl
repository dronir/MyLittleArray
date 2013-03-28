immutable MyLittleVector4 <: AbstractLittleVector
    e1::Float64
    e2::Float64
    e3::Float64
    e4::Float64
end

immutable MyLittleMatrix4 <: AbstractLittleMatrix
    e11::Float64
    e12::Float64
    e13::Float64
    e14::Float64
    e21::Float64
    e22::Float64
    e23::Float64
    e24::Float64
    e31::Float64
    e32::Float64
    e33::Float64
    e34::Float64
    e41::Float64
    e42::Float64
    e43::Float64
    e44::Float64
    e45::Float64
end

immutable MyLittleDiagonal4 <: AbstractLittleMatrix
    e11::Float64
    e22::Float64
    e33::Float64
    e44::Float64
end


function MyLittleMatrix4(A::MyLittleDiagonal4)
    return MyLittleMatrix4(A.e11,0.0,0.0,0.0, 0.0,A.e22,0.0,0.0, 0.0,0.0,0.0,A.e33,0.0, 0.0,0.0,0.0,A.e44)
end

MyLittleDiagonal4(V::MyLittleVector4) = MyLittleDiagonal4(V.e1, V.e2, V.e3, V.e4)


function getindex(V::MyLittleVector4, i::Integer)
    if i==1
        return V.e1
    elseif i==2
        return V.e2
    elseif i==3
        return V.e3
    elseif i==4
        return V.e4
    else
        throw(BoundsError)    
    end
end

function getindex(A::MyLittleMatrix4, i::Integer, j::Integer)
    if i==1
        return j==1 ? A.e11 : j==2 ? A.e12 : j==3 ? A.e13 : j==4 ? A.e14 : throw(BoundsError)
    elseif i==2
        return j==1 ? A.e21 : j==2 ? A.e22 : j==3 ? A.e23 : j==4 ? A.e24 : throw(BoundsError)
    elseif i==3
        return j==1 ? A.e31 : j==2 ? A.e32 : j==3 ? A.e33 : j==4 ? A.e34 : throw(BoundsError)
    elseif i==4
        return j==1 ? A.e41 : j==2 ? A.e42 : j==3 ? A.e43 : j==4 ? A.e44 : throw(BoundsError)
    else
        throw(BoundsError)    
    end
end

function getindex(A::MyLittleDiagonal4, i::Integer, j::Integer)
    if i==1
        return j==1 ? A.e11 : j==2 ? 0.0 : j==3 ? 0.0 : j==4 ? 0.0 : throw(BoundsError)
    elseif i==2
        return j==1 ? 0.0 : j==2 ? A.e22 : j==3 ? 0.0 : j==4 ? 0.0 : throw(BoundsError)
    elseif i==3
        return j==1 ? 0.0 : j==2 ? 0.0 : j==3 ? A.e33 : j==4 ? 0.0 : throw(BoundsError)
    elseif i==4
        return j==1 ? 0.0 : j==2 ? 0.0 : j==3 ? 0.0 : j==4 ? A.e44 : throw(BoundsError)
    else
        throw(BoundsError)    
    end
end


size(V::MyLittleVector4) = (4,)
size(A::MyLittleDiagonal4) = (4,4)
size(A::MyLittleMatrix4) = (4,4)
size(V::MyLittleVector4, N::Integer) = N==1 ? 4 : N>0 ? 1 : error("Invalid dimension")
size(A::MyLittleDiagonal4, N::Integer) = N==1 || N==2 ? 4 : N>0 ? 1 : error("Invalid dimension")
size(A::MyLittleMatrix4, N::Integer) = N==1 || N==2 ? 4 : N>0 ? 1 : error("Invalid dimension")
length(V::MyLittleVector4) = 4
length(A::MyLittleDiagonal4) = 16
length(A::MyLittleMatrix4) = 16


# Functions to make new things

zeros(T::Type{MyLittleVector4}) = MyLittleVector4(0.0, 0.0, 0.0, 0.0)
zeros(T::Type{MyLittleDiagonal4}) = MyLittleDiagonal4(0.0, 0.0, 0.0, 0.0)
zeros(T::Type{MyLittleMatrix4}) = MyLittleMatrix4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)

eye(T::Type{MyLittleDiagonal4}) = MyLittleDiagonal4(1.0,1.0,1.0,1.0)
eye(T::Type{MyLittleMatrix4}) = MyLittleMatrix4(1.0,0.0,0.0,0.0, 0.0,1.0,0.0,0.0, 0.0,0.0,1.0,0.0, 0.0,0.0,0.0,1.0)



# Vector functions
norm(V::MyLittleVector4) = sqrt(V.e1^2 + V.e2^2 + V.e3^2 + V.e4^2)
dot(A::MyLittleVector4, B::MyLittleVector4) = A.e1*B.e1 + A.e2*B.e2 + A.e3*B.e3 + A.e4*B.e4


# Matrix functions
transpose(A::MyLittleDiagonal4) = A
transpose(A::MyLittleMatrix4) = MyLittleMatrix4(A.e11, A.e21, A.e31, A.e41, A.e12, A.e22, A.e32, A.e42, A.e13, A.e23, A.e33, A.e43, A.e14, A.e24, A.e34, A.e44)

# Unary operators
-(V::MyLittleVector4) = MyLittleVector4(-V.e1, -V.e2, -V.e3, -V.e4)
-(A::MyLittleDiagonal4) = MyLittleDiagonal4(-A.e11, -A.e22, -A.e33, -A.e44)
-(A::MyLittleMatrix4) = MyLittleMatrix4(-A.e11,-A.e12,-A.e13,-A.e14, -A.e21,-A.e22,-A.e23,-A.e24, -A.e31,-A.e32,-A.e33,-A.e34, -A.e41,-A.e42,-A.e43,-A.e44)


# Scalar-vector operations
*(a::Real, V::MyLittleVector4) = MyLittleVector4(a*V.e1, a*V.e2, a*V.e3, a*V.e4)
*(V::MyLittleVector4, a::Real) = *(a,V)
+(a::Real, V::MyLittleVector4) = MyLittleVector4(a+V.e1, a+V.e2, a+V.e3, a+V.e4)
+(V::MyLittleVector4, a::Real) = +(a,V)
-(a::Real, V::MyLittleVector4) = MyLittleVector4(a-V.e1, a-V.e2, a-V.e3, a-V.e4)
-(V::MyLittleVector4, a::Real) = MyLittleVector4(V.e1-a, V.e2-a, V.e3-a, V.e4-a)
/(V::MyLittleVector4, a::Real) = MyLittleVector4(V.e1/a, V.e2/a, V.e3/a, V.e4/a)
./(a::Real, V::MyLittleVector4) = MyLittleVector4(a/V.e1, a/V.e2, a/V.e3, a/V.e4)
.^(V::MyLittleVector4, a::Real) = MyLittleVector4(V.e1^a, V.e2^a, V.e3^a, V.e4^a)
.^(a::Real, V::MyLittleVector4) = MyLittleVector4(a^V.e1, a^V.e2, a^V.e3, a^V.e4)

# Scalar-diagonal operations
*(a::Real, V::MyLittleDiagonal4) = MyLittleDiagonal4(a*V.e11, a*V.e22, a*V.e33, a*V.e44)
*(V::MyLittleDiagonal4, a::Real) = *(a,V)
+(a::Real, V::MyLittleDiagonal4) = MyLittleDiagonal4(a+V.e11, a+V.e22, a+V.e33, a+V.e44)
+(V::MyLittleDiagonal4, a::Real) = +(a,V)
-(a::Real, V::MyLittleDiagonal4) = MyLittleDiagonal4(a-V.e11, a-V.e22, a-V.e33, a-V.e44)
-(V::MyLittleDiagonal4, a::Real) = MyLittleDiagonal4(V.e11-a, V.e22-a, V.e33-a, V.e44-a)
/(V::MyLittleDiagonal4, a::Real) = MyLittleDiagonal4(V.e11/a, V.e22/a, V.e33/a, V.e44/a)
./(a::Real, V::MyLittleDiagonal4) = MyLittleDiagonal4(a/V.e11, a/V.e22, a/V.e33, a/V.e44)
.^(V::MyLittleDiagonal4, a::Real) = MyLittleDiagonal4(V.e11^a, V.e22^a, V.e33^a, V.e44^a)
.^(a::Real, V::MyLittleDiagonal4) = MyLittleDiagonal4(a^V.e1, a^V.e2, a^V.e3, a^V.e44)


# Matrix-vector products

*(A::MyLittleDiagonal4, V::MyLittleVector4) = MyLittleVector4(A.e11*V.e1, A.e22*V.e2, A.e33*V.e3, A.e44*V.e4)

function *(A::MyLittleMatrix4, V::MyLittleVector4)
    v1 = A.e11 * V.e1 + A.e12 * V.e2 + A.e13 * V.e3 + A.e14 * V.e4
    v2 = A.e21 * V.e1 + A.e22 * V.e2 + A.e23 * V.e3 + A.e24 * V.e4
    v3 = A.e31 * V.e1 + A.e32 * V.e2 + A.e33 * V.e3 + A.e34 * V.e4
    v4 = A.e41 * V.e1 + A.e42 * V.e2 + A.e43 * V.e3 + A.e44 * V.e4
    return MyLittleVector4(v1, v2, v3, v4)
end


# Matrix-matrix products

*(A::MyLittleDiagonal4, B::MyLittleDiagonal4) = MyLittleDiagonal4(A.e11*B.e11, A.e22*B.e22, A.e33*B.e33, A.e44*B.e44)

function *(A::MyLittleMatrix4, B::MyLittleDiagonal4)
    c11 = A.e11 * B.e11
    c12 = A.e12 * B.e22
    c13 = A.e13 * B.e33
    c14 = A.e14 * B.e44
    c21 = A.e21 * B.e11
    c22 = A.e22 * B.e22
    c23 = A.e23 * B.e33
    c24 = A.e24 * B.e44
    c31 = A.e31 * B.e11
    c32 = A.e32 * B.e22
    c33 = A.e33 * B.e33
    c34 = A.e34 * B.e44
    c41 = A.e41 * B.e11
    c42 = A.e42 * B.e22
    c43 = A.e43 * B.e33
    c44 = A.e44 * B.e44
    return MyLittleMatrix4(c11,c12,c13,c14,c21,c22,c23,c24,c31,c32,c33,c34,c41,c42,c43,c44)
end

function *(A::MyLittleMatrix4, B::MyLittleDiagonal4)
    c11 = A.e11 * B.e11
    c12 = A.e11 * B.e12
    c13 = A.e11 * B.e13
    c14 = A.e11 * B.e14
    c21 = A.e22 * B.e21
    c22 = A.e22 * B.e22
    c23 = A.e22 * B.e23
    c24 = A.e22 * B.e24
    c31 = A.e33 * B.e31
    c32 = A.e33 * B.e32
    c33 = A.e33 * B.e33
    c34 = A.e33 * B.e34
    c41 = A.e44 * B.e41
    c42 = A.e44 * B.e42
    c43 = A.e44 * B.e43
    c44 = A.e44 * B.e44
    return MyLittleMatrix4(c11,c12,c13,c14,c21,c22,c23,c24,c31,c32,c33,c34,c41,c42,c43,c44)
end

function *(A::MyLittleMatrix4, B::MyLittleMatrix4)
    c11 = A.e11 * B.e11  +  A.e12 * B.e21  +  A.e13 * B.e31  +  A.e14 * B.e41
    c12 = A.e11 * B.e12  +  A.e12 * B.e22  +  A.e13 * B.e32  +  A.e14 * B.e42
    c13 = A.e11 * B.e13  +  A.e12 * B.e23  +  A.e13 * B.e33  +  A.e14 * B.e43
    c14 = A.e11 * B.e14  +  A.e12 * B.e24  +  A.e13 * B.e34  +  A.e14 * B.e44
    
    c21 = A.e21 * B.e11  +  A.e22 * B.e21  +  A.e23 * B.e31  +  A.e24 * B.e41
    c22 = A.e21 * B.e12  +  A.e22 * B.e22  +  A.e23 * B.e32  +  A.e24 * B.e42
    c23 = A.e21 * B.e13  +  A.e22 * B.e23  +  A.e23 * B.e33  +  A.e24 * B.e43
    c24 = A.e21 * B.e14  +  A.e22 * B.e24  +  A.e23 * B.e34  +  A.e24 * B.e44
    
    c31 = A.e31 * B.e11  +  A.e32 * B.e21  +  A.e33 * B.e31  +  A.e34 * B.e41
    c32 = A.e31 * B.e12  +  A.e32 * B.e22  +  A.e33 * B.e32  +  A.e34 * B.e42
    c33 = A.e31 * B.e13  +  A.e32 * B.e23  +  A.e33 * B.e33  +  A.e34 * B.e43
    c34 = A.e31 * B.e14  +  A.e32 * B.e24  +  A.e33 * B.e34  +  A.e34 * B.e44
    
    c41 = A.e41 * B.e11  +  A.e42 * B.e21  +  A.e43 * B.e31  +  A.e44 * B.e41
    c42 = A.e41 * B.e12  +  A.e42 * B.e22  +  A.e43 * B.e32  +  A.e44 * B.e42
    c43 = A.e41 * B.e13  +  A.e42 * B.e23  +  A.e43 * B.e33  +  A.e44 * B.e43
    c44 = A.e41 * B.e14  +  A.e42 * B.e24  +  A.e43 * B.e34  +  A.e44 * B.e44
    return MyLittleMatrix4(c11,c12,c13,c14,c21,c22,c23,c24,c31,c32,c33,c34,c41,c42,c43,c44)
end
