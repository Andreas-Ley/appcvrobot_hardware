use <../utils/struct.scad>

function DCDCBoard_config() =
        let (
            pcb_height = 1.57,
            width = 17*2.54,
            height = 33*2.54/4,
            bore_diameter = 3,
            bore_dist_w = 10*2.54/4,
            bore_dist_h = 4*2.54/4
        ) [
            ["pcb_height", pcb_height],
            ["width", width],
            ["height", height],
            ["bore_diameter", bore_diameter],
            ["bore_dist_w", bore_dist_w],
            ["bore_dist_h", bore_dist_h]
        ];


module DCDCBoard_BoreHoles(config) {
    width = get(config, "width");
    height = get(config, "height");
    bore_dist_w = get(config, "bore_dist_w");
    bore_dist_h = get(config, "bore_dist_h");
    
    for (i = [-1, 1])
        translate([
                i*(width/2 - bore_dist_w), 
                -i*(height/2 - bore_dist_h),
                0])
        children();
}


module DCDCBoard(config) {
    width = get(config, "width");
    height = get(config, "height");
    pcb_height = get(config, "pcb_height");
    
    difference() {
        translate([-width/2, -height/2, 0])
        cube([width, height, pcb_height]);
        
        DCDCBoard_BoreHoles(config)
        cylinder($fn=20, d = get(config, "bore_diameter"), h = 10);
    }
    
};

DCDCBoard(DCDCBoard_config());

