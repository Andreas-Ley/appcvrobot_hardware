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
use <BasePlateAssembled.scad>
use <WheelAssembly.scad>
include<../vitamins/StepperMotor.scad>


module All(explode = 0.0) {

    translate([0, 0, explode * 150])
    LidAssembled(explode);

    translate([0, 0, explode * 150])
    VerticalConnectionScrewHoles() {
        LidScrewCone();
        
        translate([0, 0, 14.1])
        Screw_M3x16("Screws_LidBase");
        
        translate([0, 0, -2.1])
        Nut_M3("Nuts_LidBase");
    }


    WheelMount(true)
    WheelAssembled(explode, "L");

    WheelMount(false)
    WheelAssembled(explode, "R");


    translate([0, 0, max(0, explode-0.5)*60])
    PcbsAssembled(explode);

    BasePlateAssembled(explode);

}


//All();
//rotate([0, 0, $t*360*2])
//All(max(0, 1-$t*1.1));

difference() {
    All(1.0);
/*
    translate([-200, -85, -200])
    cube([400, 400, 400]);
/*
    translate([-400, -200, -200])
    cube([400, 400, 400]);
    */
}
