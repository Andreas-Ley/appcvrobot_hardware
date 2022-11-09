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


module BasePlateAssembled(explode = 0.0) {


    BasePlate();

    echo("BOM: Stepper_L");
    translate([-baseDistance/2 + (22-14.8-2), 0, -lookup(NemaSideSize, Nema17_Andy)/2])
    rotate([0, 90, 0])
    Nema17Motor();

    echo("BOM: Stepper_R");
    translate([baseDistance/2 - (22-14.8-2), 0, -lookup(NemaSideSize, Nema17_Andy)/2])
    rotate([0, -90, 0])
    Nema17Motor();


    echo("BOM: PingPongBall");
    color("white")
    translate([0, -bucket_radius +50/2, 0])
    translate([0, 0, -40/2 - 16])
    sphere($fn=100, d = 40);


/*

    BasePlate_BatteryLocations() {
        echo("BOM: BatteryHolder_{1..3}");
        translate([0, 0, max(0, explode-0.8)*400])
        BatteryCompartment();
    }
*/


    BasePlate_BatteryLocations() {
        translate([0, 0, 1])
        Screw_M2x6("Screw_BatteryHolder_{1..3} (better: M2x8 conical head w. M2 washer)");
        
        translate([0, 0, -4.8])
        Nut_M2("Nut_BatteryHolder_{1..3}");
    }
    
    

    mirror([1, 0, 0])
    translate([baseDistance/2 - (22-14.8-2), 0, -lookup(NemaSideSize, Nema17_Andy)/2])
    rotate([0, -90, 0])
    Nema17Motor_ScrewAttachment()
    translate([0, 0, 2.2])
    Screw_M3x6("Screws_MotorMount_L");
    
    translate([baseDistance/2 - (22-14.8-2), 0, -lookup(NemaSideSize, Nema17_Andy)/2])
    rotate([0, -90, 0])
    Nema17Motor_ScrewAttachment()
    translate([0, 0, 2.2])
    Screw_M3x6("Screws_MotorMount_R");

}


difference() {
    BasePlateAssembled(0.0);
/*
    translate([-200, -50, -200])
    cube([400, 400, 400]);
/*
    translate([-400, -200, -200])
    cube([400, 400, 400]);
    */
}
