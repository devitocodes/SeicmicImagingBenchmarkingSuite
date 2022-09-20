# Open Seismic imaging benchmarking platform for data inversion methods
Working together to:
* Standardize benchmarking of seismic imaging kernels.
* Publish reproducible benchmark data.
* Provide reference implementations and maximize software reuse.

## Background

The seismic imaging community,

* Energy companies.
* O&G service companies.
* Processor companies.
* Supercomputer/cluster manufacturers.
* Cloud companies.
* Independent software vendors.
* Academic research community.

is continuously improving the accuracy and efficiency of seismic imaging through a combination of,

* Algorithmic development:
  * Improved physics models (e.g., elastic models).
  * Improved numerical discretization of the forward model and its adjoint.
  * Novel algorithmic research, e.g., machine learning.
* Performance optimization:
  * Ongoing optimization of software implementation on the current generation of CPUs/GPUs.
  * Optimization for different runtime environments for on-prem and Cloud environments. 
  * Porting to new architectures for evaluation and productionization.
  * Parallel programming models, e.g., MPI, OpenMP, CUDA, HIP.

Wave propagator kernels (for brevity, propagator kernels may refer to forward models or their adjoint) get a lot of attention as they are the numerical core of all seismic imaging methods and account for the bulk of the computational cost (where the remaining cost is dominated by IO).

While the PDEs, numerical discretization methods, and performance optimization techniques are widely considered well known, the community is faced with several challenges:
* Software is costly to implement as it requires:
  * specialists in mathematical model development,
  * specialists in the parallel programming model appropriate to the target architecture, and
  * extensive code verification for correctness and robustness.
* Difficult to perform an apples-to-apples comparison when different implementations are done by different developers of varying skills (i.e., does the benchmark reflect differences in architecture or differences in developer skill).
* Porting key benchmarks to a new architecture, including performance analysis and tuning, typically takes multiple months of HPC developer time - this not only has a high cost but also ties up a scarce resource. 
* The lack of reference implementations means that it is difficult to meaningfully compare the benchmark results from different groups because they have implemented different discretization.
* There is a remarkable absence of gradient-type benchmarks. This is problematic as backpropagation (i.e. use of the adjoint state method for any gradient calculation) is frequently the most significant bottleneck. This tends to be limited by total memory on the computing device and the I/O bandwidth for streaming snapshots to host and/or storage.
* In general, the benchmarks themselves are closed-source. This not only means significant duplication of effort but frequently leads to a lack of robust and reproducible results. 

## Roadmap

Taking inspiration from numerous benchmarking suites from other disaplins, this
initiative aims to bring together expertise from industry and academia to:

* Standardize benchmarking of seismic imaging kernels.
* Publish reproducible benchmark data.
* Provide reference implementations and maximize software reuse.

### Phase I
This is a call for participation from the community to help create version 1.0
of the benchmark suite specification.

Considerations when defining a benchmark specification:
* Unambiguous problem specification:
  * Enable benchmarks to be set up using different codes.
  * Problem dependencies, e.g., datasets will be open access.
* Define measures of success:
  * Correctness test, e.g., error norms.
  * Measure stencil throughput (grid-points-per-second).
  * Measure parallel efficiency.
* Problem size:
  * Problem sizes should be representative of production workloads.
  * Reduced problem sizes (2D) are useful for exploration and training.

Benchmark specifications are submitted as PRs to the 
https://github.com/devitocodes/SeicmicImagingBenchmarkingSuite The file
CONTRIBUTIONS.mb Developer's Certificate of Origin 1.1.

PRs will be peer reviewed and published on main after revisions have been completed.

### Phase II
Provide reference implementations of benchmark problems using the open-source
platform, Devito.  Devito is a Python package to implement optimized stencil
computation (e.g., finite differences, image processing, machine learning) from
high-level symbolic problem definitions. Devito builds on SymPy and employs
automated code generation and just-in-time compilation to execute optimized
computational kernels using different parallel programming models (e.g. MPI,
OpenMP, OpenACC, CUDA) on different architectures (e.g. Intel and AMD x86,
NVidia and AMD GPUs, ARM).

Devito has a jit-backdoor feature that enables users to examine and modify the
generated code directly. This is frequently used by architecture specialists to
perform performance experiments or as a starting point to port code to a new
architecture. In this case, benchmarks that can be submitted by the community
would include the modified jit-generated code along with containers or other
details required to make the benchmark result reproducible. These artifacts help
guide application developers (including Devito) on the optimization strategies
for their own software. We believe the jit-backdoor feature is essential for
rapid time-to-deployment.



-----


* Best software engineering practices to ensure reproducibility (e.g., CI/CD)

Governance should include peer review of contributions, regardless of their origin (academia, energy companies, vendor companies). The governance motivates its decisions publicly, for example why a contribution is being accepted, accepted subject to revision or rejected.

The end product should be straightforwardly accessible and everyone in the community should benefit, as for example happens in the ML [2] and graph [3] communities.

## Implementation

