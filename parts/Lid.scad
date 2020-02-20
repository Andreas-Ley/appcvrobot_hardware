use <../utils/struct.scad>
use <../utils/ZiptieHoop.scad>
include <../config/config.scad>
use <../vitamins/RaspiCamera.scad>
use <../vitamins/screws.scad>
use <../vitamins/switch.scad>
use <../vitamins/LCDScreen.scad>
use <../vitamins/button.scad>
use <../vitamins/PiFan.scad>
use <../vitamins/AdOn.scad>

use <BasePlate.scad>
use <PcbMounts.scad>

Lid_height = 50;

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

module Lid_PlaceButton() {
    translate([-45, -bucket_radius+130, Lid_height+thickness*2])
    children();
}


module Lid_PlaceLCDScreen() {
    rotate([0,0,90])
    translate([24, -bucket_radius+75, Lid_height+thickness*2 - thickness-3])
    children();
}

module Lid_PlaceAdOn() {
    translate([0, -bucket_radius+62, Lid_height+thickness*2 - thickness-3])
    children();
}

module Lid_PlaceFanDuct() {
    translate([0, 25, Lid_height+thickness*2])
    children();
}

module Lid_PlaceFan() {
    Lid_PlaceFanDuct()
    translate([0, 0, -15])
    rotate([180, 0, 0])
    children();
}


module Lid() {
    topDiameter = bucket_radius*2-50;
    
        
    union() {
        difference() {
            translate([0, 0, thickness*2])
            cylinder($fn=200, d1 = bucket_radius*2, d2=topDiameter, h = Lid_height);
            difference() {
                translate([0, 0, thickness*2-0.01])
                cylinder($fn=200, d1 = bucket_radius*2-thickness*2, d2=topDiameter-thickness*2, h = Lid_height-thickness);
                
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
            translate([0, 0, thickness*2 - 0.01])
            cylinder($fn=40, d1 = 5, d2 = 10, h = 35);

            WheelMount(true)
                cylinder($fn=40, d = wheelDiameter+10, h = wheelWidth + 50);
            
            WheelMount(false)
                cylinder($fn=40, d = wheelDiameter+10, h = wheelWidth + 50);
            
            Cutput_PiCamera();

            Lid_PlaceButton()
            ButtonHole();
            
            Lid_PlaceLCDScreen()
            LCDScreenCutout();
            
            Lid_PlaceAdOn()
            AdOnCutout();
            difference() {
            translate([0, 0, 0])
            cylinder($fn=40, d=5.5, h=3.1);
            translate([0, 0, -1])
            cylinder($fn=40, d=2.8+0.2*2, h=10);
        }
            
            Lid_PlaceFanDuct() {
                translate([0, 0, -thickness-2])
                intersection() {
                    union() {
                        for (y = [-7:7]) {
                            for (x = [-7:7]) {
                                translate([x*2 + y*4, x*2 - y*4+0, 0])
                                cube([3.5, 1.5, 5]);
                                translate([x*2 + y*4, x*2 - y*4+2, 0])
                                cube([1.5, 3.5, 5]);
                            }
                        }
                    }
                    
                    cylinder($fn=80, d=27, h=5);
                }
            }
            
            for (j = [0:3]) {
                for (i = [-7:7]) {
                    rotate([0, 0, i*3])
                    translate([0, -bucket_radius+50, 0])
                    rotate([90, 0, 0])
                    hull() {
                        translate([0, 10+j*10, 0])
                        cylinder($fn=40, d=2, h=50);
                        translate([0, 15+j*10, 0])
                        cylinder($fn=40, d=2, h=50);
                    }
                }
            }
            
        }
        
        Lid_PlaceLCDScreen()
        LCDScreenBoreHoles()
        difference() {
            translate([0, 0, 0])
            cylinder($fn=40, d=5.5, h=3.1);
            translate([0, 0, -1])
            cylinder($fn=40, d=2.8+0.2*2, h=10);
        }
        
        Lid_PlaceAdOn()
        difference() {
            AdOnBoreHoles()
            translate([0, 0, 0])
            cylinder($fn=40, d1=5.5, d2=15, h=3.1);
            //translate([0, 0, -1])
            //cylinder($fn=40, d=2.8+0.2*2, h=10);
            AdOnCutout();
        }

        
        Lid_PlaceFanDuct() 
        difference() {
            translate([-32/2, -32/2, -15])
            cube([32, 32, 15-thickness]);

            translate([0, 0, -20])
            cylinder($fn=80, d=27, h=50);
            
            PiFanBoreHoles() {
                translate([0, 0, -20])
                cylinder($fn=80, d=3.5, h=50);
                
                translate([0, 0, -thickness-15+4])
                rotate([0, 0, -90])
                NutHole_M3();
            }
        }
        
        translate([-30, 10, Lid_height+thickness+0.1])
        rotate([180, 0, 0])
        ZiptieHoop();

        translate([-60, -15, Lid_height+thickness+0.1])
        rotate([180, 0, 0])
        ZiptieHoop();

        translate([-40, -40, Lid_height+thickness+0.1])
        rotate([180, 0, 0])
        ZiptieHoop();
        
        translate([-20, -10, Lid_height+thickness+0.1])
        rotate([180, 0, 0])
        ZiptieHoop();
/*
        WheelMount(false)
        translate([-55, 40, -thickness+0.1])
        rotate([180, 0, 90])
        ZiptieHoop();
*/
    }
}

/*
intersection() {
    Lid();
    
    union() {
        translate([5, 8, -40])
        cube([15, 15, 800]);
        
        translate([33, -45, -40])
        cube([10, 42, 800]);
        
        translate([-9, -60, -40])
        cube([18, 14, 800]);

    }
}
*/

Lid();

for (i = [0:3])
translate([i*20, 150, 0])
LidScrewCone();
