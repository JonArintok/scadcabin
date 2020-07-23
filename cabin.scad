// all lengths are measured in inches

// ACTUAL LUMBER DIMENSIONS
b1x2  = [0.75, 1.5];
b1x3  = [0.75, 2.5];
b1x4  = [0.75, 3.5];
b1x5  = [0.75, 4.5];
b1x6  = [0.75, 5.5];
b1x8  = [0.75, 7.25];
b1x10 = [0.75, 9.25];
b1x12 = [0.75, 11.25];
b2x2  = [1.5, 1.5];
b2x3  = [1.5, 2.5];
b2x4  = [1.5, 3.5];
b2x6  = [1.5, 5.5];
b2x8  = [1.5, 7.25];
b2x10 = [1.5, 9.25];
b2x12 = [1.5, 11.25];
b4x4  = [3.5, 3.5];
b4x6  = [3.5, 5.5];
b6x6  = [5.5, 5.5];

// TOOLS
function ft(feet = 0, inches = 0) = 12*feet + inches;
module cubenspeak(name = "board", cuboid = [0,0,0], transtep = [0,0,0]) {
  translate(transtep) {
    cube(cuboid);
  }
  echo(name, cuboid, transtep);
}
module ALERT(message = "!!  !!  !!  !!") {
  echo(message);
}

floorx = ft(16); // from outside edge to outside edge
floory = ft(10); // from outside edge to outside edge

// P I E R S
module piers(color) {
  echo();
  echo("P I E R S");
  pierw  = 12;
  pierh = ft(3);
  origin = [0, 0, -pierh];
  echo(origin = origin);
  pier = [pierw, pierw, pierh];
  pierspacingx = (floorx-pierw)/3;
  pierspacingy = (floory-pierw)/2;
  translate(origin) { color(color) {
    cubenspeak("pier", pier);
    cubenspeak("pier", pier, [pierspacingx,   0,              0]);
    cubenspeak("pier", pier, [pierspacingx*2, 0,              0]);
    cubenspeak("pier", pier, [pierspacingx*3, 0,              0]);
    cubenspeak("pier", pier, [0,              pierspacingy,   0]);
    cubenspeak("pier", pier, [pierspacingx*3, pierspacingy,   0]);
    cubenspeak("pier", pier, [0,              pierspacingy*2, 0]);
    cubenspeak("pier", pier, [pierspacingx,   pierspacingy*2, 0]);
    cubenspeak("pier", pier, [pierspacingx*2, pierspacingy*2, 0]);
    cubenspeak("pier", pier, [pierspacingx*3, pierspacingy*2, 0]);
  }}
}

// F L O O R   B E A M S
floorbeamrise = b6x6[1];
module floorbeams(color) {
  echo();
  echo("FLOOR BEAMS");
  origin = [0,0,0];
  echo(origin = origin);
  floorbeamlboard = b6x6;
  floorbeamsboard = b6x6;
  floorbeamlboardw = floorbeamlboard[0];
  floorbeamlboardh = floorbeamlboard[1];
  floorbeamsboardw = floorbeamsboard[0];
  floorbeamsboardh = floorbeamsboard[1];
  floorbeaml = [floorx, floorbeamlboardw, floorbeamlboardh];
  floorbeams = [floorbeamsboardw, floory-floorbeamlboardw*2, floorbeamsboardh];
  cubenspeak("floorbeam", floorbeaml);
  cubenspeak("floorbeam", floorbeaml, [0,                       floory-floorbeamlboardw, 0]);
  cubenspeak("floorbeam", floorbeams, [0,                       floorbeamlboardw,        0]);
  cubenspeak("floorbeam", floorbeams, [floorx-floorbeamsboardw, floorbeamlboardw,        0]);
}

// D I R T   C E I L I N G
dirtceilingelev = floorbeamrise;
dirtceilingrise = 1/4;
floorpanelw = ft(4);
module dirtceiling(color) {
  echo();
  echo("DIRT CEILING");
  origin = [0, 0, dirtceilingelev];
  echo(origin = origin);
  panel = [floorpanelw, floory, dirtceilingrise];
  translate(origin) { color(color) {
    cubenspeak("OSB", panel);
    cubenspeak("OSB", panel, [floorpanelw,   0, 0]);
    cubenspeak("OSB", panel, [floorpanelw*2, 0, 0]);
    cubenspeak("OSB", panel, [floorpanelw*3, 0, 0]);
  }}
}

