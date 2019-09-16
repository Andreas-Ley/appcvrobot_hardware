function get(config, key) = config[search([key], config)[0]][1];

function set(config, key, value) = [for (elem = config) if (elem[0] != key) elem, [key, value]];
    
function join(config1, config2) = [for (elem = config1) elem, for (elem = config2) elem];