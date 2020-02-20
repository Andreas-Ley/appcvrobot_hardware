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
include<../vitamins/StepperMotor.scad>


module All(explode = 0.0) {

translate([0, 0, max(0, explode-0.1) * 100]) {
    Lid();
    
    Lid_PlaceButton()
    translate([0, 0, max(0, explode-0.8) * 500])
    Button();
    
    Lid_PlaceLCDScreen()
    translate([0, 0, max(0, explode-0.8) * -300])
    LCDScreen();
    
    Lid_PlaceAdOn()
    translate([0, 0, max(0, explode-0.8) * -300])
    AdOn();
    
    Lid_PlaceFan()
    translate([0, 0, max(0, explode-0.8) * -300])
    PiFan();
}

translate([0, 0, explode * 150])
VerticalConnectionScrewHoles()
LidScrewCone();

BasePlate();

translate([-baseDistance/2 + (22-14.8-2), 0, -lookup(NemaSideSize, Nema17_Andy)/2])
rotate([0, 90, 0])
Nema17Motor();

translate([baseDistance/2 - (22-14.8-2), 0, -lookup(NemaSideSize, Nema17_Andy)/2])
rotate([0, -90, 0])
Nema17Motor();


translate([explode * 30, 0, 0])
WheelMount(true) {
    WheelSpokes(wheelWidth, wheelDiameter);
    translate([0, 0, max(0, explode-0.7) * 190])
    WheelRubber(wheelWidth, wheelDiameter);
}

translate([-explode * 30, 0, 0])
WheelMount(false) {
    WheelSpokes(wheelWidth, wheelDiameter);
    translate([0, 0, max(0, explode-0.7) * 190])
    WheelRubber(wheelWidth, wheelDiameter);
}


translate([0, 0, max(0, explode-0.5)*60])
PcbsAssembled();

translate([-5, -45, thickness*2])
cube([10, 10, 27]);


translate([-5, 5, thickness*2])
cube([10, 10, 22]);

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
translate([0, 0, max(0, explode-0.8)*400])
BatteryCompartment();

BasePlate_BatteryLocations()
Screw_M2x6();

}


//All();
//rotate([0, 0, $t*360*2])
//All(max(0, 1-$t*1.1));

difference() {
    All(0.0);

    translate([-200, 50, -200])
    cube([400, 400, 400]);
/*
    translate([-400, -200, -200])
    cube([400, 400, 400]);
    */
}
