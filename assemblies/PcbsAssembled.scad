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


module PcbsAssembled(explode = 0.0) {
    PcbMounts();


PcbMounts_PlacePi() {
    
    raspiConfig = Raspi_config();
    
    color("green")
    Raspi(raspiConfig);
    
    Raspi_BoreHoles(raspiConfig)
    translate([0, 0, get(raspiConfig, "pcb_height")])
    Screw_M2x6();
}
    
    
PcbMounts_PlaceMainBoard() {
    mainboard_config = Mainboard_config();

    color("green")
    Mainboard(mainboard_config);
    
    Mainboard_BoreHoles(mainboard_config)
    translate([0, 0, get(mainboard_config, "pcb_height")])
    Screw_M2x6();    
}


PcbMounts_PlacePowerBoard() {
    powerboardConfig = PowerBoard_config();

    
    color("green")
    PowerBoard(powerboardConfig);
    PowerBoard_BoreHoles(powerboardConfig, true, false)
    translate([0, 0, get(powerboardConfig, "pcb_height")])
    Screw_M2x6();    
}

PcbMounts_PlaceDCDCBoard() {
    dcdcboard_config = DCDCBoard_config();
    color("green")
    DCDCBoard(dcdcboard_config);

    DCDCBoard_BoreHoles(dcdcboard_config)
    translate([0, 0, get(dcdcboard_config, "pcb_height")])
    Screw_M2x6();    
}

PcbMounts_PlacePiCamera() {
    color("green")
    RaspiCamera(RaspiCamera_config());
}

}


PcbsAssembled();
