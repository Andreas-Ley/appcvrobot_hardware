use <../utils/struct.scad>

function RaspiCamera_config() =
        let (
            pcb_height = 1.57,
            width = 38,
            bore_distance = 28,
            bore_diameter = 2,
            lens_screws_distance = 29,
            screw_head_diameter = 2.5,
            lens_height = 20,
            lens_diameter = 15
        ) [
            ["pcb_height", pcb_height],
            ["width", width],
            ["bore_distance", bore_distance],
            ["bore_diameter", bore_diameter],
            ["lens_screws_distance", lens_screws_distance],
            ["screw_head_diameter", screw_head_diameter],
            ["lens_height", lens_height],
            ["lens_diameter", lens_diameter],
        ];

module RaspiCamera(config) {
    width = get(config, "width");
    pcb_height = get(config, "pcb_height");
    
    difference() {
        translate([-width/2, -width/2, 0])
        cube([width, width, pcb_height]);
        
        for (i = [0, 90, 180, 270]) {
            rotate([0, 0, i])
            translate([get(config, "bore_distance")/2, get(config, "bore_distance")/2, -1])
            cylinder($fn=20, d = get(config, "bore_diameter"), h = 10);
        }
    }
    
    cylinder($fn=20, d = get(config, "lens_diameter"), h = get(config, "lens_height"));
};

RaspiCamera(RaspiCamera_config());
