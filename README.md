<h1 align="center">
  <br>
  <a href="https://github.com/"><img src="https://github.com/Awrsha/Tello-Drone-Object-Following/assets/89135083/d5d03b44-eb26-4093-b4dd-1679c6530d1c" alt="QUAD" width="600"></a>
  <b><h4 align="center">.:: mrl-hsl humanoid robot simulation ::.</h4></b>
</h1>


## Table of contents
* [General info](#general-info)
* [Instructions](#instructions)


## General info
This Simulator has been written in MATLAB R2018a
	
  
## Instructions
* 1) Run Robot-init.m
* 2) Run Robot.slx
* 3) If you want to activate force sensors: In Robot.slx go to Robot simulation block>Left Leg block (and Right Leg block)> Uncomment Floor model block
* 4) you can also adjust gravity in Robot-init.m by changing robot_gravity to [0 0 -9.81];


# Robot Control GUI

This project implements a GUI to control a 20-degree-of-freedom robotic arm.

## Description

The GUI allows controlling each joint of the robotic arm by adjusting slider values. It shows the current angle value for each joint.

The GUI is implemented in MATLAB using GUIDE. It interacts with the robot model and control system also built in Simulink and MATLAB.

Key files:

- `gui_kine.m` - Main GUI logic and callbacks
- `Robot_init.m` - Robot model parameters and initialization
- `Transform.m` - Helper class for coordinate transforms
- `CM730.m` - Sensor data bus

## Getting Started

1. Make sure MATLAB and Simulink are installed.
2. Download the project code.
3. Open `gui_kine.m` in GUIDE (MATLAB's GUI development tool) to launch the GUI.
   - In MATLAB, go to the "Apps" tab, then select "MATLAB Compiler" and click "Apps" again to launch GUIDE.
4. Adjust sliders to control joint angles.
5. Run the Simulink model to visualize robot motion.

## Usage

The GUI displays the current angle value for each joint. Sliders can be dragged to set new joint angles.

For example, this project can be used for robotic arm control in an educational setting, research, or for controlling a specific robot. Running the Simulink model will animate the robot motion based on the joint angles set in the GUI.

The CM730 sensor bus can be overridden to simulate sensor values.

## Acknowledgments

- MATLAB and Simulink provide the development environment.
- Robot model parameters are based on research on the DarwinOP robot.

## TODO

- [ ] Add joint limit validation.
- [ ] Integrate with real robot hardware.
- [ ] Refactor GUI code for reusability.
- [ ] Add 3D visualization.
