

module PiFanBoreHoles() {
    for (i = [0, 90, 180, 270])
        rotate([0, 0, i])
        translate([-23.8/2, -23.8/2, 0])
            children();
};


module PiFan() {
    
    color("grey") {

        difference() {

            translate([-30/2, -30/2, 0])
            cube([30, 30, 7.5]);

            PiFanBoreHoles()
            translate([0, 0, -1])
            cylinder($fn=20, d = 3.4, h = 20);
        }
        
    }
    
};


PiFan();
