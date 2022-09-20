# Open Seismic imaging benchmarking platform for data inversion methods

## Vision

Bring community together to:
* Standardize benchmarking of seismic imaging kernels.
* Publish reproducible benchmark data.
* Provide reference implementations and maximize software reuse.

## Background
While the PDEs, numerical discretization methods, and performance optimization
techniques are widely considered well known, the community (clarified later) is
faced with several challenges:

* Software is costly to implement as it requires:
  * specialists in mathematical model development,
  * specialists in the parallel programming model appropriate to the target architecture, and
  * extensive code verification for correctness and robustness.
* Porting key benchmarks to a new architecture, including performance analysis and tuning, typically takes multiple months of HPC developer time - this not only has a high cost but also ties up a scarce resource. 

### Apples to potatoes comparison
Difficult to perform an apples-to-apples comparison when different
implementations are done by different developers of varying skills (i.e., does
the benchmark reflect differences in architecture or differences in developer
skill).
**"
* Presenter: Here you can see we get a x1000 speedup.
* Chair: What was your reference?
* Presenter: An in-house code written in Java.
* Chair: Do you know what a roofline model is?
* Presenter: No.
"**

### Case for standardisation
* Standardizing problem specification, including measures of success, is a requirement for performing comparisons.
* Open source reference solution will provide:
  * Reproducible benchmark others can use to optimize their code or report its relative performance.
  * A starting point porting, optimizing in-codes.
  * A sandbox for vendors, customers and researchers to collaborate.
  * A data point that others can use to measure their 
* Increase diversity of benchmarks: Gradient-type benchmarks are uncommon dispite the fact that backpropagation is frequently the main performance bottleneck.
* In general, the benchmarks themselves are closed-source. This not only means significant duplication of effort but frequently leads to a lack of robust and reproducible results. 

### Seismic imaging community
* Energy companies.
* O&G service companies.
* Processor manufacturers, OEMs, supercomputer/cluster manufacturers.
* Cloud providers.
* Independent software vendors.
* Academic research community.

### Challenges: Algorithmic development
  * Improved physics models (e.g., elastic models).
  * Improved numerical discretization of the forward model and its adjoint.
  * Novel algorithmic research, e.g., machine learning.

### Challenges: Software development and optimization:
  * Ongoing optimization of software implementation on the current generation of CPUs/GPUs.
  * Optimization for different runtime environments for on-prem and Cloud environments. 
  * Porting to new architectures for evaluation and productionization.
  * Parallel programming models, e.g., MPI, OpenMP, CUDA, HIP.

### Scope of benchmarking
* Seismic imaging is dominated by the cost of forward modelling and the adjoint-state method.
  * Many different PDEs and choices of discretization.
* Variability in OI, memory pressure and register pressure.
* Important to choose benchmarks that reflect real use case, e.g.:
  * Gradient benchmarks should be done in addition to forward model benchmarks.
  * Large offsets or high frequency will necessitate distributed memory parallelization.

### Out of scope
* Storage IO (with the exception is serialization for gradient computation).
* Full FWI/RTM - compute cost is too high.

## Roadmap

Taking inspiration from numerous benchmarking suites from other disciplines, this
initiative aims to bring together expertise from industry and academia to:

* Standardize benchmarking of seismic imaging kernels.
* Publish reproducible benchmark data.
* Provide reference implementations and maximize software reuse.

### Phase I: Bootstrap the creation of v0.1
Milestones:
* Announce call for participation and create initial stakeholder group.
* Create template benchmark specifications - encodes best practise.
* Create examplar benchmark specifications based on isotropic acoustic and TTI.

### Phase I: details
Considerations when defining a benchmark specification:
* Unambiguous problem specification:
  * Enable benchmark problems to be set up using different codes.
  * Problem dependencies, e.g., datasets will be open access.
* Define measures of success:
  * Correctness test, e.g., error norms.
  * Measure stencil throughput (grid-points-per-second).
  * Measure parallel efficiency.
* Problem size:
  * Problem sizes should be representative of production workloads.
  * Reduced problem sizes or space-order may also be necessary:
    * Training, aid in code porting, evaluation on new architectures with low memory.

### Submission process
* Benchmark specifications are submitted as PRs to the [GitHub repo]( 
https://github.com/devitocodes/SeicmicImagingBenchmarkingSuite).
* The file CONTRIBUTIONS.mb Developer's Certificate of Origin 1.1.
* PRs will be peer reviewed and published on main after revisions have been completed.

### Phase II
Milestones:
* Develop reference implementations of examplar benchmarks.
* Establish and demonistrate reproducibility standards.
* Initialize benchmark league table.

### Phase II: details
Provide reference implementations of benchmark problems using the open-source
platform, [Devito](https://www.devitoproject.org/).  Devito is a Python package
to implement optimized stencil computation (e.g., finite differences, image
processing, machine learning) from high-level symbolic problem definitions.
Devito builds on SymPy and employs automated code generation and just-in-time
compilation to execute optimized computational kernels using different parallel
programming models (e.g. MPI, OpenMP, OpenACC, CUDA) on different architectures
(e.g. Intel and AMD x86, NVidia and AMD GPUs, ARM).

### Submission process
* New submissions should be based on examplar templates.
* Submissions via as PRs to the GitHub repo.
* IP covered CONTRIBUTIONS.mb Developer's Certificate of Origin 1.1.
* All PRs will be peer-reviewed after GitHub Actions checks have been completed.
* Published on main after revisions have been completed.

### Phase III
Milestones:
* Governance structure.
* Define code and sustainability model.
* Open call for submissions.

### Phase IV
Milestones:
* Bounties on improvements to existing benchmarks.
* Kaggle-inspired competitions to guide activity.