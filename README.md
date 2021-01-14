# arm_assembly
Assembly code implementing a simple program to simulate a database storing patient data in hospital wards

# Background
A quarantine facility is a F-level building which has R rooms on each level. Recovered patients from each room are discharged on weekly basis, and the new daily cases are allocated to each room in the building until it reaches the maximum capacity. The objective of this program is to generate the resulted patient distribution in the building after discharged and new cases are considered after one week.

Figure 1 demonstrates an example with overall operation of patient distribution in a quarantine building with 3 levels and 2 rooms/level. The rooms in the building are labelled according to the floor level (F) and room number (R). Initially, there are 10 patients in each room of the building, with mathematical 2D array representation {{10,10}, {10,10}, {10,10}}. Number of patients discharged from each room in this week are represented as {{2,1}, {4,3}, {0,5}}. The new cases for this week is given in daily basis and represented as a 1D array { 8, 7, 6, 5, 4 , 3, 2}.

To generate the resulted patient distribution, two rules need to be followed:

(1) Maximum number of patients in each room is determined by the constant RM_MAX,

(2) New cases need to fill up room by room, from the room indicated as building[0][0]. When the number of patients in the room hits the maximum, new cases start to fill up the next room on the same level.

Therefore, with the given numbers for this example and RM_MAX = 15, the expected patient distribution after this week represented by building[3][2] will be {{15,15}, {15,15}, {15,5}}.

Fig 1:

![Fig 1](https://github.com/jonchuaenzhe/arm_assembly/blob/main/Fig%201.png)

# Objective
The objective of this program is to develop an ARMv7-M assembly language function asm_fun() that generates and updates the quarantine facility building[ ][ ] in weekly basis after considering the discharged and new COVID-19 cases.
