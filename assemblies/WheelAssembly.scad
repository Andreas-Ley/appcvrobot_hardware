use <../utils/struct.scad>
include <../config/config.scad>
use <../vitamins/Raspi.scad>
use <../vitamins/RaspiCamera.scad>
use <../vitamins/BatteryCompartment.scad>
use <../vitamins/MainBoard.scad>
use <../vitamins/PowerBoard.scad>
use <../vitamins/DCDCBoard.scad>
use <../vitamins/screws.scad>
use <../vitamins/switch.scad>
use <../vitamins/button.scad>
use <../vitamins/LCDScreen.scad>
use <../vitamins/AdOn.scad>
use <../vitamins/PiFan.scad>
use <../parts/Wheel.scad>
use <../parts/Lid.scad>
use <../parts/BasePlate.scad>
use <../parts/PcbMounts.scad>
use <PcbsAssembled.scad>
use <LidAssembled.scad>
include<../vitamins/StepperMotor.scad>


module WheelAssembled(explode = 0.0, leftRight = "L") {
    translate([0, 0, explode * 30])
    WheelSpokes(wheelWidth, wheelDiameter);

    translate([0, 0, explode * 30 + max(0, explode-0.7) * 190])
    WheelRubber(wheelWidth, wheelDiameter);
    
    translate([2.3, 0, 4])
    rotate([0, 90, 0])
    Nut_M2(str("Nut_Wheel_", leftRight));

    translate([7, 0, 4])
    rotate([0, 90, 0])
    Screw_M2x6(str("Screw_Wheel_", leftRight));
}

WheelAssembled();