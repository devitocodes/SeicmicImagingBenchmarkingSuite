Title: Open Seismic imaging benchmarking platform for data inversion methods

Speaker: Gerard Gorman, Devito Codes and Imperial College London.

---

* Forewarning - imperfections ahead.
* If you see something broken...please file a PR/issue

> <small>https://github.com/devitocodes/SeismicImagingBenchmarkingSuite</small>

---

Co-conspirators: F. Luporini (Devito Codes), A. St-Cyr (Shell), A. Loddoch, J. Washbourne 
(Chevron), A. Souza (Petrobras), K. Hester (NVidia), P. Witte (Microsoft), F.
Dupros (ARM), M. Araya (Total), C. Leader (SLB), J. Tilly (BP)

>  Please let me know if I have missed your name (PRs welcome...)
---

## Vision

Bring *community* together to:
* Standardize benchmarking of seismic imaging kernels.
* Provide open-source reference implementations for a range of architectures.
* Publish reproducible benchmark experiments.

---

### Community/stakeholders
* Energy companies.
* O&G service companies.
* Processor manufacturers, OEMs, supercomputer/cluster manufacturers.
* Cloud providers.
* Independent software vendors.
* Academic research community.

---

### Business case for **open** domain specific benchmarks
* Making informed purchasing decisions for on-prem/Cloud.
  * Market value of HPC market in O&G ~1b USD.
* Software roadmaps:
  * Performance-critical software must be written in vendor-native programming model.
  * Unicorn developers are a scarce and high value.
  * Extensive code verification and code hardening.
* Enables collaboration and code/data reuse - stop burning our human capital.

---

> Porting key benchmarks to a new architecture, including performance analysis and tuning, typically takes multiple months of *unicorn* developer effort from *user* and vendor.

> Cost estimates range from 500k-1m(?) USD per customer-architecture pair. Does not include duplication of work in consortia etc.

---

###  \<rant\> Apples-to-~apples~mystry-fruit comparisons
Common issues benchmarking against other codes:
* Difference in the PDEs (e.g., different BCs, constant vs variable density).
* Difference in discretisation, e.g.,
  * Time-order, space-order, boundary conditions, (dx, dy, dz, dt), (nx, ny, nz, nt).
  * Have encountered ~10 different variations of TTI.
* ...

---

* ...
* Difference in algorithmic optimizations, e.g., expanding box, factorization.
* Runtime choices, e.g.,
  * Pure OpenMP vs MPI-x, pinning.
* Are we even computing the same solution?
  * Floating point addition is non-associative.
  * Lossy compression, reduced precision...
---

* Reproducibility:
  * Lack of access to closed source codes.
  * Performance data often covered by NDA.
  * Problematic to get all parties using the same or twin compute environments (*"it works on my laptop"*).

> Are we comparing methods, hardware or skill?

---

> Presenter: By moving to GPU we get a x1000 speedup.</br>
> Chair: What was your reference?</br>
> Presenter: An in-house code written in Java.</br>
> Chair: What did your roofline model look like?</br>
> Presenter: What's a roofline model?</br>

\<\\rant\>

---

### Objectives of standardisation
* Standardize problem specification, includes:
  * Correctness tests.
  * Performance metrics.
* Open-source reference implementation:
  * Design in reproducibility, e.g., containers to set runtime environemnent.
  * Starting point porting, optimizing in-codes.
  * Sandbox for vendors, customers and researchers to collaborate.

  ---

* Increase relevance of benchmarks:
  * Gradient-type benchmarks are uncommon despite the fact that backpropagation is frequently the main performance bottleneck.
* In general, the benchmarks themselves are closed-source. This not only means significant duplication of effort but frequently leads to a lack of robust and reproducible results. 

---

### Challenges: Algorithmic development
  * Improved physics models (e.g., elastic models).
  * Improved numerical discretization of the forward model and its adjoint.
  * Novel algorithmic research, e.g., machine learning.

---

### Challenges: Software development and optimization:
  * Ongoing optimization of software implementation on the current generation of CPUs/GPUs.
  * Optimization for different runtime environments for on-prem and Cloud environments. 
  * Porting to new architectures for evaluation and productionization.
  * Parallel programming models, e.g., MPI, OpenMP, CUDA, HIP.

---

### Scope of benchmarking
* Seismic imaging is dominated by the cost of forward modelling and the adjoint-state method.
  * Many different PDEs and choices of discretization.
* Variability in OI, memory pressure and register pressure.
* Important to choose benchmarks that reflect real use case, e.g.:
  * Gradient benchmarks should be done in addition to forward model benchmarks.
  * Large offsets or high frequency will necessitate distributed memory parallelization.

---

### Out of scope
* Storage IO (with the exception is serialization for gradient computation).
* Full FWI/RTM - compute cost is too high.

---

## Roadmap

* Learn from numerous benchmarking suites from other disciplines
* Bring together expertise from industry and academia to:
  * Standardize benchmarking of seismic imaging kernels.
  * Publish reproducible benchmark data.
  * Provide reference implementations and maximize software reuse.

---

### Phase I: Bootstrap the creation of v0.1
Milestones:
* Announce call for participation and create initial stakeholder group - this presentation.
* Create template benchmark specifications - encodes best practices.
* Create examplar benchmark specifications based on isotropic acoustic and TTI.

---

### Phase I: details
Considerations when defining a benchmark specification:
* Unambiguous problem specification:
  * Enable benchmark problems to be set up using different codes.
  * Problem dependencies, e.g., datasets will be open access.

---

* Define measures of success:
  * Correctness test, e.g., error norms.
  * Measure stencil throughput (grid-points-per-second).
  * Measure parallel efficiency.

---

* Problem size:
  * Problem sizes should be representative of production workloads.
  * Reduced problem sizes or space-order may also be necessary:
    * Training, aid in code porting, evaluation on new architectures with low memory.

---

### Submission process
* Benchmark specifications are submitted as PRs to the [GitHub repo]( 
https://github.com/devitocodes/SeicmicImagingBenchmarkingSuite).
* The file CONTRIBUTIONS.mb Developer's Certificate of Origin 1.1.
* PRs will be peer-reviewed and published on main after revisions have been completed.

---

### Phase II
Milestones:
* Develop reference implementations of examplar benchmarks.
* Establish and demonstrate reproducibility standards.
* Initialize benchmark league table.

---

* Provide reference implementations of benchmark problems using the open-source platform, [Devito](https://www.devitoproject.org/). 
* Devito is a Python package to implement optimized stencil computation (e.g., finite differences, image processing, machine learning) from high-level symbolic problem definitions.
* Supports *MPI, OpenMP, OpenACC, CUDA (HIP upcoming)* and *Intel and AMD x86, NVidia and AMD GPUs, ARM*.
* Open source: devitoproject.org
* Commercial: devitocodes.com

---

### Submission process
* New submissions built on examplar templates.
* Submissions via as PRs to the GitHub repo.
* IP covered CONTRIBUTIONS.mb Developer's Certificate of Origin 1.1.
* GitHub actions used to automate testing/correctness and automate benchmarking on self-hosted runners (requires some gate keeping).
* All PRs will be peer-reviewed after GitHub Actions checks have been completed.
* Published on main after revisions have been completed.

---

### Phase III
Milestones:
* Governance structure.
* Define code and sustainability model.
* Open call for submissions.

---

### Phase IV
Milestones:
* Bounties on improvements to existing benchmarks.
* Kaggle-inspired competitions to guide activity.
* Partner with publisher to create incentives for students and academics.

---

# Discussion