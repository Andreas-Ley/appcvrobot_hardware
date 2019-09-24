module BatteryCompartment(clearence = 0.0) {
    color("yellow")
    translate([-75.0/2-clearence, -21.0/2-clearence, 0])
    cube([75+clearence*2, 21+clearence*2, 18+clearence*2]);
    
    if (clearence > 0.0) {
        translate([-75.0/2-clearence - 2-1, -21.0/2-clearence - 2, 0])
        cube([5, 4, 18+clearence*2]);
        translate([75.0/2+clearence - 2, 21.0/2+clearence - 2, 0])
        cube([5, 4, 18+clearence*2]);
    }
};

