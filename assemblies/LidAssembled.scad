use <../utils/struct.scad>
include <../config/config.scad>
use <../vitamins/Raspi.scad>
use <../vitamins/RaspiCamera.scad>
use <../vitamins/BatteryCompartment.scad>
use <../vitamins/MainBoard.scad>
use <../vitamins/PowerBoard.scad>
use <../vitamins/DCDCBoard.scad>
use <../vitamins/screws.scad>
use <../vitamins/switch.scad>
use <../vitamins/button.scad>
use <../vitamins/LCDScreen.scad>
use <../vitamins/AdOn.scad>
use <../vitamins/PiFan.scad>
use <../parts/Wheel.scad>
use <../parts/Lid.scad>
use <../parts/BasePlate.scad>
use <../parts/PcbMounts.scad>
use <PcbsAssembled.scad>
include<../vitamins/StepperMotor.scad>


module LidAssembled(explode = 0.0) {

    Lid();

    for (b = lid_buttons) {
        echo(str("BOM: Button_", b[1]));
        Lid_PlaceButton(b[0])
            translate([0, 0, max(0, explode-0.8) * 500])
                Button();
    }

    Lid_PlaceLCDScreen() {
        echo("BOM: LCD_Display");
        translate([0, 0, max(0, explode-0.8) * -300])
        LCDScreen();
        
        LCDScreenBoreHoles() {
            translate([0, 0, 5])
            Screw_M3x10("Screws_LCD");
            translate([0, 0, -4])
            Nut_M3("Nuts_LCD");
        }
    }

    Lid_PlaceAdOn() {
        translate([0, 0, max(0, explode-0.8) * -300])
        AdOn();
        
        AdOnBoreHoles() {
            translate([0, 0, 7.9])
            Screw_M3x10("Screws_AddOn");
            translate([0, 0, -2])
            Nut_M3("Nuts_AddOn");
        }
    }


    echo("BOM: Pi_Fan (w. screws and nuts)");
    Lid_PlaceFan()
    translate([0, 0, max(0, explode-0.8) * -300])
    PiFan();


}

LidAssembled();