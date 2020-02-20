module AdOnBoreHoles() {
    for (x = [-50.0/2, 50.0/2])
        for (y = [-30/2-5, 30/2+5])
            translate([x, y, 0])        
                children();
}


module AdOn() {
    /*
    color("red") {

        translate([-70.7/2, -23.8/2, 7-11])
        cube([90, 35, 11]);

        difference() {

            translate([-80/2, -36/2, -1.6])
            cube([100, 47.2, 1.6]);
            
            AdOnBoreHoles()
            translate([0, 0, -5])        
                cylinder($fn=20, d = 2.8, h = 10);
        }

        translate([-13, -2, 7-11-9])
        cube([55, 20, 9]);
        
    }
    */
};


module AdOnCutout(clearence = 0.2) {
    translate([-50.0/2, -30.0/2, -10])
        cube([50, 30, 20]);

    AdOnBoreHoles()
    translate([0, 0, -5])        
            cylinder($fn=40, d = 2.8 + clearence*2, h = 20);
};

AdOn();
AdOnCutout();