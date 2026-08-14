module tb;

    function void disp_msg(input string tag, input string msg);
        $display($sformatf("[%0t][%0s]: %0s", $time, tag, msg));
    endfunction
    // Usually system-verilog simulators store each element of an unpacked array in a 32-bit word boundary.
    // So a byte, shortint, and int are all stored in a single word whereas longint takes 2 word.

    bit [7:0] b_unpack [4]; // Unpacked array of 4 elements each is 8 bits wide
    // The above variable will be stored in 4 32-bit word spaces instead of a single 32-bit word divided into 4 parts.


    //=======================
    // How to declare an array literal?
    int arr[5];
    initial begin
        arr = '{3,3,5,2,1}; 
        disp_msg("Block1", $sformatf("%0p",arr));        
        arr[0:2] = '{5,3,1};
        disp_msg("Block1", $sformatf("%0p",arr));
        arr = '{5{2}};
        disp_msg("Block1", $sformatf("%0p",arr));
        arr = '{default:5}; // All elements are set to 5
        disp_msg("Block1", $sformatf("%0p",arr));
    end
    //=======================
    
    // How to initialize and walk through a muti dimensional array

    int md_array[2][4];
    initial begin
        md_array = '{'{3,4,31,1}, '{45,1,4,1}};
        foreach(md_array[i]) disp_msg("Block2", $sformatf("%0p",md_array[i]));
        foreach(md_array[i,j]) disp_msg("Block2", $sformatf("%0d",md_array[i][j]));
    end

endmodule