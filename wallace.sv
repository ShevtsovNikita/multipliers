module wallace(
  input  logic [31:0] a, b,
  output logic [63:0] c
);

logic [7:0] aa[3:0];
assign aa[0] = a[ 7: 0];
assign aa[1] = a[15: 8];
assign aa[2] = a[23:16];
assign aa[3] = a[31:24];

logic [7:0] bb[3:0];
assign bb[0] = b[7:0];
assign bb[1] = b[15:8];
assign bb[2] = b[23:16];
assign bb[3] = b[31:24];

logic [15:0] ab[15:0]; // 16 16-битных промежуточный результатов

wallace_8x8 w00(.a(aa[0]), .b(bb[0]), .c(ab[ 0]));
wallace_8x8 w01(.a(aa[0]), .b(bb[1]), .c(ab[ 1]));
wallace_8x8 w02(.a(aa[0]), .b(bb[2]), .c(ab[ 2]));
wallace_8x8 w03(.a(aa[0]), .b(bb[3]), .c(ab[ 3]));
wallace_8x8 w10(.a(aa[1]), .b(bb[0]), .c(ab[ 4]));
wallace_8x8 w11(.a(aa[1]), .b(bb[1]), .c(ab[ 5]));
wallace_8x8 w12(.a(aa[1]), .b(bb[2]), .c(ab[ 6]));
wallace_8x8 w13(.a(aa[1]), .b(bb[3]), .c(ab[ 7]));
wallace_8x8 w20(.a(aa[2]), .b(bb[0]), .c(ab[ 8]));
wallace_8x8 w21(.a(aa[2]), .b(bb[1]), .c(ab[ 9]));
wallace_8x8 w22(.a(aa[2]), .b(bb[2]), .c(ab[10]));
wallace_8x8 w23(.a(aa[2]), .b(bb[3]), .c(ab[11]));
wallace_8x8 w30(.a(aa[3]), .b(bb[0]), .c(ab[12]));
wallace_8x8 w31(.a(aa[3]), .b(bb[1]), .c(ab[13]));
wallace_8x8 w32(.a(aa[3]), .b(bb[2]), .c(ab[14]));
wallace_8x8 w33(.a(aa[3]), .b(bb[3]), .c(ab[15]));

assign c = {48'b0, ab[0]} + {40'b0, ab[1], 8'b0} + {32'b0, ab[2], 16'b0} + {24'b0, ab[3], 24'b0} + 
           {40'b0, ab[4], 8'b0} + {32'b0, ab[5], 16'b0} +  {24'b0, ab[6], 24'b0} + {16'b0, ab[7], 32'b0} + 
           {32'b0, ab[8], 16'b0} + {24'b0, ab[9], 24'b0} + {16'b0, ab[10], 32'b0} + {8'b0, ab[11], 40'b0} + 
           {24'b0, ab[12], 24'b0} + {16'b0, ab[13], 32'b0} + {8'b0, ab[14], 40'b0} + {ab[15], 48'b0};

endmodule
