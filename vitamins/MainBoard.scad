use <../utils/struct.scad>

function Mainboard_config() =
        let (
            pcb_height = 1.57,
            width = 82.55,
            height = 63.5,
            bore_diameter = 2.2,
            bore_spread_w = 77.47, //26*2.54,
            bore_spread_h = 58.42 //18*2.54
        ) [
            ["pcb_height", pcb_height],
            ["width", width],
            ["height", height],
            ["bore_diameter", bore_diameter],
            ["bore_spread_w", bore_spread_w],
            ["bore_spread_h", bore_spread_h]
        ];

module Mainboard_BoreHoles(config) {
    bore_spread_w = get(config, "bore_spread_w");
    bore_spread_h = get(config, "bore_spread_h");
    
    for (i = [-1, 1])
        for (j = [-1, 1])
        translate([
                i*bore_spread_w/2, 
                j*bore_spread_h/2,
                0])
        children();
}

module Mainboard(config) {
    width = get(config, "width");
    height = get(config, "height");
    pcb_height = get(config, "pcb_height");
    
    difference() {
        translate([-width/2, -height/2, 0])
        cube([width, height, pcb_height]);
        
        Mainboard_BoreHoles(config)
        translate([0, 0, -1])
        cylinder($fn=20, d = get(config, "bore_diameter"), h = 10);
            
        if (false)
            for (r = [0:17])
                for (c = [0:23])
                    translate([(c-11.5)*2.54, (r-8.5)*2.54, -1])
                    cylinder($fn=10, d = 0.5, h = 5);

    }
    
};

Mainboard(Mainboard_config());

