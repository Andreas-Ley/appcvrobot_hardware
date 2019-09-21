use <../utils/struct.scad>



w = 65;
h = 55;

bore_sep = 53.5;
battery_hole_at = 45;
battery_hole_d = 7;
battery_hole_h = 8;

ball_d = 40;


color("white")
sphere($fn=100, d = ball_d);


thickness = 2;

difference() {
    union() {
        sphere($fn=100, d = ball_d+thickness*2);
        translate([0, 0, -(ball_d+thickness*2)/2])
        cylinder($fn=40, d1 = 50, d2 = 10, h = 10);
        
        translate([0, 0, -(ball_d+thickness*2)/2-thickness/2])
        cube([w, h, thickness], center=true);
    }
    for (i = [-bore_sep/2, bore_sep/2])
        translate([i, h/2-4.1, -(ball_d+thickness*2)/2-thickness])
        cylinder($fn=40, d = 4, h = thickness);
    
    translate([0, h/2-battery_hole_at, -(ball_d+thickness*2)/2-thickness])
    cylinder($fn=40, d = battery_hole_d, h = battery_hole_h);
    
    
    sphere($fn=100, d = ball_d+0.5);
    translate([-25, -25, 10])
    cube([50, 50, 50]);

    for (i = [0:3])
        rotate([0, 0, i/4*180])
        translate([-25, -thickness/2, -15])
        cube([50, thickness, 50]);
}