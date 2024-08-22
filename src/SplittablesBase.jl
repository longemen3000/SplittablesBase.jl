baremodule SplittablesBase

function halve end
function amount end

module Implementations
import ..SplittablesBase: SplittablesBase, amount, halve
using Base: KeySet, ValueIterator
using Setfield: @set
include("implementations.jl")
end  # module

module Testing
    include("testing.jl")
    if !isdefined(Base,:get_extension)
        include("../ext/SplittablesTestingExt.jl")
    end
end



end # module
