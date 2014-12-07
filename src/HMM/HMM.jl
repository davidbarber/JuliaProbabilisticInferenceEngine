module HMM
importall DavidsFunctions
    #@reexport using DavidsFunctions, HMM, GraphPlot, Winston ## CHECK!!!

export HMMforward
include("HMMforward.jl")

export HMMbackward
include("HMMbackward.jl")

export HMMsmooth
include("HMMsmooth.jl")

export HMMviterbi
include("HMMviterbi.jl")

import PyPlot
export PyPlot

end
