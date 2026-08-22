module misc_tb;
    const int MAX_SIZE = 32000; // constant

    string s = "abc";
    string res;
    byte res_c;
    int res_buf;
    initial begin
        res_buf = s.len(); // -> returns length
        $display("length = %0d", res_buf);

        res_c = s.getc(2); // returns a byte at specified position
        $display("getc(2) = %0s", res_c);

        res_c = s.getc(6);  // 
        $display("getc(6) = %0b", res_c);

        s.putc(1,"K"); // Replaces the character at specified position
        $display("putc(1,'K') = %0s", s);

        s.putc(3, "T"); // Can't put new characters
        $display("putc(3,'T') = %0s", s);

        s.putc(1,"453d"); // Replaces the position's character with last character of replacing string ('d')
        $display("putc(1,'453d') = %0s", s);

        res = s.toupper();
        $display("s.toupper() = %0s", res);

        res = s.tolower();
        $display("s.tolower() = %0s", res);

        res = s.substr(1,2); // Returns a substring of specified index
        $display("substr(1,2) = %0s", res);

        // if (s == res)
        // if (s != res)

        // s.compare(res) -> returns 1 if s is greater than res
        //                -> returns 0 if s is equal to res
        //                -> returns -1 if s is smaller than res

        // s.icompare(res) -> Case insensitive comparison

        // Strings in system verilog don't have null character at the end
        // Any attempt to use the charact '\0' is ignored
    end
endmodule