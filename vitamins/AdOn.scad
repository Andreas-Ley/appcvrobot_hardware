module AdOnBoreHoles() {
    for (x = [-75.4/2, 75.4/2+20])
        for (y = [-31.4/2, 31.4/2+11.2])
            translate([x, y, 0])        
                children();
}


module AdOn() {
    
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
    
};


module AdOnCutout(clearence = 0.2) {
    translate([-70.7/2, -23.8/2, 7-11])
        cube([90, 35, 11]);

    AdOnBoreHoles()
    translate([0, 0, -5])        
            cylinder($fn=40, d = 2.8 + clearence*2, h = 20);
};

AdOn();
AdOnCutout();