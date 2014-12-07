module PotentialInference

importall DavidsFunctions

PotentialsPath="$(pwd())\\src\\PotentialInference\\Potentials"
PotentialInferencePath="$(pwd())\\src\\PotentialInference"
AlgorithmsPath="$(pwd())\\src\\PotentialInference\\Algorithms"

PotentialsPathUNIX="$(pwd())/src/PotentialInference/Potentials"
PotentialInferencePathUNIX="$(pwd())/src/PotentialInference"
AlgorithmsPathUNIX="$(pwd())/src/PotentialInference/Algorithms"

# Type definitions:

export Potential, DiscretePotential, ArrayPotential
abstract Potential
abstract DiscretePotential <: Potential
abstract ArrayPotential <: DiscretePotential


# Type Unions:
export IntOrIntArray
IntOrIntArray=Union(Integer,Array{Integer},Array{None}) # include also the ranges and vectors

export DictOrArray
DictOrArray=Union(Dict,Array)


# Variable Types:
export Variable
abstract Variable

export DiscreteVariable
type DiscreteVariable <: Variable
    name
    state
    function DiscreteVariable(varname,varstates)
        new(varname,varstates)
    end
end


# Potential Types

export PotArray
type PotArray <: ArrayPotential
    variables
    content
    function PotArray(variables, content)
        content=standardise(content)
        if length(variables)!= length(mysize(content))
            error("number of variables does not match the size of the potential")
        end
        new(vec(variables),content)
    end
end

export Const
type Const <: Potential
    variables
    content
    function Const(content)
        if !isa(content,Number)
            error("Content must be a numerical scalar")
        end
        new([],content)
    end
end

export PotLogArray
type PotLogArray <: ArrayPotential
    variables
    content
    function PotLogArray(variables, content)
        content=standardise(content)
        if length(variables)!= length(mysize(content))
            error("number of variables does not match the size of the potential")
        end
        new(vec(variables),content)
    end
end

# Windows:
try
    # Potentials:
    include("$(PotentialsPath)\\ArrayPotential.jl")
    include("$(PotentialsPath)\\Potential.jl")
    include("$(PotentialsPath)\\PotArray.jl")
    include("$(PotentialsPath)\\PotConst.jl")
    include("$(PotentialsPath)\\PotLogArray.jl")

    # Inference Algorithms:
    include("$(AlgorithmsPath)\\FactorGraph.jl")
end

# Unix:
try
    # Potentials:
    include("$(PotentialsPathUNIX)/ArrayPotential.jl")
    include("$(PotentialsPathUNIX)/Potential.jl")
    include("$(PotentialsPathUNIX)/PotArray.jl")
    include("$(PotentialsPathUNIX)/PotConst.jl")
    include("$(PotentialsPathUNIX)/PotLogArray.jl")

    # Inference Algorithms:
    include("$(AlgorithmsPathUNIX)/FactorGraph.jl")
end


end
