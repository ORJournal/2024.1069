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

from ortools.linear_solver import pywraplp
from ortools.linear_solver import linear_solver_pb2
from ortools.linear_solver.python import model_builder

def run(args):
    mps_path = f"{args.problem_folder}/{args.problem_name}.mps"
    model = model_builder.ModelBuilder()
    model.import_from_mps_file(mps_path)
    input_proto = model.export_to_proto()

    solver = pywraplp.Solver.CreateSolver("PDLP")
    solver.LoadModelFromProto(input_proto)
    solver.SetTimeLimit(args.time_sec_limit*1000)
    solver.SetNumThreads(args.num_threads)

    if high_accuracy == 0:
        solver.SetSolverSpecificParametersAsString("termination_criteria {eps_optimal_relative: 1e-4}")
    else:
        solver.SetSolverSpecificParametersAsString("termination_criteria {eps_optimal_relative: 1e-8}")

    status = solver.Solve()

    flag = "NA"
    if status == pywraplp.Solver.OPTIMAL:
        flag = "OPTIMAL"
    elif (status == pywraplp.Solver.INFEASIBLE) or (status == pywraplp.Solver.UNBOUNDED):
        flag = "INFEASIBLE"
    elif status == pywraplp.Solver.NOT_SOLVED:
        flag = "TIME_LIMIT"
    
    res = [flag, f"{solver.iterations()}", f"{solver.wall_time()/1000}"]

    with open(f"{args.output_directory}/PDLP_{args.problem_name}_{args.num_threads}_{args.high_accuracy}.txt", 'w') as f:
        for line in res:
            f.write(line)
            f.write('\n')

if __name__ == "__main__":
    from argparse import ArgumentParser
    parser = ArgumentParser()
    parser.add_argument('--problem_name', type=str)
    parser.add_argument('--time_sec_limit', type=int, default=3600)
    parser.add_argument('--num_threads', type=int, default=1)
    parser.add_argument('--problem_folder', type=str)
    parser.add_argument('--output_directory', type=str)
    parser.add_argument('--high_accuracy', type=int, default=0)

    args = parser.parse_args()
    run(args)
    
