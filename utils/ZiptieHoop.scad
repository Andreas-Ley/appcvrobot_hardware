

module ZiptieHoop() {
    difference() {
        hull() {
            translate([-3, 0, 0])
            cylinder($fn=20, d1 = 5, d2 = 2.5, h = 4);
            translate([3, 0, 0])
            cylinder($fn=20, d1 = 5, d2 = 2.5, h = 4);
        }
        translate([-2, -5, 0.5])
        cube([4, 10, 1.5]);
    }
    
   echo("BOM: ZipTie");
}

ZiptieHoop();