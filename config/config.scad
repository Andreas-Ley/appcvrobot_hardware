baseDistance = 175;
wheelWidth = 20;
wheelDiameter = 70;

function sqr(x)=x*x;

bucket_radius = sqrt(sqr(baseDistance/2+wheelWidth)+sqr(wheelDiameter/2));

thickness = 2;

lid_buttons = [[0, "Power"], [1, "Execute"], [2, "Stop"]];

