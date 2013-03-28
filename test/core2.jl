using MyLittleArray

# Core operations tests, copied from the ImmutableArrays.jl package

typealias Vec2d MyLittleVector2

v1 = Vec2d(1.0,2.0)
v2 = Vec2d(6.0,5.0)

# indexing
@assert v1[1] == 1.0
@assert v1[2] == 2.0
@assert try v1[-1]; false; catch e; isa(e,BoundsError); end
@assert try v1[0];  false; catch e; isa(e,BoundsError); end
@assert try v1[3];  false; catch e; isa(e,BoundsError); end

# negation
@assert -v1 == Vec2d(-1.0,-2.0)
@assert isa(-v1,Vec2d)

# addition
@assert v1+v2 == Vec2d(7.0,7.0)

# subtraction
@assert v2-v1 == Vec2d(5.0,3.0)

# multiplication
@assert v1.*v2 == Vec2d(6.0,10.0)

# division
@assert v1 ./ v1 == Vec2d(1.0,1.0)

# scalar operations
@assert 1.0 + v1 == Vec2d(2.0,3.0)
@assert v1 + 1.0 == Vec2d(2.0,3.0)
@assert 1 + v1 == Vec2d(2.0,3.0)
@assert v1 + 1 == Vec2d(2.0,3.0)

@assert v1 - 1.0 == Vec2d(0.0,1.0)
@assert 1.0 - v1 == Vec2d(0.0,-1.0)
@assert v1 - 1 == Vec2d(0.0,1.0)
@assert 1 - v1 == Vec2d(0.0,-1.0)

@assert 2.0 * v1 == Vec2d(2.0,4.0)
@assert v1 * 2.0 == Vec2d(2.0,4.0)
@assert 2 * v1 == Vec2d(2.0,4.0)
@assert v1 * 2 == Vec2d(2.0,4.0)

@assert v1 / 2.0 == Vec2d(0.5,1.0)
@assert v1 ./ 2.0 == Vec2d(0.5,1.0)
@assert v1 / 2 == Vec2d(0.5,1.0)
@assert v1 ./ 2 == Vec2d(0.5,1.0)

@assert 12.0 ./ v1 == Vec2d(12.0,6.0)
@assert 12 ./ v1 == Vec2d(12.0,6.0)

@assert v1.^2 == Vec2d(1.0,4.0)
@assert v1.^2.0 == Vec2d(1.0,4.0)
@assert 2.0.^v1 == Vec2d(2.0,4.0)
@assert 2.^v1 == Vec2d(2.0,4.0)

# vector norm
@assert norm(Vec2d(3.0,4.0)) == 5.0

@assert eye(MyLittleMatrix2) * v1 == v1
@assert eye(MyLittleDiagonal2) * v1 == v1