// F L O O R   J O I S T S
floorjoistelev = dirtceilingelev + dirtceilingrise;
floorjoistrise = b4x6[1];
module floorjoists(color) {
  echo();
  echo("FLOOR JOISTS");
  origin = [0, 0, floorjoistelev];
  echo(origin = origin);
  beamboard  = b4x6;
  joistboard = b2x6;
  capboard   = b4x6;
  beamw  = beamboard[0];
  beamh  = beamboard[1];
  joistw = joistboard[0];
  joisth = joistboard[1];
  capw   = capboard[0];
  caph   = capboard[1];
  beam  = [beamw, floory, beamh];
  joist = [joistw, floory-capw*2, joisth];
  cap   = [floorx-beamw*2, beamw, beamh];
  defaultspacing = 16;
  translate(origin) { color(color) {
    cubenspeak("beam",  beam);
    cubenspeak("beam",  beam,  [floorx-beamw,            0,    0]);
    cubenspeak("joist", joist, [defaultspacing,          capw, 0]);
    cubenspeak("joist", joist, [defaultspacing*2,        capw, 0]);
    cubenspeak("joist", joist, [defaultspacing*3-joistw, capw, 0]);
    cubenspeak("joist", joist, [defaultspacing*3,        capw, 0]);
    cubenspeak("joist", joist, [defaultspacing*4,        capw, 0]);
    cubenspeak("joist", joist, [defaultspacing*5,        capw, 0]);
    cubenspeak("joist", joist, [defaultspacing*6-joistw, capw, 0]);
    cubenspeak("joist", joist, [defaultspacing*6,        capw, 0]);
    cubenspeak("joist", joist, [defaultspacing*7,        capw, 0]);
    cubenspeak("joist", joist, [defaultspacing*8,        capw, 0]);
    cubenspeak("joist", joist, [defaultspacing*9-joistw, capw, 0]);
    cubenspeak("joist", joist, [defaultspacing*9,        capw, 0]);
    cubenspeak("joist", joist, [defaultspacing*10,       capw, 0]);
    cubenspeak("joist", joist, [defaultspacing*11,       capw, 0]);
    cubenspeak("cap", cap,  [beamw, 0,           0]);
    cubenspeak("cap", cap,  [beamw, floory-capw, 0]);
  }}
}

// S U B F L O O R
subfloorelev = floorjoistelev + floorjoistrise;
subfloorrise = 3/4;
module subfloor(color) {
  echo();
  echo("SUBFLOOR");
  origin = [0, 0, subfloorelev];
  echo(origin = origin);
  panel = [floorpanelw, floory, subfloorrise];
  translate(origin) { color(color) {
    cubenspeak("OSB", panel);
    cubenspeak("OSB", panel, [floorpanelw,   0, 0]);
    cubenspeak("OSB", panel, [floorpanelw*2, 0, 0]);
    cubenspeak("OSB", panel, [floorpanelw*3, 0, 0]);
  }}
}

wallelev = subfloorelev + subfloorrise;
tallstudl  = ft(12);
studboard = b2x4;
studw = studboard[0];
studh = studboard[1];
doorroughopenw   = 38.25;
doorroughopenh   = 82;
windowroughopenw = 24;
windowroughopenh = 39;
headerboard = b4x6;
headerboardw = headerboard[0];
headerboardh = headerboard[1];

