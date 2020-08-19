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
  //echo(name, cuboid, transtep);
  translate(transtep) {
    cube(cuboid);
  }
}
module polyspeak(name, points, index, transtep = [0,0,0]) {
  //echo(points);
  //echo(index);
  //echo(transtep);
  translate(transtep) {
    polyhedron(points, index, 10);
  }
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
  floorbeamsboard = b4x6;
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

joistboard = b2x8;
joistw     = joistboard[0];
joisth     = joistboard[1];
studboard  = b2x4;
studw      = studboard[0];
studh      = studboard[1];
studwalk   = 16;

// F L O O R   J O I S T S
floorjoistelev = dirtceilingelev + dirtceilingrise;
floorjoistrise = b2x8[1];
module floorjoists(color) {
  echo();
  echo("FLOOR JOISTS");
  origin = [0, 0, floorjoistelev];
  echo(origin = origin);
  beamboard  = b2x8;
  capboard   = b2x8;
  beamw      = beamboard[0];
  beamh      = beamboard[1];
  capw       = capboard[0];
  caph       = capboard[1];
  joist      = [joistw, floory-capw*4, joisth];
  beamin     = [beamw, floory-beamw*2, beamh];
  beamout    = [beamw, floory, beamh];
  capin      = [floorx-beamw*4, capw, caph];
  capout     = [floorx-beamw*2, capw, caph];
  studwalk   = 16;
  translate(origin) { color(color) {
    cubenspeak("beam",  beamout);
    cubenspeak("beam",  beamin,  [beamw,             capw,          0]);
    cubenspeak("joist", joist,   [studwalk,          capw*2,        0]);
    cubenspeak("joist", joist,   [studwalk*2,        capw*2,        0]);
    cubenspeak("joist", joist,   [studwalk*3-joistw, capw*2,        0]);
    cubenspeak("joist", joist,   [studwalk*3,        capw*2,        0]);
    cubenspeak("joist", joist,   [studwalk*4,        capw*2,        0]);
    cubenspeak("joist", joist,   [studwalk*5,        capw*2,        0]);
    cubenspeak("joist", joist,   [studwalk*6-joistw, capw*2,        0]);
    cubenspeak("joist", joist,   [studwalk*6,        capw*2,        0]);
    cubenspeak("joist", joist,   [studwalk*7,        capw*2,        0]);
    cubenspeak("joist", joist,   [studwalk*8,        capw*2,        0]);
    cubenspeak("joist", joist,   [studwalk*9-joistw, capw*2,        0]);
    cubenspeak("joist", joist,   [studwalk*9,        capw*2,        0]);
    cubenspeak("joist", joist,   [studwalk*10,       capw*2,        0]);
    cubenspeak("joist", joist,   [studwalk*11,       capw*2,        0]);
    cubenspeak("beam",  beamin,  [floorx-beamw*2,    capw,          0]);
    cubenspeak("beam",  beamout, [floorx-beamw,      0,             0]);
    cubenspeak("cap", capout,    [beamw,             0,             0]);
    cubenspeak("cap", capin,     [beamw*2,           capw,          0]);
    cubenspeak("cap", capin,     [beamw*2,           floory-capw*2, 0]);
    cubenspeak("cap", capout,    [beamw,             floory-capw,   0]);
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

wallelev          = subfloorelev + subfloorrise;
tallstudl         = ft(12);
doorroughopenw    = 38.25;
doorroughopenh    = 82;
lwindowroughopenw = 24;
lwindowroughopenh = 36;
uwindowroughopenw = 32;
uwindowroughopenh = 16;
headerboard       = b4x6;
headerboardw      = headerboard[0];
headerboardh      = headerboard[1];
c                 = -studw/2; // for centering north and south walls
windowdrop        = 8;
shortstudl        = doorroughopenh + headerboardh;
headerz           = shortstudl - headerboardh - windowdrop;
sillz             = headerz - lwindowroughopenh - studw - windowdrop;
lsillx            = studwalk*3 - studw - lwindowroughopenw; // on south wall
silly             = studwalk*4+studw*2;
s                 = floory-silly-lwindowroughopenw-lsillx; // shift
studelev          = wallelev + studw;
intsheatht        = 0.5;
upperfloorportdim = [studwalk*3-joistw*2-c-studw, studwalk*2+studh+s-studw];


// N O R T H   W A L L
module northwall(color) {
  echo();
  echo("NORTH WALL");
  origin = [0, 0, studelev];
  echo(origin = origin);
  soleplate       = [floorx, studh, studw];
  topplate0       = [floorx, studh, studw];
  topplate1       = [floorx-studh*2, studh, studw];
  cornerstudboard = b4x4;
  cornerstud      = [cornerstudboard[0], cornerstudboard[1], tallstudl];
  cornerstudw     = cornerstudboard[0];
  tallstud        = [studw, studh, tallstudl];
  shortstudl      = doorroughopenh+headerboardh;
  shortstud       = [studw, studh, shortstudl];
  trimmer         = [studw, studh, doorroughopenh];
  thicktrimmer    = [studh, studh, doorroughopenh];
  thicktrimmerw   = thicktrimmer[0];
  trimmerw        = trimmer[0];
  cripple         = [studw, studh, tallstudl-shortstudl];
  doorhingebeamx  = studwalk*11 - thicktrimmerw;
  astudx          = doorhingebeamx - doorroughopenw - trimmerw;
  headerx         = studwalk*8 + studw;
  header          = [studwalk*3 - studw, headerboardw, headerboardh];
  translate(origin) { color(color) {
    cubenspeak("soleplate",    soleplate,    [0,                    0, -studw]);
    cubenspeak("cornerstud",   cornerstud);
    cubenspeak("shortstud",    shortstud,    [cornerstudw,          0, 0]);
    cubenspeak("tallstud",     tallstud,     [c+studwalk,           0, 0]);
    cubenspeak("shortstud",    shortstud,    [c+studwalk+studw,     0, 0]);
    cubenspeak("tallstud",     tallstud,     [c+studwalk*2,         0, 0]);
    cubenspeak("shortstud",    shortstud,    [c+studwalk*2+studw,   0, 0]);
    cubenspeak("shortstud",    shortstud,    [c+studwalk*3-studw,   0, 0]);
    cubenspeak("tallstud",     tallstud,     [c+studwalk*3,         0, 0]);
    cubenspeak("shortstud",    shortstud,    [c+studwalk*3+studw,   0, 0]);
    cubenspeak("shortstud",    shortstud,    [c+studwalk*4-studw,   0, 0]);
    cubenspeak("tallstud",     tallstud,     [c+studwalk*4,         0, 0]);
    cubenspeak("shortstud",    shortstud,    [c+studwalk*5-studw,   0, 0]);
    cubenspeak("tallstud",     tallstud,     [c+studwalk*5,         0, 0]);
    cubenspeak("shortstud",    shortstud,    [c+studwalk*6-studw,   0, 0]);
    cubenspeak("tallstud",     tallstud,     [c+studwalk*6,         0, 0]);
    cubenspeak("shortstud",    shortstud,    [c+studwalk*6+studw,   0, 0]);
    cubenspeak("tallstud",     tallstud,     [c+studwalk*7,         0, 0]);
    cubenspeak("shortstud",    shortstud,    [c+studwalk*7+studw,   0, 0]);
    cubenspeak("tallstud",     tallstud,     [c+studwalk*8,         0, 0]);
    cubenspeak("trimmer",      trimmer,      [c+studwalk*8+studw,   0, 0]);
    cubenspeak("trimmer",      trimmer,      [c+astudx,             0, 0]);
    cubenspeak("thicktrimmer", thicktrimmer, [c+doorhingebeamx,     0, 0]);
    cubenspeak("header",       header,       [c+headerx,            0, doorroughopenh]);
    cubenspeak("cripple",      cripple,      [c+studwalk*9,         0, shortstudl]);
    cubenspeak("cripple",      cripple,      [c+studwalk*10,        0, shortstudl]);
    cubenspeak("tallstud",     tallstud,     [c+studwalk*11,        0, 0]);
    cubenspeak("cornerstud",   cornerstud,   [floorx-cornerstudw,   0, 0]);
    cubenspeak("topplate0",    topplate0,    [0,                    0, tallstudl]);
    cubenspeak("topplate0",    topplate1,    [studh,                0, tallstudl+studw]);
  }}
}

// S O U T H   W A L L
module southwall(color) {
  echo();
  echo("SOUTH WALL");
  origin = [0, floory-studh, studelev];
  echo(origin = origin);
  soleplate       = [floorx, studh, studw];
  topplate0       = [floorx, studh, studw];
  topplate1       = [floorx-studh*2, studh, studw];
  cornerstudboard = b4x4;
  cornerstud      = [cornerstudboard[0], cornerstudboard[1], tallstudl];
  cornerstudw     = cornerstudboard[0];
  tallstud        = [studw, studh, tallstudl];
  shortstud       = [studw, studh, shortstudl];
  dropstud        = [studw, studh, windowdrop];
  trimmer         = [studw, studh, doorroughopenh-windowdrop];
  highcripple     = [studw, studh, tallstudl-shortstudl+windowdrop];
  lheaderx        = studwalk + studw;
  header          = [studwalk*2 - studw, headerboardw, headerboardh];
  sill            = [lwindowroughopenw, studh, studw];
  rsillx          = studwalk*9+studw*2;
  lowcripple      = [studw, studh, sillz];
  lwindowastudx   = studwalk*3 - studw*2 - lwindowroughopenw;
  rwindowastudx   = studwalk*9 + studw*2 + lwindowroughopenw;
  translate(origin) { color(color) {
    cubenspeak("soleplate",   soleplate,   [0,                        0, -studw]);
    cubenspeak("cornerstud",  cornerstud);
    cubenspeak("shortstud",   shortstud,   [cornerstudw,              0, 0]);
    cubenspeak("tallstud",    tallstud,    [c+studwalk,               0, 0]);
    cubenspeak("trimmer",     trimmer,     [c+studwalk + studw,       0, 0]);
    cubenspeak("trimmer",     trimmer,     [c+lwindowastudx,          0, 0]);
    cubenspeak("lowcripple",  lowcripple,  [c+lwindowastudx+studw,    0, 0]);
    cubenspeak("lowcripple",  lowcripple,  [c+studwalk*2,             0, 0]);
    cubenspeak("lowcripple",  lowcripple,  [c+studwalk*3-studw*2,     0, 0]);
    cubenspeak("trimmer",     trimmer,     [c+studwalk*3-studw,       0, 0]);
    cubenspeak("sill",        sill,        [c+lsillx,                 0, sillz]);
    cubenspeak("header",      header,      [c+studwalk + studw,       0, headerz]);
    cubenspeak("dropstud",    dropstud,    [c+studwalk + studw,       0, shortstudl-windowdrop]);
    cubenspeak("highcripple", highcripple, [c+studwalk*2,             0, shortstudl-windowdrop]);
    cubenspeak("dropstud",    dropstud,    [c+studwalk*2+studw,       0, shortstudl-windowdrop]);
    cubenspeak("dropstud",    dropstud,    [c+studwalk*3-studw,       0, shortstudl-windowdrop]);
    cubenspeak("tallstud",    tallstud,    [c+studwalk*3,             0, 0]);
    cubenspeak("shortstud",   shortstud,   [c+studwalk*3+studw,       0, 0]);
    cubenspeak("shortstud",   shortstud,   [c+studwalk*4-studw,       0, 0]);
    cubenspeak("tallstud",    tallstud,    [c+studwalk*4,             0, 0]);
    cubenspeak("shortstud",   shortstud,   [c+studwalk*5-studw,       0, 0]);
    cubenspeak("tallstud",    tallstud,    [c+studwalk*5,             0, 0]);
    cubenspeak("shortstud",   shortstud,   [c+studwalk*6-studw,       0, 0]);
    cubenspeak("tallstud",    tallstud,    [c+studwalk*6,             0, 0]);
    cubenspeak("shortstud",   shortstud,   [c+studwalk*6+studw,       0, 0]);
    cubenspeak("tallstud",    tallstud,    [c+studwalk*7,             0, 0]);
    cubenspeak("shortstud",   shortstud,   [c+studwalk*7+studw,       0, 0]);
    cubenspeak("tallstud",    tallstud,    [c+studwalk*8,             0, 0]);
    cubenspeak("shortstud",   shortstud,   [c+studwalk*8+studw,       0, 0]);
    cubenspeak("shortstud",   shortstud,   [c+studwalk*9-studw,       0, 0]);
    cubenspeak("tallstud",    tallstud,    [c+studwalk*9,             0, 0]);
    cubenspeak("trimmer",     trimmer,     [c+studwalk*9+studw,       0, 0]);
    cubenspeak("lowcripple",  lowcripple,  [c+rsillx,                 0, 0]);
    cubenspeak("lowcripple",  lowcripple,  [c+studwalk*10,            0, 0]);
    cubenspeak("lowcripple",  lowcripple,  [c+rwindowastudx-studw,    0, 0]);
    cubenspeak("trimmer",     trimmer,     [c+rwindowastudx,          0, 0]);
    cubenspeak("trimmer",     trimmer,     [c+studwalk*11-studw,      0, 0]);
    cubenspeak("sill",        sill,        [c+rsillx,                 0, sillz]);
    cubenspeak("header",      header,      [c+studwalk*9+studw,       0, headerz]);
    cubenspeak("dropstud",    dropstud,    [c+studwalk*9+studw,       0, shortstudl-windowdrop]);
    cubenspeak("dropstud",    dropstud,    [c+studwalk*10-studw,      0, shortstudl-windowdrop]);
    cubenspeak("highcripple", highcripple, [c+studwalk*10,            0, shortstudl-windowdrop]);
    cubenspeak("dropstud",    dropstud,    [c+studwalk*11-studw,      0, shortstudl-windowdrop]);
    cubenspeak("tallstud",    tallstud,    [c+studwalk*11,            0, 0]);
    cubenspeak("shortstud",   shortstud,   [floorx-cornerstudw-studw, 0, 0]);
    cubenspeak("cornerstud",  cornerstud,  [floorx-cornerstudw,       0, 0]);
    cubenspeak("topplate0",   topplate0,   [0,                        0, tallstudl]);
    cubenspeak("topplate0",   topplate1,   [studh,                    0, tallstudl+studw]);
  }}
}


// S M A L L   W A L L
module smallwall(color, name) {
  echo();
  echo(name);
  origin = [0, studh, studelev];
  echo(origin = origin);
  soleplatel  = floory-studh*2;
  soleplate   = [studh, soleplatel, studw];
  topplate    = [studh, floory-studh*2, studw];
  tallstud    = [studh, studw, tallstudl];
  lowcripple  = [studh, studw, sillz];
  trimmer     = [studh, studw, doorroughopenh-windowdrop];
  highcripple = [studh, studw, tallstudl-shortstudl+windowdrop];
  shortstud   = [studh, studw, shortstudl];
  studwalk    = 16;
  header      = [headerboardw, studwalk*2 - studw, headerboardh];
  sill        = [studh, lwindowroughopenw, studw];
  echo(s=s);
  translate(origin) { color(color) {
    cubenspeak("soleplate",   soleplate,   [0, 0,                    -studw]);
    cubenspeak("tallstud",    tallstud,    [0, 0,                    0]);
    cubenspeak("tallstud",    tallstud,    [0, s,                    0]);
    cubenspeak("tallstud",    tallstud,    [0, s+studwalk,           0]);
    if (name == "WEST WALL") {
      cubenspeak("shortstud",   shortstud,   [0, s+studwalk*2-studw,   0]);
    }
    cubenspeak("tallstud",    tallstud,    [0, s+studwalk*2,         0]);
    cubenspeak("tallstud",    tallstud,    [0, s+studwalk*3,         0]);
    cubenspeak("tallstud",    tallstud,    [0, s+studwalk*4,         0]);
    cubenspeak("trimmer",     trimmer,     [0, s+studwalk*4+studw,   0]);
    cubenspeak("lowcripple",  lowcripple,  [0, s+studwalk*4+studw*2, 0]);
    cubenspeak("lowcripple",  lowcripple,  [0, s+studwalk*5,         0]);
    cubenspeak("lowcripple",  lowcripple,  [0, s+studwalk*4+lwindowroughopenw+studw,   0]);
    cubenspeak("trimmer",     trimmer,     [0, s+studwalk*4+lwindowroughopenw+studw*2, 0]);
    cubenspeak("trimmer",     trimmer,     [0, s+studwalk*6-studw,   0]);
    cubenspeak("sill",        sill,        [0, s+silly,              sillz]);
    cubenspeak("header",      header,      [0, s+studwalk*4+studw,   headerz]);
    cubenspeak("highcripple", highcripple, [0, s+studwalk*5,         shortstudl-windowdrop]);
    cubenspeak("tallstud",    tallstud,    [0, s+studwalk*6,         0]);
    cubenspeak("tallstud",    tallstud,    [0, soleplatel-studw,     0]);
    cubenspeak("topplate",    topplate,    [0, 0,                    tallstudl]);
  }}
}
// E A S T   W A L L
module eastwall(color) {
  smallwall(color, "EAST WALL");
}
// W E S T   W A L L
module westwall(color) {
  translate([floorx-studh, 0, 0]) {
    smallwall(color, "WEST WALL");
  }
}

// L O F T
module loft(color) {
  echo();
  echo("LOFT");
  origin = [0, 0, studelev+shortstudl];
  echo(origin = origin);
  tallstud    = [studw, studh, tallstudl];
  shortstudl  = doorroughopenh+headerboardh;
  joistw      = joistboard[0];
  joisth      = joistboard[1];
  joist       = [joistw, floory, joisth];
  s           = 6.5; // see "smallwall"
  shortjoist  = [joistboard[0], floory-studwalk*2-s-studh, joistboard[1]];
  shortjoisty = studwalk*2+studh+s;
  crossjoist  = [studwalk*3-joistw*2-c, joistw, joisth];
  translate(origin) { color(color) {
    cubenspeak("joist",      joist,       [studh,                 0,                  0]);
    cubenspeak("joist",      joist,       [c+studwalk  +studw,    0,                  0]);
    cubenspeak("joist",      joist,       [c+studwalk*2+studw,    0,                  0]);
    cubenspeak("joist",      joist,       [c+studwalk*3-studw,    0,                  0]);
    cubenspeak("joist",      joist,       [c+studwalk*3+studw,    0,                  0]);
    cubenspeak("joist",      joist,       [c+studwalk*4-studw,    0,                  0]);
    cubenspeak("joist",      joist,       [c+studwalk*5-studw,    0,                  0]);
    cubenspeak("joist",      joist,       [c+studwalk*6-studw,    0,                  0]);
    cubenspeak("joist",      joist,       [c+studwalk*6+studw,    0,                  0]);
    cubenspeak("joist",      joist,       [c+studwalk*7+studw,    0,                  0]);
    cubenspeak("joist",      joist,       [c+studwalk*8+studw,    0,                  0]);
    cubenspeak("joist",      joist,       [c+studwalk*9-studw,    0,                  0]);
    cubenspeak("joist",      joist,       [c+studwalk*9+studw,    0,                  0]);
    cubenspeak("shortjoist", shortjoist,  [c+studwalk*10-studw,   shortjoisty,        0]);
    cubenspeak("crossjoist", crossjoist,  [c+studwalk*9+studw*2,  shortjoisty-joistw, 0]);
    cubenspeak("shortjoist", shortjoist,  [floorx-studh-studw,    shortjoisty,        0]);
    cubenspeak("shortjoist", shortjoist,  [c+studwalk*11-studw,   shortjoisty,        0]);
  }}
}

wallpanelthickness = 1/2;
floorthickness     = 1/2;

// L A D D E R
module ladder(color) {
  echo();
  echo("LADDER");
  origin = [0, 0, subfloorelev+subfloorrise+floorthickness];
  echo(origin = origin);
  legboard  = b2x4;
  legboardw = legboard[0];
  legboardh = legboard[1];
  legheight = ft(13);
  rungboard  = b2x4;
  rungboardw = rungboard[0];
  rungboardh = rungboard[1];
  rungl      = ft(2);
  leg = [legboardh, legboardw, legheight];
  legx = floorx - studh - legboardh - wallpanelthickness;
  legyl = upperfloorportdim[1] - legboardw;
  legyr = upperfloorportdim[1] - rungl;
  rung = [rungboardw, rungl, rungboardh];
  rungx = legx - rungboardw;
  rungy = legyr;
  rungwalk = 12;
  translate(origin) { color(color) {
    cubenspeak("leg",  leg,   [legx,  legyl, 0]);
    cubenspeak("leg",  leg,   [legx,  legyr, 0]);
    cubenspeak("rung", rung,  [rungx, rungy, rungwalk  -rungboardh]);
    cubenspeak("rung", rung,  [rungx, rungy, rungwalk*2-rungboardh]);
    cubenspeak("rung", rung,  [rungx, rungy, rungwalk*3-rungboardh]);
    cubenspeak("rung", rung,  [rungx, rungy, rungwalk*4-rungboardh]);
    cubenspeak("rung", rung,  [rungx, rungy, rungwalk*5-rungboardh]);
    cubenspeak("rung", rung,  [rungx, rungy, rungwalk*6-rungboardh]);
    cubenspeak("rung", rung,  [rungx, rungy, rungwalk*7-rungboardh]);
    cubenspeak("rung", rung,  [rungx, rungy, rungwalk*8-rungboardh]);
    cubenspeak("rung", rung,  [rungx, rungy, rungwalk*9-rungboardh]);
    cubenspeak("rung", rung,  [rungx, rungy, rungwalk*10-rungboardh]);
    cubenspeak("rung", rung,  [rungx, rungy, rungwalk*11-rungboardh]);
    cubenspeak("rung", rung,  [rungx, rungy, rungwalk*12-rungboardh]);
    cubenspeak("rung", rung,  [rungx, rungy, rungwalk*13-rungboardh]);
  }}
}




gableelv         = studelev + tallstudl + studw;
ridgeboardboard  = b1x8;
braceplateboard  = studboard;
braceplateboardw = braceplateboard[0];
braceplateboardh = braceplateboard[1];
braceplateendw   = sqrt(2*braceplateboardw*braceplateboardw);


// G A B L E
module gable(color, name) {
  echo();
  echo(name);
  origin = [0, 0, gableelv+studw];
  echo(origin = origin);
  soleplate = [studh, floory, studw];
  ridgeboardw      = ridgeboardboard[0];
  braceplatelegl   = floory/2 - ridgeboardw/2 - studh;
  braceplateside = [
  /* 0 */ [0,braceplatelegl,braceplatelegl],
  /* 1 */ [0,braceplatelegl,braceplatelegl-braceplateendw],
  /*   2, 3*/           [0,braceplateendw,0], [0,0,0]
  ];
  braceplate = [
    braceplateside[0],braceplateside[1],braceplateside[2],braceplateside[3],
    [studh, braceplateside[0][1], braceplateside[0][2]],
    [studh, braceplateside[1][1], braceplateside[1][2]],
    [studh, braceplateside[2][1], braceplateside[2][2]],
    [studh, braceplateside[3][1], braceplateside[3][2]]
  ];
  iii = [[0,1,2,3],[4,5,6,7],[0,4,7,3],[1,5,6,2],[0,4,5,1],[2,6,7,3]];
  translate(origin) { color(color) {
    cubenspeak("soleplate",   soleplate,   [0, 0, -studw]);
    polyspeak("braceplate", braceplate, iii, [0,studh,0]);
    translate([studh,floory,0]) { rotate([0,0,180]) {
      polyspeak("braceplate", braceplate, iii, [0,studh,0]);
    }}
  }}
}

// E A S T   G A B L E
module eastgable(color) {
  gable(color, "EAST GABLE");
}
// W E S T   G A B L E
module westgable(color) {
  translate([floorx-studh, 0, 0]) {
    gable(color, "WEST GABLE");
  }
}

module ridgeboard(color) {
  echo();
  echo("ridgeboard");
  origin = [0, 0, gableelv+studw];
  echo(origin = origin);
  ridgeboardw      = ridgeboardboard[0];
  ridgeboardh      = ridgeboardboard[1];
  ridgeboardext    = 12;
  ridgeboardl      = floorx + ridgeboardext*2;
  ridgeboard       = [ridgeboardl, ridgeboardw, ridgeboardh];
  ridgeboardy      = floory/2 - ridgeboardw/2;
  ridgeboardz      = floory/2 - ridgeboardw/2 - studh - braceplateendw;
  translate(origin) { color(color) {
    cubenspeak("ridgeboard",   ridgeboard,   [-ridgeboardext, ridgeboardy, ridgeboardz]);
  }}
}


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
dirtceiling(colors[8]);
floorjoists(colors[3]);
subfloor   (colors[2]);
northwall  (colors[5]);
southwall  (colors[7]);
eastwall   (colors[6]);
westwall   (colors[8]);
loft       (colors[9]);
ladder     ("crimson");
eastgable  (colors[6]);
westgable  (colors[8]);
ridgeboard (colors[1]);

lowerfloordim     = [floorx-studh, floory-studh];
lowerfloorarea    = lowerfloordim[0]*lowerfloordim[1];
upperfloorarea    = lowerfloorarea - upperfloorportdim[0]*upperfloorportdim[1];
totalfloorarea    = lowerfloorarea + upperfloorarea;
lowerheadroom     = shortstudl+studw;
floorthicknes     = 1;
upperwallheight   = tallstudl - shortstudl - joisth - floorthicknes;
upperheadroom     = upperwallheight + lowerfloordim[1]/2;
windowarea        = lwindowroughopenw*lwindowroughopenh*4 + uwindowroughopenw*uwindowroughopenh*2;
doorarea          = doorroughopenw*doorroughopenh;
totalintwallarea  = lowerfloordim[0]*tallstudl*2 + lowerfloordim[1]*tallstudl*2 + (lowerfloordim[1]*lowerfloordim[1])/2 - windowarea - doorarea;
totalsidingarea   = floorx*tallstudl*2 + floory*tallstudl*2 + (floory*floory)/2 - windowarea - doorarea;
totalroofarea     = 0;

echo("");
echo(str("lower floor space: ", lowerfloordim[0], " by ", lowerfloordim[1]));
echo(str("port size        : ", upperfloorportdim[0], " by ", upperfloorportdim[1]));
echo(str("lowerfloorarea   : ", lowerfloorarea, " in2, or ", lowerfloorarea/144, " ft2"));
echo(str("upperfloorarea   : ", upperfloorarea, " in2, or ", upperfloorarea/144, " ft2"));
echo(str("totalfloorarea   : ", totalfloorarea, " in2, or ", totalfloorarea/144, " ft2"));
echo(str("lowerheadroom    : ", lowerheadroom, " in, or ", lowerheadroom/12, " ft"));
echo(str("floorthicknes    : ", floorthicknes, " in"));
echo(str("upperwallheight  : ", upperwallheight, " in, or ", upperwallheight/12, " ft"));
echo(str("upperheadroom    : ", upperheadroom, " in, or ", upperheadroom/12, " ft"));
echo(str("totalintwallarea : ", totalintwallarea, " in2, or ", totalintwallarea/144, " ft2"));
echo(str("totalsidingarea  : ", totalsidingarea, " in2, or ", totalsidingarea/144, " ft2"));
echo(str("totalroofarea    : ", totalroofarea, " in2, or ", totalroofarea/144, " ft2"));
