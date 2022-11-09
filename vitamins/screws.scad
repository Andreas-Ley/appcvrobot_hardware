

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
    color("grey") {
        cylinder($fn=6, d = nut_diameter, h=nut_height);
    }
};

module Nut_M2(reference = "") {
    Nut(4.5, 2.0);
    if (reference != "")
        echo(str("BOM: Nut M2   ", reference));
}

module Nut_M3(reference = "") {
    Nut(6, 2.0);
    if (reference != "")
        echo(str("BOM: Nut M3   ", reference));
}


module Screw_M2x12(reference = "") {
    Screw(2, 12, 3, 2);
    if (reference != "")
        echo(str("BOM: M2x12   ", reference));
}
module ScrewBore_M2x12() {
    ScrewBore(2, 12);
}

module Screw_M2x8(reference = "") {
    Screw(2, 8, 3, 2);
    if (reference != "")
        echo(str("BOM: M2x8   ", reference));
}
module ScrewBore_M2x8() {
    ScrewBore(2, 8);
}


module Screw_M2x6(reference = "") {
    Screw(2, 6, 3, 2);
    if (reference != "")
        echo(str("BOM: M2x6   ", reference));
}

module ScrewBore_M2x6() {
    ScrewBore(2, 6);
}

module Screw_M2x4(reference = "") {
    Screw(2, 4, 3, 2);
    if (reference != "")
        echo(str("BOM: M2x4   ", reference));
}



module ScrewBore_M3x10() {
    ScrewBore(3, 10);
}

module Screw_M3x6(reference = "") {
    Screw(3, 6, 5, 2.5);
    if (reference != "")
        echo(str("BOM: M3x6   ", reference));
}


module Screw_M3x10(reference = "") {
    Screw(3, 10, 5, 2.5);
    if (reference != "")
        echo(str("BOM: M3x10   ", reference));
}

module Screw_M3x12(reference = "") {
    Screw(3, 12, 5, 2.5);
    if (reference != "")
        echo(str("BOM: M3x12   ", reference));
}

module Screw_M3x16(reference = "") {
    Screw(3, 16, 5, 2.5);
    if (reference != "")
        echo(str("BOM: M3x16   ", reference));
}


module Screw_M3x25(reference = "") {
    Screw(3, 25, 5, 2.5);
    if (reference != "")
        echo(str("BOM: M3x25   ", reference));
}

module NutHole(nut_diameter, nut_height, extends = 50) {
    hull() {
        cylinder($fn=6, d = nut_diameter, h=nut_height);
        translate([extends, 0, 0])
        cylinder($fn=6, d = nut_diameter, h=nut_height);
    }
};

module NutHole_M2() {
//    NutHole(4.7, 2.2);
    NutHole(4.8, 2.3);
}

module NutHole_M3() {
    NutHole(6.2, 2.5);
}
