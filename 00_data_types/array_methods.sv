module tb_array_methods;
    function void disp_msg(input string tag, input string msg);
        $display($sformatf("[%0t][%0s]: %0s", $time, tag, msg));
    endfunction
    int arr[$] = {21,33,42,20,20,42,11,24,33};
    longint res;
    int arr_loc[$];
    int res_2;

    bit b_array[] = '{1,0,0,1,0,1};

    ///// Array Reduction Methods
    initial begin
        res = arr.sum();
        disp_msg("Block 1", $sformatf("res_sum = %0d", res));
        // res = arr.product();
        // disp_msg("Block 1", $sformatf("res_product = %0d", res));
        // res = arr.and();
        // disp_msg("Block 1", $sformatf("res_and = %0d", res));
    end

    // ====================================== //
    // Array Locator Methods
    // All array locator methods return the results as a queue of type "int" and not "integer"
    initial begin
        arr_loc = arr.min(); // Returns {11}
        disp_msg("Block 2", $sformatf("arr_loc = %0p", arr_loc));
        arr_loc = arr.max(); // Returns {42}
        disp_msg("Block 2", $sformatf("arr_loc = %0p", arr_loc)); 
        // Min and Max function also work for associative arrays

        arr_loc = arr.unique();
        disp_msg("Block 2", $sformatf("arr_loc = %0p", arr_loc));

        // We require an queue variable to store these results. Why?
        // Because in case of empty queues, the functions will return empty queue.

        //////////////////////////
        // "with" operator
        arr_loc = arr.find() with (item > 34); // Returns a queue of type int
        disp_msg("Block 2", $sformatf("arr_loc = %0p", arr_loc));

        arr_loc = arr.find(x) with (x <42); 
        disp_msg("Block 2", $sformatf("arr_loc = %0p", arr_loc));

        arr_loc = arr.find_index() with (item == 33);
        disp_msg("Block 2", $sformatf("arr_loc = %0p", arr_loc));

        arr_loc = arr.find_first_index() with (item == 32); // Returns an empty string
        disp_msg("Block 2", $sformatf("arr_loc = %0p", arr_loc));

        arr_loc = arr.find_last_index with (item == 20);
        disp_msg("Block 2", $sformatf("arr_loc = %0p", arr_loc));


        // How about we combine some boolean functions with locators?
        //int arr[$] = {21,33,42,20,20,42,11,24,33};
        res_2 = arr.sum() with (item>34?1:0); 
        // Returns sum({0,0,1,0,0,1,0,0,0}) = 2; 
        // This can be used to find the count of certain values       
        disp_msg("Block 3", $sformatf("res_2 = %0d", res_2));

        res_2 = arr.sum() with (item * (item>34)); 
        // Returns sum({0,0,42,0,0,42,0,0,0}) = 84;

        res_2 = arr.sum() with (item > 34? item:0);
        // Returns 84
        disp_msg("Block 3", $sformatf("res_2 = %0d", res_2));
        

        // One has to be careful of bit widths!
        // sum() function uses the width of the array's data
        // So if we add values of a 1-bit array, using sum(), we will will get a single bit result of either 0 or 1
        // So we need to type cast values before.

        res_2 = b_array.sum(); // Total = (1 + 1 + 1) = 1 (in 1-bit addition)
        disp_msg("Block 3", $sformatf("res_2 = %0d", res_2));

        res_2 = b_array.sum() with (int'(item)); // Total = 1 + 1 + 1 = 3
        disp_msg("Block 3", $sformatf("res_2 = %0d", res_2));
    end

    //===================================//
    // Array Sorting and Ordering
    // Unlike array locators and reduction operators, these change the original array!!
    int d [] = '{2,1,2,42,3,5};

    struct packed {bit [7:0] r,g,b;} pix[];
  
    initial begin
        #40;
        pix = '{'{r:7, g:34, b: 65}, '{r:70, g:49, b: 6},'{r:46, g:32, b: 63}};
        d.reverse();
        disp_msg("Block 4", $sformatf("Reverse = %0p", d));

        d.sort();
        disp_msg("Block 4", $sformatf("Sorted = %0p", d));

        d.shuffle();
        disp_msg("Block 4", $sformatf("Shuffled = %0p", d));

        d.rsort();
        disp_msg("Block 4", $sformatf("Reverse Sorted = %0p", d));  

        // reverse() and shuffle() don't have a "with" clause. But others have...
        pix.sort() with (item.r); // Sort using r only
        disp_msg("Block 5", $sformatf("Structure with sorting based on Red= %0p", pix));
        // pix = '{'{r:7, g:34, b: 65}, '{r:46, g:32, b: 63}, '{r:70, g:49, b: 6}};

        pix.sort() with ({item.g, item.b}); // Sort first based on g then b
        disp_msg("Block 5", $sformatf("Structure with sorting based on Red= %0p", pix));
        // pix = '{'{r:70, g:49, b: 6}, '{r:46, g:32, b: 63},'{r:7, g:34, b: 65}};

        // Only fixed & dynamic arrays and queues can be sorted, reversed or shuffled
        // Associative arrays cannot be re-ordered because it's a key based storage. 
        // We can't just say move this key before that key. 

        
    end
endmodule