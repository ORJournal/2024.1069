using JuMP, Gurobi
import ArgParse

function parse_command_line()
    arg_parse = ArgParse.ArgParseSettings()

    ArgParse.@add_arg_table! arg_parse begin
        "--problem_name"
        help = "The instance to solve."
        arg_type = String
        required = true

        "--problem_folder"
        help = "The directory for input instances."
        arg_type = String
        required = true

        "--output_directory"
        help = "The directory for output files."
        arg_type = String
        required = true

        "--gurobi_threads"
        help = "Threads for Gurobi."
        arg_type = Int64
        default = 16
    end

    return ArgParse.parse_args(arg_parse)
end

function main()
    parsed_args = parse_command_line()
    problem_name = parsed_args["problem_name"]
    problem_folder = parsed_args["problem_folder"]
    output_directory = parsed_args["output_directory"]
    gurobi_threads = parsed_args["gurobi_threads"]


    tolerance = 1e-4
    time_sec_limit = 3600.0

    instance_path = joinpath("$(problem_folder)", "$(problem_name).mps.gz")

    model = direct_model(Gurobi.Optimizer())
    model = read_from_file(instance_path)
    relax_integrality(model)
    set_optimizer(model, Gurobi.Optimizer)
    set_optimizer_attribute(model, "TimeLimit", time_sec_limit)
    set_optimizer_attribute(model, "OptimalityTol", tolerance)
    set_optimizer_attribute(model, "FeasibilityTol", tolerance)
    set_optimizer_attribute(model, "BarConvTol", tolerance)
    set_optimizer_attribute(model, "Method", 2)
    set_optimizer_attribute(model, "Crossover", 0)
    set_optimizer_attribute(model, "Threads", gurobi_threads)
    set_optimizer_attribute(model, "BarOrder", 1)
    optimize!(model)

    presolvedP = Ref{Ptr{Cvoid}}(C_NULL)
    GRBpresolvemodel(backend(model).optimizer.model, presolvedP)
    GRBwrite(presolvedP[], joinpath("$(output_directory)", "$(problem_name)_presolved.mps"))
end