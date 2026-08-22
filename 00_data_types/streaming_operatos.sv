module tb_streaming;
typedef bit[3:0] nibble_t;
typedef bit[2:0] bit3_t;

bit[23:0] h;
bit[7:0] b,g[3], j[3] = '{'h0a, 'h0b, 'h0c};

nibble_t q_trans[$];
// j = 00001010|00001011|00001100
initial begin
    h = {>>{j}};    // h = 'h0a0b0c
    $display($sformatf(" H[] = %0h",h));

    h = {<<{j}};    // h = '001100001101000001010000 = 'h30d050
    $display($sformatf(" H[] = %0h",h));

    h = {<<nibble_t{j}} ;// h = '110000001011000010100000 = 'hc0b0a0
    $display($sformatf(" H[] = %0h",h));

    {>>{g}} = {<<bit3_t{j}}; 
    // First break j into chunks of 3 bits.
    // j = 000_010_100_000_101_100_001_100
    // Now create a buffer of reversing j in chunks of 3
    // j_temp = 100_001_100_101_000_100_010_000
    // Now stream this bit by bit into g[]
    //g = 'h86|51|10
    foreach(g[k])    $display($sformatf(" G[] = %0h",g[k]));

    q_trans = {>>{j}}; // converting byte to nibble
    foreach(q_trans[k])    $display($sformatf(" Q[] = %0h",q_trans[k]));

    j = {>>{q_trans}}; // converting nibble to byte
    foreach(j[k]) $display($sformatf(" J[] = %0h",j[k]));

    // Note: A common mistake when streaming between arrays is mismatched array
    // subscripts. An array is declared using [256] if streamed to another declared 
    // as [255:0] will results in streaming in reverse order.
end

    initial begin
        //===================================
        // Streaming operators can be usedful when we want to pack/unpack structures and classes

        typedef struct {int a;
                        bit[3:0] b;
                        nibble_t c;
                        byte unsigned d;} my_struct_s;
        my_struct_s st = '{'h3423,'hb, 'h6, 'h56};

        byte q_pack[$];

        q_pack = {>>{st}};
        foreach(q_pack[k]) $display($sformatf(" Q_PACK[] = %0h",q_pack[k]));

        q_pack = {'h12, 'h13, 'h43, 'h87, 'h98, 'hf9};
        st = { >>{q_pack}};

        $display($sformatf("a = %0h, b= %0h, c = %0h, d = %0d", st.a, st.b, st.c, st.d));

    end
endmodule
