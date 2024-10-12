<h1 align="center">
  From CAD to URDF: Co-Design of a Jet-Powered Humanoid Robot Including CAD Geometry
</h1>

<div align="center">
Punith Reddy Vanteddu, Gabriele Nava, Fabio Bergonti, Giuseppe L’Erario, Antonello Paolino, Daniele Pucci
</div>

<p align="center">

https://github.com/user-attachments/assets/744b3896-48fa-4a81-b9fb-ecb3180dbe6f

</p>
<div align="center">
  <a href="#Installation"><b>Installation</b></a> |
  <a href="https://arxiv.org/abs/2410.07963"><b>arXiv</b></a> |
  <a href="https://youtu.be/k_rbv8lNKjA"><b>Video</b></a>
</div>

## Abstract

Co-design optimization strategies usually rely on simplified robot models extracted from CAD. While these models are useful for optimizing geometrical and inertial parameters for robot control, they might overlook important details essential for prototyping the optimized mechanical design. For instance, they may not account for mechanical stresses exerted on the optimized geometries and the complexity of assembly-level design. In this paper, we introduce a co-design framework aimed at improving both the control performance and mechanical design of our robot. Specifically, we identify the robot links that significantly influence control performance.
The geometric characteristics of these links are parameterized and optimized using a multi-objective evolutionary algorithm to achieve optimal control performance. Additionally, an automated Finite Element Method (FEM) analysis is integrated into the framework to filter solutions not satisfying the required structural safety margin. We validate the framework by applying it to enhance the mechanical design for flight performance of the jet-powered humanoid robot iRonCub.

## Installation

1. Clone the repository:
  ```bash
  git clone https://github.com/ami-iit/https://github.com/ami-iit/paper_vanteddu_2024_iros_cogenerative_cad.git
  ```

2. Follow the instructions to install https://github.com/ami-iit/ironcub-mk1-software using `conda` environments.

### Maintainer

This repository is maintained by:

| | |
|:---:|:---:|
| [<img src="https://github.com/vpunithreddy.png" width="40">](https://github.com/vpunithreddy) | [@vpunithreddy](https://github.com/vpunithreddy) |

<p align="left">
   <a href="https://github.com/ami-iit/paper_vanteddu_2024_iros_cogenerative_cad/blob/main/LICENSE"><img src="https://img.shields.io/github/license/ami-iit/paper_vanteddu_2024_iros_cogenerative_cad" alt="Size" class="center"/></a>
</p>

