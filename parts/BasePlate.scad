use <../utils/struct.scad>
use <../vitamins/Raspi.scad>
use <../vitamins/RaspiCamera.scad>
use <../vitamins/BatteryCompartment.scad>
use <../vitamins/MainBoard.scad>
use <../vitamins/PowerBoard.scad>
use <../vitamins/DCDCBoard.scad>
use <MainPcbMount.scad>
use <Wheel.scad>

include<../vitamins/StepperMotor.scad>


baseDistance = 175;
wheelWidth = 20;
wheelDiameter = 70;

function sqr(x)=x*x;

bucket_radius = sqrt(sqr(baseDistance/2+wheelWidth)+sqr(wheelDiameter/2));

thickness = 2;


module WheelMount(left = true) {
    if (left)
        mirror([1, 0, 0])
        translate([-baseDistance/2 + (22-14.8-2), 0, -lookup(NemaSideSize, Nema17_Andy)/2])
        rotate([0, 90, 0])
        Nema17Motor_ShaftAttachment() {
            children();
        }
   else
        translate([-baseDistance/2 + (22-14.8-2), 0, -lookup(NemaSideSize, Nema17_Andy)/2])
        rotate([0, 90, 0])
        Nema17Motor_ShaftAttachment() {
            children();
        }
   
}


module BasePlate() {
    difference() {
        cylinder($fn=80, d = bucket_radius*2, h = thickness);

        WheelMount(true)
        cylinder($fn=40, d = wheelDiameter+10, h = wheelWidth + 50);

        WheelMount(false)
        cylinder($fn=40, d = wheelDiameter+10, h = wheelWidth + 50);
                
        RpiCameraConfig = RaspiCamera_config();

        cam_width = get(RpiCameraConfig, "width");
        translate([0, 65, cam_width/2+5])
        rotate([-90, 0, 0])
        cylinder($fn=40, d1 = 0, d2=100*tan(160/2), h = 100);
    }
    
    size = lookup(NemaSideSize, Nema17_Andy);
    length = lookup(NemaLengthMedium, Nema17_Andy);
    extrusionDiameter = lookup(NemaRoundExtrusionDiameter, Nema17_Andy);
    extrusionHeight = lookup(NemaRoundExtrusionHeight, Nema17_Andy);

    module Mount() {
        difference() {
/*
            translate([-lookup(NemaSideSize, Nema17_Andy)/2, -lookup(NemaSideSize, Nema17_Andy)/2, 0])
            cube([lookup(NemaSideSize, Nema17_Andy), lookup(NemaSideSize, Nema17_Andy), thickness]);
*/
            translate([
                    -lookup(NemaSideSize, Nema17_Andy)/2, 
                    -lookup(NemaSideSize, Nema17_Andy)/2 - thickness, 
                    0])
            cube([
                size, 
                size+2*thickness,
                length+thickness]);

            translate([
                    -lookup(NemaSideSize, Nema17_Andy)/2-1, 
                    -lookup(NemaSideSize, Nema17_Andy)/2,
                    extrusionHeight])
            cube([
                size+1, 
                size,
                length+thickness]);

            translate([
                    -18/2 - 20, 
                    lookup(NemaSideSize, Nema17_Andy)/2-1,
                    length-10])
            cube([
                38, 
                15,
                15]);

            translate([0, 0, -1])
            cylinder($fn=40, d=extrusionDiameter+1, thickness+2);
            
            Nema17Motor_ScrewAttachment() {
                translate([0, 0, -1])
                cylinder($fn=40, d=2.3, thickness+2);
            }
        }
    };
    
    mirror([1, 0, 0])
    translate([baseDistance/2 - (22-14.8-2), 0, -lookup(NemaSideSize, Nema17_Andy)/2])
    rotate([0, -90, 0])
    Mount();
    
    translate([baseDistance/2 - (22-14.8-2), 0, -lookup(NemaSideSize, Nema17_Andy)/2])
    rotate([0, -90, 0])
    Mount();


    module BallMount(offset = 2) {
        ball_d = 40;

        translate([0, 0, ball_d/2 + offset])
        difference() {
            union() {
                sphere($fn=100, d = ball_d+thickness*2);
                translate([0, 0, -ball_d/2-offset])
                cylinder($fn=40, d1 = 50, d2 = 25, h = 10+offset);
            }
            
            sphere($fn=100, d = ball_d+0.5);
            translate([-25, -25, 10])
            cube([50, 50, 50]);

            for (i = [0:3])
                rotate([0, 0, i/4*180])
                translate([-25, -thickness/2, -15])
                cube([50, thickness, 50]);
        }
        
        color("white")
        translate([0, 0, ball_d/2 + offset])
        sphere($fn=100, d = ball_d);

    }
    translate([0, -bucket_radius +50/2, 0])
    rotate([180, 0, 0])
    BallMount(16);
}


module Lid() {
    topDiameter = bucket_radius*2-50;
    height = 30;
        
    difference() {
        translate([0, 0, thickness])
        cylinder($fn=80, d1 = bucket_radius*2, d2=topDiameter, h = height);
        translate([0, 0, thickness])
        cylinder($fn=80, d1 = bucket_radius*2-thickness*2, d2=topDiameter-thickness*2, h = height-thickness);

        WheelMount(true)
            cylinder($fn=40, d = wheelDiameter+10, h = wheelWidth + 50);
        
        WheelMount(false)
            cylinder($fn=40, d = wheelDiameter+10, h = wheelWidth + 50);
        
        RpiCameraConfig = RaspiCamera_config();

        cam_width = get(RpiCameraConfig, "width");
        translate([0, 65, cam_width/2+5])
        rotate([-90, 0, 0])
        cylinder($fn=40, d1 = 0, d2=100*tan(160/2), h = 100);
    }
}

difference() {
    Lid();
    translate([-200, -200, 10])
    cube([400, 400, 200]);
}

BasePlate();

translate([-baseDistance/2 + (22-14.8-2), 0, -lookup(NemaSideSize, Nema17_Andy)/2])
rotate([0, 90, 0])
Nema17Motor();

translate([baseDistance/2 - (22-14.8-2), 0, -lookup(NemaSideSize, Nema17_Andy)/2])
rotate([0, -90, 0])
Nema17Motor();


WheelMount(true) {
    WheelSpokes(wheelWidth, wheelDiameter);
    WheelRubber(wheelWidth, wheelDiameter);
}

WheelMount(false) {
    WheelSpokes(wheelWidth, wheelDiameter);
    WheelRubber(wheelWidth, wheelDiameter);
}

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


translate([-5, -45, thickness+2])
color("green"){
    Mainboard(Mainboard_config());
    AlignPowerBoardToMainBoard()
       PowerBoard(PowerBoard_config());
}


translate([60, -48, thickness+2])
color("green")
rotate([0, 0, 90])
DCDCBoard(DCDCBoard_config());

if (false)
for (i = [-1, 0, 1])
    translate([i*22, -12, 0])
    rotate([180, 0, 90])
    BatteryCompartment();

translate([0, -25, 0])
rotate([180, 0, 0])
BatteryCompartment();

translate([-40, -50, 0])
rotate([180, 0, 0])
BatteryCompartment();

translate([40, -50, 0])
rotate([180, 0, 0])
BatteryCompartment();
