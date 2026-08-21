module tb;
    function void disp_msg(input string tag, input string msg);
        $display($sformatf("[%0t][%0s]: %0s", $time, tag, msg));
    endfunction
    // A queue can be either bounded or unbounded.
    // An unbounded queue is declareed with just a "$".
    int uq[$];
    int uq1[$] = {5,6,3,12};

    int bq[$:5]; // Maximum capacity of 6 elements
    int j = 1, tmp;
    initial begin
        repeat (7) begin
            bq.push_back(j);
            j += 1;
            disp_msg("BOUNDED QUEUE", $sformatf("%0p", bq));
        end
    end 

    initial begin
        #5;
        repeat(3) begin
            #1 tmp = bq.pop_back();
            disp_msg("BOUNDED QUEUE", $sformatf("Element popped: %0d", tmp));

        end
    end

    initial begin 
        uq = {uq1[1:3]};
        uq1.insert(1,8); // insert 8 before the element at index 1 and shift others accordingly
        uq1.delete(2); // Delete the element at index 2
        uq1 = uq1[0:$-1];
        uq1 = {uq1,9};
        disp_msg("Queue Methods", $sformatf("%0p", uq));
        disp_msg("Queue Methods", $sformatf("%0p", uq1));
        uq1.delete(); // Empty the queue/ delete the queue. Same as uq1 = {};

        // Problem with insert() and delete() is they take a performance hit as they have to shift elements whereas,
        // it's much more efficient to push and pop from the ends.
    end
    // We observe that once the capacity is reached, the simulator raises an warning and ignores the write and goes to next iteration.
    // For a blocking mechanism, we should use something like "wait(bq.size<6)".

    // In case of queue[$], we will always access the last element.
    // However in a range, queue[$:5] or queue[9:$], it will access the elements from the left or right extremity respectively

    // Queues are slightly less efficiient to access than fixed/dynamic size arrays because of additional pointers
    // But if data set grows and shrinks often, then using new[] for dynamic arrays everytime is expensive. 

endmodule