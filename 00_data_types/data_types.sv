module tb;

    bit b;              // 2-state, single bit
    bit [7:0] bv        // 2 state, 8 bit unsigned integer

    logic [7:0] lv;     // 4 state, 8 bit unsigned integer
    // Logic can be driven by only a single driver. In case of multiple drivers, it will show a warning or error.
    // Useful to find netlist bugs
    time t;             // 4 state, 64 bit unsigned integer
    int unsigned ui;    // 2 state, unsigned 32 bit integer

    int i ;             // 2 state, signed 32 bit signed integer
    byte b8;            // 2 state, signed 8 bit signed integer
    shortint si;        // 2 state, 16 bit signed integer
    longint li;         // 2 state, 64 bit signed integer
    integer i4;         // 4 state, 32 bit signed integer
    real r;             // 2 state, double precision floating point

    // Default value for 2-state variables is 0 and for 4-state variables it's 'X'

    // Instead of using defines to define custom data types, it's better to use typedefs
    // typedefs can be put in a package and thus be shared across the testbench

    // Interesting Note:
    // To define a custom array type we do
    typedef int[5] array_5;
    array_5 arr = '{3,4,2,1,34}; // Equivalent to int arr[5];

    // Note: We can use typdefs for associative arrays
    typdef bit[63:0] bit64_t;
    bit64_t assoc_arr[bit64_t];

    // Note: Typedefs can also be used to create custom classes and structures
    typedef struct packed { bit[7:0] r,g,b;} pixel_t; // without typedef, only one variable will be created
    pixel_t in_p, out_p;
    initial begin 
        in_p = '{r:98, g:67, b:12};
    end
    // Packed structure allows it to be stored as contiguous bits with no unused space
    // They are useful when the members represent a numerical values like fields of a register
    
    
    //typedef uvm_sequencer#(transaction) my_sequencer_t;

endmodule