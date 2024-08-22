module SplittablesTestingExt
using SplittablesBase

using Test: @test, @testset
using SplittablesBase: amount, halve
using SplittablesBase.Testing: getdata, getlabel, countmap, recursive_vcat


function SplittablesBase.Testing.test_ordered(examples)
    @testset "$(getlabel(x))" for x in enumerate(examples)
        @debug "Testing `vcat`: $(getlabel(x))"
        @testset "vcat" begin
            data = getdata(x)
            left, right = halve(getdata(x))
            @test isequal(
            vcat(vec(collect(left)), vec(collect(right))),
            vec(collect(getdata(x))),
            )
        end
        test_recursive_halving(x)
    end
end


function SplittablesBase.Testing.test_unordered(examples)
    @testset "$(getlabel(x))" for x in enumerate(examples)
        @testset "concatenation" begin
            data = getdata(x)
            left, right = halve(getdata(x))
            @test isequal(
            countmap(collect(data)),
            merge(+, countmap(collect(left)), countmap(collect(right))),
            )
        end
        test_recursive_halving(x)
    end
end

function SplittablesBase.Testing.test_recursive_halving(x)
    @debug "Testing _recursive halving_: $(getlabel(x))"
    @testset "recursive halving" begin
        if Base.IteratorSize(getdata(x)) isa Union{Base.HasLength,Base.HasShape}
            @test isequal(recursive_vcat(getdata(x), length), vec(collect(getdata(x))))
        end
        @test isequal(recursive_vcat(getdata(x)), vec(collect(getdata(x))))
    end
end

end #module