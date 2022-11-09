use <../utils/struct.scad>
include <../config/config.scad>
use <../vitamins/Raspi.scad>
use <../vitamins/RaspiCamera.scad>
use <../vitamins/BatteryCompartment.scad>
use <../vitamins/MainBoard.scad>
use <../vitamins/PowerBoard.scad>
use <../vitamins/DCDCBoard.scad>
use <../vitamins/screws.scad>
use <../parts/Wheel.scad>
use <../parts/Lid.scad>
use <../parts/BasePlate.scad>
use <../parts/PcbMounts.scad>

include<../vitamins/StepperMotor.scad>


module PcbsAssembled(explode = 2.0) {
    PcbMounts();

/*
VerticalConnectionScrewHoles()
color("grey")
cylinder($fn=40, d = 12, h = 50);
*/

PcbMounts_PlacePi() {
    
    raspiConfig = Raspi_config();
    
    echo("BOM: Pi");
    color("green")    
    Raspi(raspiConfig);
    
    Raspi_BoreHoles(raspiConfig) {
        translate([0, 0, get(raspiConfig, "pcb_height")])
        Screw_M2x6("Screws_RPi");
        
        translate([0, 0, -3.9])
        Nut_M2("Nuts_RPi");        
    }
}
    
    
PcbMounts_PlaceMainBoard() {
    mainboard_config = Mainboard_config();

    echo("BOM: Mainboard");
    color("green")
    Mainboard(mainboard_config);
    
    Mainboard_BoreHoles(mainboard_config) {
        translate([0, 0, get(mainboard_config, "pcb_height")])
        Screw_M2x6("Screws_MainBoard");    
        
        translate([0, 0, -3.9])
        Nut_M2("Nuts_MainBoard");        
    }
}

/*
PcbMounts_PlacePowerBoard() {
    powerboardConfig = PowerBoard_config();

    
    color("green")
    PowerBoard(powerboardConfig);
    PowerBoard_BoreHoles(powerboardConfig, true, false)
    translate([0, 0, get(powerboardConfig, "pcb_height")])
    Screw_M2x6();    
}
*/

PcbMounts_PlaceDCDCBoard() {
    dcdcboard_config = DCDCBoard_config();
    
    echo("BOM: DCDCBoard");
    color("green")
    DCDCBoard(dcdcboard_config);

    DCDCBoard_BoreHoles(dcdcboard_config) {
        translate([0, 0, get(dcdcboard_config, "pcb_height")]) 
        Screw_M2x6("Screws_DCDCBoard");    
        translate([0, 0, -3.9])
        Nut_M2("Nuts_DCDCBoard");
    }
}

PcbMounts_PlacePiCamera() {
    echo("BOM: Pi_Camera");
    color("green")
    RaspiCamera(RaspiCamera_config());
    
    RaspiCamera_PlaceScrews(RaspiCamera_config()) {
        Screw_M2x6("Screws_Camera");
        translate([0, 0, -5.8])
        Nut_M2("Nuts_Camera");
    }    
    
    PcbMountsPlace_CameraMountScrew() {
        Screw_M3x25("Screw_CameraMount");
        translate([0, 0, -24.9])
        Nut_M3("Nut_CameraMount");
    }

}


}


PcbsAssembled();

