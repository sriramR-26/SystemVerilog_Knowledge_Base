module tb_enums;
    typedef enum bit[2:0] {IDLE, SETUP, PROCESS, EXIT} my_fsm;
    
    // typdef enum {SETUP=1, PROCESS, EXIT} // WRONG!
    // The default type of enums is 'int' whose default value is '0'
    // So if the enum doesn't have a member represeting '0', at initalization
    // the enum variable is illegal!

    my_fsm ps, ns;
    int k;

    initial begin
        $display("Inital Value: %0s", ps.name);        
        
        ns = ps.next();
        $display("Next Value: %0s", ns.name);

        ns = ps.next(2);
        $display("Next Value times 2: %0s", ns.name);

        ns = ps.next(5);
        $display("Next Value times 5: %0s", ns.name);

        ns = ps.first();
        $display("First Value: %0s", ns.name);

        ns = ps.last();
        $display("Last Value: %0s", ns.name);

        ns = ns.prev(2);
        $display("Previous value times 2: %0s", ns.name);

        k = ns.next(2);
        ns = k; // or ns = my_fsm'(k);
        $display("Assigning '2' to ns: %0s", ns.name);

        k = 4; // illegal
        ns = k; // Doesn't throw an error
        $display("Static Assigning '2' to ns: %0s, %0d", ns.name, ns);


        $cast(ns, k); // Throws an error
        $display("Dynamic Casting: %0s, %0d", ns.name, ns);
        // Always use dynamic casting when working with enums
        // if (!$cast(ns,k)) `uvm_error("Illegal Enum")
        
        //In both casting, the value gets assigned but $cast throws an error

    end
endmodule