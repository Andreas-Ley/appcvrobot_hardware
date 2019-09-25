use <../utils/struct.scad>

function Raspi_config() =
        let (
            pcb_height = 1.57,
            width = 85,
            height = 56,
            bore_diameter = 2.75,
            bore_spread_w = 58,
            bore_spread_h = 49
        ) [
            ["pcb_height", pcb_height],
            ["width", width],
            ["height", height],
            ["bore_diameter", bore_diameter],
            ["bore_spread_w", bore_spread_w],
            ["bore_spread_h", bore_spread_h]
        ];

module Raspi_BoreHoles(config) {
    width = get(config, "width");
    height = get(config, "height");

    bore_locations = [
        [
        -width/2 + 3.5, 
        -height/2 + 3.5, 
        0],[
        -width/2 + 3.5 + get(config, "bore_spread_w"), 
        -height/2 + 3.5,
        0],[
        -width/2 + 3.5, 
        -height/2 + 3.5 + get(config, "bore_spread_h"), 
        0],[
        -width/2 + 3.5 + get(config, "bore_spread_w"), 
        -height/2 + 3.5 + get(config, "bore_spread_h"), 
        0]
    ];

    for (l = bore_locations)
        translate(l)
        children();
}

module Raspi(config) {
    width = get(config, "width");
    height = get(config, "height");
    pcb_height = get(config, "pcb_height");
    
    difference() {
        translate([-width/2, -height/2, 0])
        cube([width, height, pcb_height]);
        
        translate([0, 0, -1])
        Raspi_BoreHoles(config)
        cylinder($fn=20, d = get(config, "bore_diameter"), h = 10);
    }
    
};

Raspi(Raspi_config());

