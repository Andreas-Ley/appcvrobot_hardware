use <../utils/struct.scad>
include <../config/config.scad>
use <../vitamins/Raspi.scad>
use <../vitamins/RaspiCamera.scad>
use <../vitamins/MainBoard.scad>
use <../vitamins/PowerBoard.scad>
use <../vitamins/DCDCBoard.scad>
use <../vitamins/screws.scad>
use <../utils/ZiptieHoop.scad>

use <BasePlate.scad>


pcb_spacing = 5;



module PcbMounts_PlacePi() {
    translate([-20, 22, thickness*2+pcb_spacing])
    children();
}

module PcbMounts_PlacePiCamera() {
    translate([0, 65, 10])
    rotate([-90, 0, 0])
    children();
}

module Cutput_PiCamera() {
    PcbMounts_PlacePiCamera() {
        cylinder($fn=40, d1 = 0, d2=100*tan(160/2), h = 100);
        translate([-20, -28, -4])
        cube([40, 48, 40]);
    }
}


module PcbMounts_PlaceMainBoard() {
    translate([3, -35, thickness*2+pcb_spacing])
    children();
}

module PcbMounts_PlacePowerBoard() {
    PcbMounts_PlaceMainBoard()
    AlignPowerBoardToMainBoard(PowerBoard_config())
    children();
}


module PcbMounts_PlaceDCDCBoard() {
    translate([60, -48, thickness*2+pcb_spacing])
    rotate([0, 0, 90])
    children();
}


module PcbMountingColumn(height = pcb_spacing) {
    difference() {
        cylinder($fn=40, d1 = 15, d2=6, h = height);
        translate([0, 0, height+0.1])
        ScrewBore_M2x6();
        
        translate([0, 0, height-4])
        NutHole_M2();
    }
}


module PcbMounts() {
    topDiameter = bucket_radius*2-50;
    height = 30;
        
    
    module CameraMount() {
        RpiCameraConfig = RaspiCamera_config();
        cam_width = get(RpiCameraConfig, "width");
        rotate([90, 0, 0])
        translate([0, -3.6, 0])
        difference() {
            union() {
                translate([-cam_width/2, -5-3/2, -cam_width/2 + 12])
                cube([cam_width, 3, cam_width-12]);
                
                chunk_size = cam_width / 10;
                for (i = [1:3])
                    translate([-cam_width/2 + i*2 * chunk_size, -1, (cam_width/2 + 4)]) {
                        hull() {
                            translate([0, -4-1.5, -4-chunk_size/2-0.1])
                            cube([chunk_size-0.1, 3, 3]);
                            
                            rotate([0, 90, 0])
                            cylinder($fn=20, d = 6, h = chunk_size-0.1);
                        }
                    }
                for (i = [1:3])
                    translate([-cam_width/2 + (i*2+1) * chunk_size, -1, (cam_width/2 + 4)]) {
                        hull() {
                            translate([0, +1.5, -4-chunk_size/2-0.1])
                            cube([chunk_size-0.1, 3, 3]);
                            
                            rotate([0, 90, 0])
                            cylinder($fn=20, d = 6, h = chunk_size-0.1);
                        }
                    }
                translate([0, 2, 0])
                cube([cam_width, 3, cam_width], center = true);
            }
            translate([-cam_width/2-2, -1, (cam_width/2 + 4)])
            rotate([0, 90, 0])
            cylinder($fn=20, d = 3.2, h = 200);
            
            translate([0, 0, 0])
            rotate([-90, 0, 0])
            cylinder($fn=50, d = 30, h = 10);
            
            translate([0, 0, 0])
            rotate([-90, 0, 0]) {
                for (i = [0, 90, 180, 270]) {
                    rotate([0, 0, i])
                    translate([get(RpiCameraConfig, "bore_distance")/2, get(RpiCameraConfig, "bore_distance")/2, -1])
                    cylinder($fn=20, d = get(RpiCameraConfig, "bore_diameter"), h = 10);
                }
            }
        }
    }
    
    
    difference() {
        union() {
            translate([0, 0, thickness])
            cylinder($fn=200, d = bucket_radius*2, h = thickness);
            
            PcbMounts_PlacePi()
            Raspi_BoreHoles(Raspi_config())
            translate([0, 0, -pcb_spacing])
            PcbMountingColumn(pcb_spacing);

            mainboard_config = Mainboard_config();
            PcbMounts_PlaceMainBoard()
            Mainboard_BoreHoles(mainboard_config)
            translate([0, 0, -pcb_spacing])
            PcbMountingColumn(pcb_spacing);

            dcdcboard_config = DCDCBoard_config();
            PcbMounts_PlaceDCDCBoard()
            DCDCBoard_BoreHoles(dcdcboard_config)
            translate([0, 0, -pcb_spacing])
            PcbMountingColumn(pcb_spacing);
            
            powerboardConfig = PowerBoard_config();
            PcbMounts_PlacePowerBoard()
            PowerBoard_BoreHoles(powerboardConfig, true, false)
            translate([0, 0, -pcb_spacing-11-1.6])
            PcbMountingColumn(pcb_spacing+11+1.6);
            
            
            translate([-60, 60, thickness*2])
            ZiptieHoop();
            
            translate([-72, 40, thickness*2])
            rotate([0, 0, 90])
            ZiptieHoop();

            translate([-72, -10, thickness*2])
            rotate([0, 0, 90])
            ZiptieHoop();

            translate([-55, -42, thickness*2])
            ZiptieHoop();



            translate([-20, -70, thickness*2])
            ZiptieHoop();

            translate([45, 7, thickness*2])
            ZiptieHoop();
        }
        
        
        VerticalConnectionScrewHoles()
        translate([0, 0, thickness*2+1])
        ScrewBore_M3x10();
        
        CableDucts();

        WheelMount(true)
            cylinder($fn=40, d = wheelDiameter+10, h = wheelWidth + 50);
        
        WheelMount(false)
            cylinder($fn=40, d = wheelDiameter+10, h = wheelWidth + 50);
        
        Cutput_PiCamera();
    }
    PcbMounts_PlacePiCamera()
    CameraMount();

}

PcbMounts();