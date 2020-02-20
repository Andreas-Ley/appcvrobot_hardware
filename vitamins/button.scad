

module Button() {
    
    {
        translate([0 , 0 , 7])
        cylinder(  5.5,   d=3.5, true,$fn=100);
         
        translate([0 , 0 , 0.5])
        cylinder(  1.7,   d=10.1, true,$fn=6);
        

        
        translate([0 , 0 , -8.7])
        cylinder(  15.7,   d=6.8, true,$fn=100);
        
        for (i = [0, 4.8]) {
            translate([-2.4+i, -1/2, -8.7-5.8])
            cube([0.4, 1, 5.8]);

            
        }
    }
    
};

module ButtonHole(clearence = 0.2) {

    translate([0 , 0 , -8.7])
     cylinder(  9.4,   d=6.8, true,$fn=100);
};

Button();
ButtonHole();