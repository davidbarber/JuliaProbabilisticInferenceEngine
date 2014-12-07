module brml

if OS_NAME == :Windows
    push!(LOAD_PATH,"$(pwd())\\src")
    push!(LOAD_PATH,"$(pwd())\\src\\HMM")
    push!(LOAD_PATH,"$(pwd())\\src\\GraphPlot")
    push!(LOAD_PATH,"$(pwd())\\src\\PotentialInference")
    push!(LOAD_PATH,"$(pwd())\\Demos")
else
    push!(LOAD_PATH,"$(pwd())/src")
    push!(LOAD_PATH,"$(pwd())/src/HMM")
    push!(LOAD_PATH,"$(pwd())/src/GraphPlot")
    push!(LOAD_PATH,"$(pwd())/src/PotentialInference")
    push!(LOAD_PATH,"$(pwd())/Demos")
end

println("\nAvailable Demos:\n")
demos=union(readdir("Demos"),readdir("./src/HMM"))
for i=1:length(demos)
    try
        if demos[i][1:4]=="demo" && demos[i][end-2:end]==".jl"
            println(demos[i])
            reload(demos[i])
        end
    end
end

using Reexport

@reexport using DavidsFunctions, HMM, PotentialInference, GraphPlot

end
