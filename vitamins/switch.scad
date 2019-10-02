

module Switch() {
    
    color("darkgrey") {
        
        translate([0, 0, -0.5])
        rotate([0, 20, 0])
        translate([-10/2, -6.2/2, -0.5])
        cube([10, 6.2, 3]);

        translate([-15/2, -10.5/2, 0])
        cube([15, 10.5, 1.5]);
        
        translate([-13/2, -8.4/2, -8.7])
        cube([13, 8.4, 8.7]);
        
        for (i = [-5, 0]) {
            translate([-0.4/2+i, -1/2, -8.7-5.8])
            cube([0.4, 1, 5.8]);

            translate([-0.4/2+i, -8, -8.7-5.8])
            cube([0.4, 8, 1]);
        }
    }
    
};

module SwitchHole(clearence = 0.2) {

    translate([-13/2 - clearence, -8.4/2 - clearence, -8.7])
    cube([13 + clearence*2, 8.4 + clearence*2, 8.7+1.5]);
};

Switch();
SwitchHole();