// N O R T H   W A L L
module northwall(color) {
  echo();
  echo("NORTH WALL");
  origin = [0, 0, wallelev+studw];
  echo(origin = origin);
  soleplate     = [floorx, studh, studw];
  topplate      = [floorx, studh, studw];
  cornerstudboard = b4x4;
  cornerstud    = [cornerstudboard[0], cornerstudboard[1], tallstudl];
  cornerstudw   = cornerstudboard[0];
  tallstud      = [studw, studh, tallstudl];
  shortstudl    = doorroughopenh+headerboardh;
  shortstud     = [studw, studh, shortstudl];
  trimmer       = [studw, studh, doorroughopenh];
  thicktrimmer  = [studh, studh, doorroughopenh];
  thicktrimmerw = thicktrimmer[0];
  trimmerw      = trimmer[0];
  cripple       = [studw, studh, tallstudl-shortstudl];
  defaultspacing = 16;
  doorhingebeamx = defaultspacing*11 - thicktrimmerw;
  headerx        = defaultspacing*8 + studw;
  header         = [defaultspacing*3 - studw, headerboardw, headerboardh];
  translate(origin) { color(color) {
    cubenspeak("soleplate",    soleplate,    [0,                       0, -studw]);
    cubenspeak("cornerstud",   cornerstud);
    cubenspeak("shortstud",    shortstud,    [defaultspacing+studw,    0, 0]);
    cubenspeak("tallstud",     tallstud,     [defaultspacing,          0, 0]);
    cubenspeak("shortstud",    shortstud,    [defaultspacing*2-studw,  0, 0]);
    cubenspeak("tallstud",     tallstud,     [defaultspacing*2,        0, 0]);
    cubenspeak("shortstud",    shortstud,    [defaultspacing*3-studw,  0, 0]);
    cubenspeak("tallstud",     tallstud,     [defaultspacing*3,        0, 0]);
    cubenspeak("shortstud",    shortstud,    [defaultspacing*4-studw,  0, 0]);
    cubenspeak("tallstud",     tallstud,     [defaultspacing*4,        0, 0]);
    cubenspeak("shortstud",    shortstud,    [defaultspacing*5-studw,  0, 0]);
    cubenspeak("tallstud",     tallstud,     [defaultspacing*5,        0, 0]);
    cubenspeak("shortstud",    shortstud,    [defaultspacing*6-studw,  0, 0]);
    cubenspeak("tallstud",     tallstud,     [defaultspacing*6,        0, 0]);
    cubenspeak("shortstud",    shortstud,    [defaultspacing*6+studw,  0, 0]);
    cubenspeak("tallstud",     tallstud,     [defaultspacing*7,        0, 0]);
    cubenspeak("shortstud",    shortstud,    [defaultspacing*7+studw,  0, 0]);
    cubenspeak("tallstud",     tallstud,     [defaultspacing*8,        0, 0]);
    cubenspeak("trimmer",      trimmer,      [defaultspacing*8+studw,  0, 0]);
    cubenspeak("trimmer",      trimmer,      [doorhingebeamx-doorroughopenw-trimmerw, 0, 0]);
    cubenspeak("thicktrimmer", thicktrimmer, [doorhingebeamx,          0, 0]);
    cubenspeak("header",    header,          [headerx,                 0, doorroughopenh]);
    cubenspeak("cripple",   cripple,         [defaultspacing*9,        0, shortstudl]);
    cubenspeak("cripple",   cripple,         [defaultspacing*10,       0, shortstudl]);
    cubenspeak("tallstud",  tallstud,        [defaultspacing*11,       0, 0]);
    cubenspeak("cornerstud", cornerstud,     [floorx-cornerstudw,      0, 0]);
    cubenspeak("topplate",  topplate,        [0,                       0, tallstudl]);
  }}
}

