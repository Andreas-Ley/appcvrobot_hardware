
module LCDScreenBoreHoles() {
    for (x = [-75.4/2, 75.4/2])
        for (y = [-31.4/2, 31.4/2])
            translate([x, y, 0])        
                children();
}


module LCDScreen() {
    
    color("blue") {

        translate([-70.7/2, -23.8/2, 7-11])
        cube([70.7, 23.8, 11]);

        difference() {

            translate([-80/2, -36/2, -1.6])
            cube([80, 36, 1.6]);
            
            LCDScreenBoreHoles()
            translate([0, 0, -5])        
                cylinder($fn=20, d = 2.8, h = 10);
        }

        translate([-13, -2, 7-11-9])
        cube([55, 20, 9]);
        
    }
    
};


module LCDScreenCutout(clearence = 0.2) {
    clearence_screen = clearence*2;
    translate([-70.7/2 - clearence_screen, -23.8/2 - clearence_screen, 7-11])
    cube([70.7 + clearence_screen*2, 23.8 + clearence_screen*2, 11]);

    LCDScreenBoreHoles()
    translate([0, 0, -5])        
            cylinder($fn=40, d = 2.8 + clearence*2, h = 20);
};

LCDScreen();
//LCDScreenCutout();