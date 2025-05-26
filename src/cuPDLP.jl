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

module cuPDLP

import LinearAlgebra
import Logging
import Printf
import SparseArrays
import Random

import GZip
import QPSReader
import Statistics
import StatsBase
import StructTypes

using CUDA

const Diagonal = LinearAlgebra.Diagonal
const diag = LinearAlgebra.diag
const dot = LinearAlgebra.dot
const norm = LinearAlgebra.norm
const mean = Statistics.mean
const median = Statistics.median
const nzrange = SparseArrays.nzrange
const nnz = SparseArrays.nnz
const nonzeros = SparseArrays.nonzeros
const rowvals = SparseArrays.rowvals
const sparse = SparseArrays.sparse
const SparseMatrixCSC = SparseArrays.SparseMatrixCSC
const spdiagm = SparseArrays.spdiagm
const spzeros = SparseArrays.spzeros
const quantile = Statistics.quantile
const sample = StatsBase.sample

const ThreadPerBlock = 128

include("quadratic_programming.jl")
include("solve_log.jl")
include("quadratic_programming_io.jl")
include("preprocess.jl")
include("cpu_to_gpu.jl")
include("termination.jl")
include("iteration_stats_utils_gpu.jl")
include("saddle_point_gpu.jl")
include("primal_dual_hybrid_gradient_gpu.jl")

end # module cuPDLP
