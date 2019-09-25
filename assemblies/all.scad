use <../utils/struct.scad>
include <../config/config.scad>
use <../vitamins/Raspi.scad>
use <../vitamins/RaspiCamera.scad>
use <../vitamins/BatteryCompartment.scad>
use <../vitamins/MainBoard.scad>
use <../vitamins/PowerBoard.scad>
use <../vitamins/DCDCBoard.scad>
use <../parts/Wheel.scad>
use <../parts/Lid.scad>
use <../parts/BasePlate.scad>
use <../parts/PcbMounts.scad>
use <PcbsAssembled.scad>
include<../vitamins/StepperMotor.scad>


module All(explode = 0.0) {
translate([0, 0, explode * 100])
Lid();

translate([0, 0, explode * 100])
VerticalConnectionScrewHoles()
LidScrewCone();

BasePlate();

translate([-baseDistance/2 + (22-14.8-2), 0, -lookup(NemaSideSize, Nema17_Andy)/2])
rotate([0, 90, 0])
Nema17Motor();

translate([baseDistance/2 - (22-14.8-2), 0, -lookup(NemaSideSize, Nema17_Andy)/2])
rotate([0, -90, 0])
Nema17Motor();


translate([explode * 20, 0, 0])
WheelMount(true) {
    WheelSpokes(wheelWidth, wheelDiameter);
    WheelRubber(wheelWidth, wheelDiameter);
}

translate([-explode * 20, 0, 0])
WheelMount(false) {
    WheelSpokes(wheelWidth, wheelDiameter);
    WheelRubber(wheelWidth, wheelDiameter);
}



PcbsAssembled();

/*
translate([-20, 15, thickness+2]) {
    RPiMount(20);
    translate([0, 0, 5+1])
    color("green")
    Raspi(Raspi_config());
    

    RpiCameraConfig = RaspiCamera_config();

    cam_width = get(RpiCameraConfig, "width");
    translate([20, 40, cam_width/2+1])
    rotate([-90, 0, 0])
    color("green")
    RaspiCamera(RpiCameraConfig);
    
}
*/


BasePlate_BatteryLocations()
BatteryCompartment();
}


All();
//All(1.0);
/*
difference() {
    All();

    translate([0, -200, -200])
    cube([400, 400, 400]);
}
*/