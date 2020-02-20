use <../utils/struct.scad>
use <../utils/ZiptieHoop.scad>
include <../config/config.scad>
use <../vitamins/Raspi.scad>
use <../vitamins/RaspiCamera.scad>
use <../vitamins/BatteryCompartment.scad>
use <../vitamins/MainBoard.scad>
use <../vitamins/PowerBoard.scad>
use <../vitamins/DCDCBoard.scad>
use <../vitamins/screws.scad>
use <Wheel.scad>
use <PcbMounts.scad>

include<../vitamins/StepperMotor.scad>



module VerticalConnectionScrewHoles() {
    for (i = [-60, 60, 145, 215])
    rotate([0, 0, i])
    translate([0, bucket_radius - 10, 0])
    children();
}

module CableDucts() {
    translate([25, 0, -20])
    cube([10, 13, 50]);

    translate([-55, -80, -20])
    cube([10, 17, 50]);
}


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



module BasePlate_BatteryLocations() {
    translate([0, -25, -7])
    rotate([180, 0, 180])
    children();

    translate([-43, -50, -7])
    rotate([180, 0, 0])
    children();

    translate([43, -50, -7])
    rotate([180, 0, 0])
    children();
}


module BasePlate() {

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
                size+thickness/2, 
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
                cylinder($fn=40, d=3.3, thickness+2);
            }
        }
    };

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
        
        /*
        color("white")
        translate([0, 0, ball_d/2 + offset])
        sphere($fn=100, d = ball_d);
        */

    }
    module BatteryHolder(clearence = 0.2) {
        difference() {
            translate([-25, -21/2-thickness, -7])
            cube([50, 21+thickness*2, 20]);

            translate([-75.0/2-clearence, -21.0/2-clearence, 0])
            cube([75+clearence*2, 21+clearence*2, 18+clearence*2]);
            
            translate([0, 0, -5])
            rotate([0, 0, 90])
            NutHole_M2();
            translate([0, 0, 1])
            ScrewBore_M2x12();
        }
    };

    union() {
        difference() {
            union() {
                cylinder($fn=200, d = bucket_radius*2, h = thickness);
                
                translate([16, 7, 0])
                rotate([180, 0, 0])
                ZiptieHoop();

                translate([-60, -72, 0])
                rotate([180, 0, 0])
                ZiptieHoop();
            }

            VerticalConnectionScrewHoles()
            translate([0, 0, thickness+1])
            ScrewBore_M3x10();

            CableDucts();

            WheelMount(true)
            cylinder($fn=40, d = wheelDiameter+10, h = wheelWidth + 50);

            WheelMount(false)
            cylinder($fn=40, d = wheelDiameter+10, h = wheelWidth + 50);
                    
            Cutput_PiCamera();
        }
        

        
        mirror([1, 0, 0])
        translate([baseDistance/2 - (22-14.8-2), 0, -lookup(NemaSideSize, Nema17_Andy)/2])
        rotate([0, -90, 0])
        Mount();
        
        translate([baseDistance/2 - (22-14.8-2), 0, -lookup(NemaSideSize, Nema17_Andy)/2])
        rotate([0, -90, 0])
        Mount();



        translate([0, -bucket_radius +50/2, 0])
        rotate([180, 0, 0])
        BallMount(16);
        
        

        
        BasePlate_BatteryLocations()
        BatteryHolder();
    }
}


intersection() {
    BasePlate();
    /*
    union() {
        translate([-10, -40, -50])
        cube([20, 30, 180]);
        
        translate([40, -30, -50])
        cube([50, 60, 80]);
    }
    */
}