use <../utils/struct.scad>

function PowerBoard_config() =
        let (
            pcb_height = 1.57,
            width = 83.82,
            height = 30.48,
            bore_diameter = 2.2,
            bore_spread_w = 31*2.54,
            bore_spread_h = 26
        ) [
            ["pcb_height", pcb_height],
            ["width", width],
            ["height", height],
            ["bore_diameter", bore_diameter],
            ["bore_spread_w", bore_spread_w],
            ["bore_spread_h", bore_spread_h]
        ];


module PowerBoard_BoreHoles(config, front = true, back = true) {
    bore_spread_w = get(config, "bore_spread_w");
    bore_spread_h = get(config, "bore_spread_h");
    
    for (i = [-1, 1])
        if (((i == -1) && front) ||
            ((i == 1) && back))
        for (j = [-1, 1])
        translate([
                j*bore_spread_w/2, 
                i*bore_spread_h/2,
                0])
        children();
}

module PowerBoard(config) {
    width = get(config, "width");
    height = get(config, "height");
    bore_spread_w = get(config, "bore_spread_w");
    bore_spread_h = get(config, "bore_spread_h");
    pcb_height = get(config, "pcb_height");
    
    difference() {
        union() {
            translate([-width/2, -height/2, 0])
            cube([width, height, pcb_height]);

            translate([-width/2-20, -6, 5])
            cube([20, 13, pcb_height]);
        }

        
        translate([0, 0, -1])
        PowerBoard_BoreHoles(config)
        cylinder($fn=20, d = get(config, "bore_diameter"), h = 10);
            
        if (false)
            for (r = [0:9])
                for (c = [0:23])
                    translate([(c-11.5)*2.54, (r-4.5)*2.54, -1])
                    cylinder($fn=10, d = 0.5, h = 5);
    }
    
};

PowerBoard(PowerBoard_config());

module AlignPowerBoardToMainBoard(config) {
    pcb_height = get(config, "pcb_height");

    translate([0, -4.5*2.54-8.5*2.54, 11+pcb_height])
    children();
}