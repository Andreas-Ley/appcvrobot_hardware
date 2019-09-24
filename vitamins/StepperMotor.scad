include<../../../Downloads/MCAD/stepper.scad>


Nema17_Andy = [
                [NemaModel, 17],
                [NemaLengthShort, 33*mm],
                [NemaLengthMedium, 39.5*mm],
                [NemaLengthLong, 47*mm],
                [NemaSideSize, 42.30*mm], 
                [NemaDistanceBetweenMountingHoles, 31*mm], 
                [NemaMountingHoleDiameter, 2.1*mm], 
                [NemaMountingHoleDepth, 4.5*mm], 
                [NemaMountingHoleLip, -1*mm], 
                [NemaMountingHoleCutoutRadius, 0*mm], 
                [NemaEdgeRoundingRadius, 6*mm], 
                [NemaRoundExtrusionDiameter, 22*mm], 
                [NemaRoundExtrusionHeight, 2*mm], 
                [NemaAxleDiameter, 5*mm], 
                [NemaFrontAxleLength, 22*mm], 
                [NemaBackAxleLength, 15*mm],
                [NemaAxleFlatDepth, 0.5*mm],
                [NemaAxleFlatLengthFront, 15*mm],
                [NemaAxleFlatLengthBack, 14*mm]
         ];

module motorAndy(model=Nema23, size=NemaMedium, dualAxis=false, pos=[0,0,0], orientation = [0,0,0]) {

  length = lookup(size, model);

  echo(str("  Motor: Nema",lookup(NemaModel, model),", length= ",length,"mm, dual axis=",dualAxis));

  stepperBlack    = BlackPaint;
  stepperAluminum = Aluminum;

  side = lookup(NemaSideSize, model);

  cutR = lookup(NemaMountingHoleCutoutRadius, model);
  lip = lookup(NemaMountingHoleLip, model);
  holeDepth = lookup(NemaMountingHoleDepth, model);

  axleLengthFront = lookup(NemaFrontAxleLength, model);
  axleLengthBack = lookup(NemaBackAxleLength, model);
  axleRadius = lookup(NemaAxleDiameter, model) * 0.5;

  extrSize = lookup(NemaRoundExtrusionHeight, model);
  extrRad = lookup(NemaRoundExtrusionDiameter, model) * 0.5;

  holeDist = lookup(NemaDistanceBetweenMountingHoles, model) * 0.5;
  holeRadius = lookup(NemaMountingHoleDiameter, model) * 0.5;

  mid = side / 2;

  roundR = lookup(NemaEdgeRoundingRadius, model);

  axleFlatDepth = lookup(NemaAxleFlatDepth, model);
  axleFlatLengthFront = lookup(NemaAxleFlatLengthFront, model);
  axleFlatLengthBack = lookup(NemaAxleFlatLengthBack, model);

  color(stepperBlack){
    translate(pos) rotate(orientation) {
      translate([-mid, -mid, 0]) 
        difference() {          
          cube(size=[side, side, length + extrSize]);
 
          // Corner cutouts
          if (lip > 0) {
            translate([0,    0,    lip]) cylinder(h=length, r=cutR);
            translate([side, 0,    lip]) cylinder(h=length, r=cutR);
            translate([0,    side, lip]) cylinder(h=length, r=cutR);
            translate([side, side, lip]) cylinder(h=length, r=cutR);

          }

          // Rounded edges
          if (roundR > 0) {
                translate([mid+mid, mid+mid, length/2])
                  rotate([0,0,45])
                    cube(size=[roundR, roundR*2, 4+length + extrSize+2], center=true);
                translate([mid-(mid), mid+(mid), length/2])
                  rotate([0,0,45])
                    cube(size=[roundR*2, roundR, 4+length + extrSize+2], center=true);
                translate([mid+mid, mid-mid, length/2])
                  rotate([0,0,45])
                    cube(size=[roundR*2, roundR, 4+length + extrSize+2], center=true);
                translate([mid-mid, mid-mid, length/2])
                  rotate([0,0,45])
                    cube(size=[roundR, roundR*2, 4+length + extrSize+2], center=true);

          }

          // Bolt holes
          color(stepperAluminum, $fs=holeRadius/8) {
            translate([mid+holeDist,mid+holeDist,-1*mm]) cylinder(h=holeDepth+1*mm, r=holeRadius);
            translate([mid-holeDist,mid+holeDist,-1*mm]) cylinder(h=holeDepth+1*mm, r=holeRadius);
            translate([mid+holeDist,mid-holeDist,-1*mm]) cylinder(h=holeDepth+1*mm, r=holeRadius);
            translate([mid-holeDist,mid-holeDist,-1*mm]) cylinder(h=holeDepth+1*mm, r=holeRadius);

          } 


          // Grinded flat
          color(stepperAluminum) {
            difference() {
              translate([-1*mm, -1*mm, -1]) 
                cube(size=[side+2*mm, side+2*mm, extrSize + 1*mm]);
              translate([side/2, side/2, -1*mm]) 
                cylinder(h=(extrSize+1)*mm, r=extrRad);
            }
          }

        }

      // Axle
      translate([0, 0, extrSize-axleLengthFront]) color(stepperAluminum) 
        difference() {
                     
          cylinder(h=axleLengthFront + 1*mm , r=axleRadius, $fs=axleRadius/10);

          // Flat
          if (axleFlatDepth > 0)
            translate([axleRadius - axleFlatDepth,-5*mm,-extrSize*mm -(axleLengthFront-axleFlatLengthFront)] ) cube(size=[5*mm, 10*mm, axleLengthFront]);
        }

        if (dualAxis) {
          translate([0, 0, length+extrSize]) color(stepperAluminum) 
            difference() {
                     
              cylinder(h=axleLengthBack + 0*mm, r=axleRadius, $fs=axleRadius/10);

              // Flat
              if (axleFlatDepth > 0)
                translate([axleRadius - axleFlatDepth,-5*mm,(axleLengthBack-axleFlatLengthBack)]) cube(size=[5*mm, 10*mm, axleLengthBack]);
          }

        }

    }
  }
}


module Nema17Motor() {
    motorAndy(Nema17_Andy, NemaMedium, dualAxis=false);

    side = lookup(NemaSideSize, Nema17_Andy);
    length = lookup(NemaLengthMedium, Nema17_Andy);

    translate([-16/2, side/2, length+2-10.5])
    cube([16, 6.5, 10.5]);
};



module Nema17Motor_ShaftAttachment() {
    rotate([180, 0, 0])
    translate([0, 0, 22-14.8-2])
    children();  
};

module Nema17Motor_ScrewAttachment() {
    for (i = [0, 90, 180, 270])
        rotate([180, 0, i])
        translate([31/2, 31/2, -2])
        children();  
};




