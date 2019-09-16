use <../utils/struct.scad>

use <../vitamins/Raspi.scad>
use <../vitamins/RaspiCamera.scad>


lift = 5;

RpiConfig = Raspi_config();
/*
translate([0, 0, lift])
color("green")
Raspi(RpiConfig);
*/


RpiCameraConfig = RaspiCamera_config();

cam_width = get(RpiCameraConfig, "width");
/*
translate([0, 50, cam_width/2+1])
rotate([-90, 0, 0])
RaspiCamera(RpiCameraConfig);
*/





width = get(RpiConfig, "width");
height = get(RpiConfig, "height");

bore_locations = [
    [
    -width/2 + 3.5, 
    -height/2 + 3.5, 
    0],[
    -width/2 + 3.5 + get(RpiConfig, "bore_spread_w"), 
    -height/2 + 3.5,
    0],[
    -width/2 + 3.5, 
    -height/2 + 3.5 + get(RpiConfig, "bore_spread_h"), 
    0],[
    -width/2 + 3.5 + get(RpiConfig, "bore_spread_w"), 
    -height/2 + 3.5 + get(RpiConfig, "bore_spread_h"), 
    0]
];


difference() {
    union() {
        translate([0, 0, 1])
        cube([92, 65, 2], center = true);
        for (loc = bore_locations)
            translate(loc)
            cylinder($fn=40, d1 = 10, d2 = 6, h = lift);

        translate([0, 31, (cam_width+1)/2])
        cube([cam_width, 3, cam_width+1], center = true);
        
        chunk_size = cam_width / 10;
        for (i = [1:3])
            translate([-cam_width/2 + i*2 * chunk_size, 31+4, (cam_width + 4)]) {
                hull() {
                    translate([0, -4-1.5, -4-chunk_size/2-0.1])
                    cube([chunk_size-0.1, 3, 3]);
                    
                    rotate([0, 90, 0])
                    cylinder($fn=20, d = 6, h = chunk_size-0.1);
                }
            }
        for (i = [1:3])
            translate([-cam_width/2 + (i*2+1) * chunk_size, 31+4, (cam_width + 4)]) {
                hull() {
                    translate([0, +1.5, -4-chunk_size/2-0.1])
                    cube([chunk_size-0.1, 3, 3]);
                    
                    rotate([0, 90, 0])
                    cylinder($fn=20, d = 6, h = chunk_size-0.1);
                }
            }
        translate([0, 31+4+3, cam_width/2+1])
        cube([cam_width, 3, cam_width], center = true);
    }
    translate([-cam_width/2-2, 31+4, (cam_width + 4)])
    rotate([0, 90, 0])
    cylinder($fn=20, d = 3.2, h = 200);
    
    
    translate([0, 35, cam_width/2+1])
    rotate([-90, 0, 0]) {
        for (i = [0, 90, 180, 270]) {
            rotate([0, 0, i])
            translate([get(RpiCameraConfig, "bore_distance")/2, get(RpiCameraConfig, "bore_distance")/2, -1])
            cylinder($fn=20, d = get(RpiCameraConfig, "bore_diameter"), h = 10);
        }
    }

    
    
    for (loc = bore_locations)
        translate(loc) {
            translate([0, 0, -1])
            cylinder($fn=20, d = 2.5, h = lift+2);

            nut_m2_h = 2.0;
            nut_m2_d = 4.5;
            
            translate([0, 0, -1])
            cylinder($fn=6, d = nut_m2_d, h = nut_m2_h);
        }

    for (x = [-85/2, 85/2])
        translate([x, 0, -1])
        cylinder($fn=20, d = 2.5, h = 4);
        
    
}