# N-Body Problem (NBP) Simulation

## Description

This project provides MATLAB scripts for simulating the gravitational interaction of multiple particles in both 2D and 3D environments. These simulations visually represent the trajectories of the particles and their collective center of mass.

## Features

* **2D Simulation (`NBP_2D.m`)**: Simulates the movement of `Np` particles in a 2D plane under gravitational forces. The script animates the trajectories of each particle and the system's center of mass.
* **3D Simulation (`NBP_3D.m`)**: Extends the simulation to three dimensions, allowing for the visualization of `Np` particles moving in 3D space. Similar to the 2D version, it animates individual particle trajectories and the overall center of mass.

## Files

* **`NBP_2D.m`**: MATLAB script for the 2D N-body simulation.
* **`NBP_3D.m`**: MATLAB script for the 3D N-body simulation.

## How to Use

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/amafella/N_body_problem.git
    cd NBP-Simulation
    ```
2.  **Open MATLAB:** Launch MATLAB.
3.  **Run the scripts:**
    * To run the 2D simulation, open `NBP_2D.m` and press `Run`.
    * To run the 3D simulation, open `NBP_3D.m` and press `Run`.

## Customization

Both scripts allow for easy modification of simulation parameters, including:

* `ht`: Time step for the simulation.
* `Nt`: Total number of time steps.
* `Np`: Number of particles in the simulation.
* `G`: Gravitational constant.
* `Masse`: Masses of individual particles.
* Initial positions (`x`, `y`, `z`) and velocities (`vx`, `vy`, `vz`) of the particles.

Feel free to experiment with these parameters to observe different N-body system behaviors.