// S O U T H   W A L L
module southwall(color) {
  echo();
  echo("SOUTH WALL");
  origin = [0, floory-studh, wallelev+studw];
  echo(origin = origin);
  soleplate       = [floorx, studh, studw];
  topplate        = [floorx, studh, studw];
  cornerstudboard = b4x4;
  cornerstud      = [cornerstudboard[0], cornerstudboard[1], tallstudl];
  cornerstudw     = cornerstudboard[0];
  tallstud        = [studw, studh, tallstudl];
  windowdrop      = 8;
  shortstudl      = doorroughopenh + headerboardh;
  shortstud       = [studw, studh, shortstudl];
  dropstud        = [studw, studh, windowdrop];
  trimmer         = [studw, studh, doorroughopenh-windowdrop];
  trimmerw        = trimmer[0];
  highcripple     = [studw, studh, tallstudl-shortstudl+windowdrop];
  defaultspacing  = 16;
  headerz         = shortstudl - headerboardh - windowdrop;
  lheaderx        = defaultspacing + studw;
  header          = [defaultspacing*2 - studw, headerboardw, headerboardh];
  sill            = [windowroughopenw, studh, studw];
  sillz           = headerz - windowroughopenh - studw - windowdrop;
  lsillx          = defaultspacing*3 - studw - windowroughopenw;
  rsillx          = defaultspacing*9+studw*2;
  lowcripple      = [studw, studh, sillz];
  lwindowastudx   = defaultspacing*3 - studw*2 - windowroughopenw;
  rwindowastudx   = defaultspacing*9 + studw*2 + windowroughopenw;
  c               = -studw/2; // for centering windows
  translate(origin) { color(color) {
    cubenspeak("soleplate",   soleplate,   [0,                          0, -studw]);
    cubenspeak("cornerstud",  cornerstud);
    cubenspeak("tallstud",    tallstud,    [c+defaultspacing,           0, 0]);
    cubenspeak("trimmer",     trimmer,     [c+defaultspacing  +studw,   0, 0]);
    cubenspeak("trimmer",     trimmer,     [c+lwindowastudx,            0, 0]);
    cubenspeak("lowcripple",  lowcripple,  [c+lwindowastudx+studw,      0, 0]);
    cubenspeak("lowcripple",  lowcripple,  [c+defaultspacing*2,         0, 0]);
    cubenspeak("lowcripple",  lowcripple,  [c+defaultspacing*3-studw*2, 0, 0]);
    cubenspeak("trimmer",     trimmer,     [c+defaultspacing*3-studw,   0, 0]);
    cubenspeak("sill",        sill,        [c+lsillx,                   0, sillz]);
    cubenspeak("header",      header,      [c+defaultspacing  +studw,   0, headerz]);
    cubenspeak("dropstud",    dropstud,    [c+defaultspacing  +studw,   0, shortstudl-windowdrop]);
    cubenspeak("dropstud",    dropstud,    [c+defaultspacing*2-studw,   0, shortstudl-windowdrop]);
    cubenspeak("highcripple", highcripple, [c+defaultspacing*2,         0, shortstudl-windowdrop]);
    cubenspeak("dropstud",    dropstud,    [c+defaultspacing*3-studw,   0, shortstudl-windowdrop]);
    cubenspeak("tallstud",    tallstud,    [c+defaultspacing*3,         0, 0]);
    cubenspeak("shortstud",   shortstud,   [c+defaultspacing*4-studw,   0, 0]);
    cubenspeak("tallstud",    tallstud,    [c+defaultspacing*4,         0, 0]);
    cubenspeak("shortstud",   shortstud,   [c+defaultspacing*5-studw,   0, 0]);
    cubenspeak("tallstud",    tallstud,    [c+defaultspacing*5,         0, 0]);
    cubenspeak("shortstud",   shortstud,   [c+defaultspacing*6-studw,   0, 0]);
    cubenspeak("tallstud",    tallstud,    [c+defaultspacing*6,         0, 0]);
    cubenspeak("shortstud",   shortstud,   [c+defaultspacing*6+studw,   0, 0]);
    cubenspeak("tallstud",    tallstud,    [c+defaultspacing*7,         0, 0]);
    cubenspeak("shortstud",   shortstud,   [c+defaultspacing*7+studw,   0, 0]);
    cubenspeak("tallstud",    tallstud,    [c+defaultspacing*8,         0, 0]);
    cubenspeak("shortstud",   shortstud,   [c+defaultspacing*8+studw,   0, 0]);
    cubenspeak("tallstud",    tallstud,    [c+defaultspacing*9,         0, 0]);
    cubenspeak("trimmer",     trimmer,     [c+defaultspacing*9+studw,   0, 0]);
    cubenspeak("lowcripple",  lowcripple,  [c+rsillx,                   0, 0]);
    cubenspeak("lowcripple",  lowcripple,  [c+defaultspacing*10,        0, 0]);
    cubenspeak("lowcripple",  lowcripple,  [c+rwindowastudx-studw,      0, 0]);
    cubenspeak("trimmer",     trimmer,     [c+rwindowastudx,            0, 0]);
    cubenspeak("trimmer",     trimmer,     [c+defaultspacing*11-studw,  0, 0]);
    cubenspeak("sill",        sill,        [c+rsillx,                   0, sillz]);
    cubenspeak("header",      header,      [c+defaultspacing*9+studw,   0, headerz]);
    cubenspeak("dropstud",    dropstud,    [c+defaultspacing*9+studw,   0, shortstudl-windowdrop]);
    cubenspeak("dropstud",    dropstud,    [c+defaultspacing*10+studw,  0, shortstudl-windowdrop]);
    cubenspeak("highcripple", highcripple, [c+defaultspacing*10,        0, shortstudl-windowdrop]);
    cubenspeak("dropstud",    dropstud,    [c+defaultspacing*11-studw,  0, shortstudl-windowdrop]);
    cubenspeak("tallstud",    tallstud,    [c+defaultspacing*11,        0, 0]);
    cubenspeak("cornerstud",  cornerstud,  [floorx-cornerstudw,         0, 0]);
    cubenspeak("topplate",    topplate,    [0,                          0, tallstudl]);
  }}
}

// E A S T   W A L L
module eastwall(color) {
  echo();
  echo("EAST WALL");
  origin = [0, studh, wallelev+studw];
  echo(origin = origin);
  soleplate = [studh, floory-studh*2, studw];
  translate(origin) { color(color) {
    cubenspeak("soleplate",   soleplate,   [0, 0, -studw]);
  }}
}

/*colors = [
  "#f94144",
  "#f3722c",
  "#f8961e",
  "#f9c74f",
  "#90be6d",
  "#43aa8b",
  "#577590"
];*/
colors = [
  "#f29e4c",
  "#f1c453",
  "#efea5a",
  "#b9e769",
  "#83e377",
  "#16db93",
  "#0db39e",
  "#048ba8",
  "#2c699a",
  "#54478c"
];

// D R A W
piers      (colors[0]);
floorbeams (colors[1]);
dirtceiling(colors[2]);
floorjoists(colors[3]);
subfloor   (colors[4]);
northwall  (colors[5]);
southwall  (colors[6]);
eastwall   (colors[7]);
