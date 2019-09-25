use <../utils/struct.scad>
include <../config/config.scad>
use <../vitamins/RaspiCamera.scad>
use <../vitamins/screws.scad>

use <BasePlate.scad>
use <PcbMounts.scad>



module LidScrewCone() {
    difference() {
        translate([0, 0, thickness*2])
        cylinder($fn=40, d1 = 5, d2 = 10, h = 35);    
        
        translate([-10, -10, thickness*2-0.1])
        cube([20, 20, 5]);

        translate([-20, -20, thickness*2 + 10])
        cube([40, 40, 100]);
        
        translate([0, 0, thickness*2 + 10+0.1])
        ScrewBore_M3x10();
    }
}

module Lid() {
    topDiameter = bucket_radius*2-50;
    height = 40;
        
    difference() {
        translate([0, 0, thickness*2])
        cylinder($fn=80, d1 = bucket_radius*2, d2=topDiameter, h = height);
        difference() {
            translate([0, 0, thickness*2])
            cylinder($fn=80, d1 = bucket_radius*2-thickness*2, d2=topDiameter-thickness*2, h = height-thickness);
            
            VerticalConnectionScrewHoles()
            cylinder($fn=40, d = 12, h = 50);
            
            translate([0, -thickness, 0])
            PcbMounts_PlacePiCamera()
            cylinder($fn=40, d1 = 0, d2=100*tan(160/2), h = 100);
            
            WheelMount(true)
                translate([-100, -wheelDiameter/2-5-thickness, -thickness])
                cube([200, wheelDiameter+10+thickness*2, 100]);
            
            WheelMount(false)
                translate([-100, -wheelDiameter/2-5-thickness, -thickness])
                cube([200, wheelDiameter+10+thickness*2, 100]);
        }
        VerticalConnectionScrewHoles()
        translate([0, 0, thickness*2])
        cylinder($fn=40, d1 = 5, d2 = 10, h = 35);

        WheelMount(true)
            cylinder($fn=40, d = wheelDiameter+10, h = wheelWidth + 50);
        
        WheelMount(false)
            cylinder($fn=40, d = wheelDiameter+10, h = wheelWidth + 50);
        
        Cutput_PiCamera();
        
        VerticalConnectionScrewHoles()
        translate([0, 0, 25])
        ScrewBore_M3x10();

    }
}

Lid();

for (i = [0:3])
translate([i*20, 150, 0])
LidScrewCone();
