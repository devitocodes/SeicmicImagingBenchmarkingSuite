# Open Seismic imaging benchmarking platform for data inversion methods

## Background

On a rolling basis different teams in O&G companies, academic research groups and vendors are porting propagators such as 3D isotropic acoustic and TTI to next-generation architectures with the goal of evaluating the relative performance or some performance/price metric. This underpins high-value decisions around purchasing (applies to both on-prem and Cloud resource decisions) and often a shift in programming model (e.g. business case to reimplement existing x86 software in CUDA). This presents several challenges:

* Difficult to perform an apples-to-apples comparison when different implementations are done by different developers of varying skills, e.g. does the benchmark reflect differences in architecture or differences in developer skill.
* Porting key benchmarks to a new architecture, including performance analysis and tuning, typically takes multiple months of an HPC developer - this not only has a high cost but also ties up a scarce resource. 
* The lack of reference implementations means that it is difficult to meaningfully compare the benchmark results from different groups because they have implemented different discretisation variations.
* There is a remarkable absence of gradient type benchmarks. This is problematic as backpropagation (i.e. use of the adjoint state method for any gradient calculation) is frequently the most significant bottleneck. This tends to be limited by total memory on the computing device and the I/O bandwidth for streaming snapshots to host and/or storage.
* In general, the benchmarks themselves are closed source. This not only means significant duplication of effort but frequently leads to a lack of robust and reproducible results. 


## Methodology

Taking inspiration from success stories such as the SEAM Open Data [1], we bring together expertise from multiple institutions to devise a platform that provides a trustworthy representation of the challenges in real-life seismic inversion. The cornerstones of the proposed methodology are:


* Constructive, cross-institutional dialogue to identify the most relevant computational kernels
* Use mathematics to describe the problem specification
* Use of open access datasets
* Suitable metrics for correctness - e.g. error tolerances, dot test, gradient test
* Community-open, systematic reviewing and feedback
* Open-core model, which is mostly open-source, but selected components available under subscription to support the sustainability of the project
* Best software engineering practices to ensure reproducibility (e.g., CI/CD)

Governance should include peer review of contributions, regardless of their origin (academia, energy companies, vendor companies). The governance motivates its decisions publicly, for example why a contribution is being accepted, accepted subject to revision or rejected.

The end product should be straightforwardly accessible and everyone in the community should benefit, as for example happens in the ML [2] and graph [3] communities.

## Implementation

We will describe one concrete implementation of the benchmark specification using the open-source platform Devito [4, 5, 6]. Devito is a Python package to implement optimized stencil computation (e.g., finite differences, image processing, machine learning) from high-level symbolic problem definitions. Devito builds on SymPy and employs automated code generation and just-in-time compilation to execute optimized computational kernels using different parallel programming models (e.g. MPI, OpenMP, OpenACC, CUDA) on different architectures (e.g. Intel and AMD x86, NVidia and AMD GPUs, ARM).
Devito has a jit-backdoor feature that enables users to examine and modify the generated code directly. This is frequently used by architecture specialists to perform performance experiments or as a starting point to port code to a new architecture. In this case, benchmarks that can be submitted by the community would include the modified jit-generated code along with containers or other details required to make the benchmark result reproducible. These artifacts help guide application developers (including Devito) on the optimization strategies for their own software. We believe the jit-backdoor feature is essential for rapid time-to-deployment.

