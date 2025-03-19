include("../src/cuPDLP.jl")
import JLD2
import DataFrames
import CSV

"""
# Returns
A dictionary with the values of the command-line arguments.
"""
function parse_command_line()
    arg_parse = ArgParse.ArgParseSettings()

    ArgParse.@add_arg_table! arg_parse begin
        "--tolerance"
        help = "KKT tolerance of the solution"
        arg_type = Float64
        required = true

        "--output_directory"
        help = "The directory for output files."
        arg_type = String
        required = true
    end

    return ArgParse.parse_args(arg_parse)
end


function main()
    parsed_args = parse_command_line()
    tolerance = parse_args["tolerance"]
    output_directory = parsed_args["output_directory"]
    
    instances = Vector{String}()
    open("../benchmark/miplib_relaxations_instances_list") do f
        while ! eof(f)
            push!(instances,readline(f))
        end
    end

    high_accuracy = 0
    if tolerance == 1e-8
        high_accuracy = 1
    end
    time_cupdlp, time_cupdlp_presolved = [], []
    time_firstorderlp = []
    time_pdlp_1, time_pdlp_4, time_pdlp_16 = [], [], []
    time_primal_simplex_no_presolve, time_primal_simplex_presolve = [], []
    time_dual_simplex_no_presolve, time_dual_simplex_presolve = [], []
    time_barrier_no_presolve, time_barrier_presolve = [], []

    for i in 1:length(instances)
        problem_name = instances[i]
        instance_path_cupdlp = joinpath("$(output_directory)","cuPDLP_$(problem_name)_$(tolerance).jld2")
        instance_path_cupdlp_presolved = joinpath("$(output_directory)","cuPDLP_$(problem_name)_presolved_$(tolerance).jld2")
        instance_path_firstorderlp = joinpath("$(output_directory)","FirstOrderLp_$(problem_name)_$(tolerance).jld2")
        instance_path_pdlp_1 = joinpath("$(output_directory)","PDLP_$(problem_name)_1_$(high_accuracy).txt")
        instance_path_pdlp_4 = joinpath("$(output_directory)","PDLP_$(problem_name)_4_$(high_accuracy).txt")
        instance_path_pdlp_16 = joinpath("$(output_directory)","PDLP_$(problem_name)_16_$(high_accuracy).txt")

        instance_path_primal_simplex_no_presolve = joinpath("$(output_directory)","Gurobi_0_0_16_$(problem_name)_$(tolerance).jld2")
        instance_path_primal_simplex_presolve = joinpath("$(output_directory)","Gurobi_1_0_16_$(problem_name)_$(tolerance).jld2")
        instance_path_dual_simplex_no_presolve = joinpath("$(output_directory)","Gurobi_0_1_16_$(problem_name)_$(tolerance).jld2")
        instance_path_dual_simplex_presolve = joinpath("$(output_directory)","Gurobi_1_1_16_$(problem_name)_$(tolerance).jld2")
        instance_path_barrier_no_presolve = joinpath("$(output_directory)","Gurobi_0_2_16_$(problem_name)_$(tolerance).jld2")
        instance_path_barrier_presolve = joinpath("$(output_directory)","Gurobi_1_2_16_$(problem_name)_$(tolerance).jld2")

        try
            res = JLD2.load(instance_path_cupdlp)
            res = res["res"]
            stats = res.iteration_stats[end]
            append!(time_cupdlp, stats.cumulative_time_sec)
        catch
            if i <= 363
                append!(time_cupdlp, 3600)
            else
                append!(time_cupdlp, 18000)
        end

        try
            res = JLD2.load(instance_path_cupdlp_presolved)
            res = res["res"]
            stats = res.iteration_stats[end]
            append!(time_cupdlp_presolved, stats.cumulative_time_sec)
        catch
            if i <= 363
                append!(time_cupdlp_presolved, 3600)
            else
                append!(time_cupdlp_presolved, 18000)
        end

        try
            res = JLD2.load(instance_path_firstorderlp)
            res = res["res"]
            stats = res.iteration_stats[end]
            append!(time_firstorderlp, stats.cumulative_time_sec)
        catch
            if i <= 363
                append!(time_firstorderlp, 3600)
            else
                append!(time_firstorderlp, 18000)
        end

        try
            res = []
            open(instance_path_pdlp_1) do f
                while ! eof(f)
                    push!(res,readline(f))
                end
            end
            append!(time_pdlp_1, res[3])
        catch
            if i <= 363
                append!(time_pdlp_1, 3600)
            else
                append!(time_pdlp_1, 18000)
        end

        try
            res = []
            open(instance_path_pdlp_4) do f
                while ! eof(f)
                    push!(res,readline(f))
                end
            end
            append!(time_pdlp_4, res[3])
        catch
            if i <= 363
                append!(time_pdlp_4, 3600)
            else
                append!(time_pdlp_4, 18000)
        end

        try
            res = []
            open(instance_path_pdlp_16) do f
                while ! eof(f)
                    push!(res,readline(f))
                end
            end
            append!(time_pdlp_16, res[3])
        catch
            if i <= 363
                append!(time_pdlp_16, 3600)
            else
                append!(time_pdlp_16, 18000)
        end

        try
            res = JLD2.load(instance_path_primal_simplex_no_presolve)
            res = res["res"]
            append!(time_primal_simplex_no_presolve, res[1])
        catch
            if i <= 363
                append!(time_primal_simplex_no_presolve, 3600)
            else
                append!(time_primal_simplex_no_presolve, 18000)
        end

        try
            res = JLD2.load(instance_path_primal_simplex_presolve)
            res = res["res"]
            append!(time_primal_simplex_presolve, res[1])
        catch
            if i <= 363
                append!(time_primal_simplex_presolve, 3600)
            else
                append!(time_primal_simplex_presolve, 18000)
        end

        try
            res = JLD2.load(instance_path_dual_simplex_no_presolve)
            res = res["res"]
            append!(time_dual_simplex_no_presolve, res[1])
        catch
            if i <= 363
                append!(time_dual_simplex_no_presolve, 3600)
            else
                append!(time_dual_simplex_no_presolve, 18000)
        end

        try
            res = JLD2.load(instance_path_dual_simplex_presolve)
            res = res["res"]
            append!(time_dual_simplex_presolve, res[1])
        catch
            if i <= 363
                append!(time_dual_simplex_presolve, 3600)
            else
                append!(time_dual_simplex_presolve, 18000)
        end

        try
            res = JLD2.load(instance_path_barrier_no_presolve)
            res = res["res"]
            append!(time_barrier_no_presolve, res[1])
        catch
            if i <= 363
                append!(time_barrier_no_presolve, 3600)
            else
                append!(time_barrier_no_presolve, 18000)
        end

        try
            res = JLD2.load(instance_path_barrier_presolve)
            res = res["res"]
            append!(time_barrier_presolve, res[1])
        catch
            if i <= 363
                append!(time_barrier_presolve, 3600)
            else
                append!(time_barrier_presolve, 18000)
        end      
    end

    df = DataFrames.DataFrame(
        instance = instances,
        time_cupdlp = time_cupdlp, 
        time_cupdlp_presolved = time_cupdlp_presolved,
        time_firstorderlp = time_firstorderlp,
        time_pdlp_1 = time_pdlp_1, 
        time_pdlp_4 = time_pdlp_4, 
        time_pdlp_16 = time_pdlp_16,
        time_primal_simplex_no_presolve = time_primal_simplex_no_presolve,
        time_primal_simplex_presolve = time_primal_simplex_presolve,
        time_dual_simplex_no_presolve = time_dual_simplex_no_presolve, 
        time_dual_simplex_presolve = time_dual_simplex_presolve,
        time_barrier_no_presolve = time_barrier_no_presolve, 
        time_barrier_presolve = time_barrier_presolve
    )

    CSV.write(joinpath("$(output_directory)","miplib_$(tolerance).csv"), df)
end

main()