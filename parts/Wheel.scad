include<../vitamins/StepperMotor.scad>

module WheelSpokes(wheelWidth = 20, wheelDiameter = 70) {
    
    axle_d = lookup(NemaAxleDiameter, Nema17_Andy);
    
    flexWidth = 5;
    
    inner_shaft_d = 13;
    clearence = 0.1;
    thickness = 2;
    difference() {
        
        union() {
            cylinder($fn=80, d = inner_shaft_d, h = wheelWidth);
            translate([0, 0, 7]) {
                for (i = [0:10])
                    rotate([0, 0, i/10*360])
                    translate([0, -thickness/2, 0])
                    cube([(wheelDiameter-2*flexWidth-thickness)/2, thickness, wheelWidth-7]);

                difference() {
                    cylinder($fn=80, d = wheelDiameter-2*flexWidth, h = wheelWidth-7);
                    translate([0, 0, -1])
                    cylinder($fn=80, d = wheelDiameter-2*flexWidth-2*thickness, h = wheelWidth-7+2);
                }
            }
        }
        cylinder($fn=80, d = axle_d+clearence, h = wheelWidth-2);
        
        nut_m2_h = 2.0;
        nut_m2_d = 4.5;
        
        translate([0, 0, 4])
        rotate([0, 90, 0])
        cylinder($fn=20, d = 2.5    
    
, h = inner_shaft_d);
        hull() {
            translate([0, 0, 4])
            rotate([0, 90, 0])
            cylinder($fn=6, d = nut_m2_d, h = axle_d/2+nut_m2_h);

            translate([0, 0, 0])
            rotate([0, 90, 0])
            cylinder($fn=6, d = nut_m2_d, h = axle_d/2+nut_m2_h);
        }
        

    }
}


module WheelRubber(wheelWidth = 20, wheelDiameter = 70) {
    
    flexWidth = 5;
    
    inner_shaft_d = 13;
    clearence = 0.1;
    thickness = 2;
    color("grey")
    translate([0, 0, 7])
    difference() {
        
        cylinder($fn=80, d = wheelDiameter, h = wheelWidth-7);
        translate([0, 0, -1])
        cylinder($fn=80, d = wheelDiameter-2*flexWidth, h = wheelWidth-7+2);


        for (i = [0:50])
        rotate([0, 0, i/50*360])
        translate([wheelDiameter/2-1, -0.5, -1])
        cube([2, 1, 20]);
   }
}



if (false)
intersection() {
    union() {
        Nema17Motor();

        Nema17Motor_ShaftAttachment() {
            WheelSpokes();
            WheelRubber();
        }
    }
    translate([-100, 0, -100])
    cube([200, 200, 200]);
}

WheelSpokes();
translate([0, 0, 20])
WheelRubber();
