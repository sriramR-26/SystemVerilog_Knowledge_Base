module tb;

    // Associative arrays are like hash table usefule when we need store elements along with keys/indices over a large range 
    // without allocating huge memory to store the data. 

    // Suppose I have thousands of transactions, each with a unique ID, and I frequently need to retrieve a transaction by its ID.
    // A fixed array can waste index space if the IDs are sparse/large. If they are dense (like 0-999) then it can be considered
    // A queue requires searching (find(), find_index()) to locate a transaction by ID.
    // An associative array maps the ID directly to the transaction, making key-based lookup natural

    // transactions.exists(id) is useful because it lets us distinguish "there is no transaction with this ID" from simply accessing an entry.

    typedef bit[3:0] nibble;
    
    function void disp_msg(input string tag, input string msg);
        $display($sformatf("[%0t][%0s]: %0s", $time, tag, msg));
    endfunction

    // We will write codes to declare, initialize, populate and traversal of associative arrays

    int nib_array[nibble] = '{1:5,6:9,15:98};
    int m = 1;
    initial begin

        // We can't use for-loop because indices are not contiguous.
        foreach(nib_array[k]) disp_msg("AARRAY BASICS", $sformatf("nibble_array[%0d]: %0d", k, nib_array[k]));

        // Start traversing the array from the next index from a particular key.
        while(nib_array.next(m)) disp_msg("AARRAY BASICS 2", $sformatf("nibble_array[%0d]: %0d", m, nib_array[m]));

        m = 0;
        nib_array.first(m); // Retrieve and store the first index in m
        disp_msg("AARRAY BASICS 3", $sformatf("First Index = %0d", m));

        nib_array[8] = 56;
        foreach(nib_array[k]) disp_msg("AARRAY BASICS 4", $sformatf("nibble_array[%0d]: %0d", k, nib_array[k]));

        // Check the existence of a key
        disp_msg("AARRAY BASICS 5", $sformatf("Index Exists? = %0s", nib_array.exists(5)? "True": "False"));
        disp_msg("AARRAY BASICS 5", $sformatf("Index Exists? = %0s", nib_array.exists(6)? "True": "Flase"   ));

        // Accessing an unwritten index returns the default value of the array type. 
        disp_msg("AARRAY BASICS 6", $sformatf("Unwritten Index Value Stored = %0b", nib_array[5]);

    end
endmodule