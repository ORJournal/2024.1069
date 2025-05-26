# MIT License

# Copyright (c) 2024 Haihao Lu, Jinwen Yang

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

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