

module Screw(thread_diameter, thread_length, head_diameter, head_length) {
    
    color("grey") {
        translate([0, 0, -thread_length])
        cylinder($fn=10, d = thread_diameter, h=thread_length);
        
        cylinder($fn=10, d = head_diameter, h=head_length);
    }
    
};

module ScrewBore(thread_diameter, thread_length) {
    translate([0, 0, -thread_length])
    cylinder($fn=30, d = thread_diameter+0.2, h=thread_length);
};


module Nut(nut_diameter, nut_height) {
    cylinder($fn=6, d = nut_diameter, h=nut_height);
};


module Screw_M2x12() {
    Screw(2, 12, 3, 2);
}
module ScrewBore_M2x12() {
    ScrewBore(2, 12);
}

module Screw_M2x8() {
    Screw(2, 8, 3, 2);
}
module ScrewBore_M2x8() {
    ScrewBore(2, 8);
}


module Screw_M2x6() {
    Screw(2, 6, 3, 2);
}

module ScrewBore_M2x6() {
    ScrewBore(2, 6);
}

module Screw_M2x4() {
    Screw(2, 4, 3, 2);
}



module ScrewBore_M3x10() {
    ScrewBore(3, 10);
}




module NutHole(nut_diameter, nut_height, extends = 50) {
    hull() {
        cylinder($fn=6, d = nut_diameter, h=nut_height);
        translate([extends, 0, 0])
        cylinder($fn=6, d = nut_diameter, h=nut_height);
    }
};

module NutHole_M2() {
    NutHole(4.7, 2.2);
}

module NutHole_M3() {
    NutHole(6.2, 2.5);
}
