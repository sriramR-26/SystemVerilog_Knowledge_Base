module tb;

    bit b;              // 2-state, single bit
    bit [7:0] bv        // 2 state, 8 bit unsigned integer

    logic [7:0] lv;     // 4 state, 8 bit unsigned integer
    // Logic can be driven by only a single driver. In case of multiple drivers, it will show a warning or error.
    
    time t;             // 4 state, 64 bit unsigned integer
    int unsigned ui;    // 2 state, unsigned 32 bit integer

    int i ;             // 2 state, signed 32 bit signed integer
    byte b8;            // 2 state, signed 8 bit signed integer
    shortint si;        // 2 state, 16 bit signed integer
    longint li;         // 2 state, 64 bit signed integer
    integer i4;         // 4 state, 32 bit signed integer
    real r;             // 2 state, double precision floating point

    // Default value for 2-state variables is 0 and for 4-state variables it's 'X'
endmodule