module full_adder(
  input  logic a, b, c_in,
  output logic s, c_out
);

assign c_out = a ^ b ^ c_in;
assign s = (a&b) | (a&c_in) | (b&c_in);

endmodule 

module half_adder(
  input  logic a, b,
  output logic s, c_out
);

assign c_out = a ^ b;
assign s = a&b;

endmodule

module wallace_8x8(
  input  logic [07:00] a, b,
  output logic [15:00] c
);

assign c = a * b;

// промежуточные результаты первого этапа:
logic [7:0] ab10, ab11, ab12, ab13, ab14, ab15, ab16, ab17;
// промежуточные результаты второго этапа:
logic [9:0] ab20, ab22;
logic [7:0] ab21, ab23, ab24, ab25;
// промежуточные результаты третьего этапа:
logic [10:0] ab30;
logic [9:0] ab31, ab32;
logic [7:0] ab33;
// промежуточные результаты четвертого этапа:
logic [13:0] ab40;
logic [10:0] ab41;
logic [7:0] ab42;
// промежуточные результаты четвертого этапа:
logic [15:0] ab50;
logic [9:0] ab51;

assign ab10 = a & {8{b[0]}};
assign ab11 = a & {8{b[1]}};
assign ab12 = a & {8{b[2]}};
assign ab13 = a & {8{b[3]}};
assign ab14 = a & {8{b[4]}};
assign ab15 = a & {8{b[5]}};
assign ab16 = a & {8{b[6]}};
assign ab17 = a & {8{b[7]}};

//////////////////////1 стадия:///////////////////////////
assign ab24 = ab16;
assign ab25 = ab17;
assign ab20[0] = ab10[0];
half_adder ha11(.a(ab10[1]), .b(ab11[0]), .s(ab20[2]), .c_out(ab20[1]));
full_adder fa11(.a(ab10[2]), .b(ab11[1]), .c_in(ab12[0]), .s(ab20[3]), .c_out(ab21[0]));
full_adder fa12(.a(ab10[3]), .b(ab11[2]), .c_in(ab12[1]), .s(ab20[4]), .c_out(ab21[1]));
assign ab22[0] = ab13[0];
full_adder fa13 (.a(ab10[4]), .b(ab11[3]), .c_in(ab12[2]), .s(ab20[5]), .c_out(ab21[2]));
half_adder ha12 (.a(ab13[1]), .b(ab14[0]), .s(ab21[3]), .c_out(ab22[1]));
full_adder fa14 (.a(ab10[5]), .b(ab11[4]), .c_in(ab12[3]), .s(ab20[6]), .c_out(ab22[2]));
full_adder fa15 (.a(ab13[2]), .b(ab14[1]), .c_in(ab15[0]), .s(ab21[4]), .c_out(ab23[0]));
full_adder fa16 (.a(ab10[6]), .b(ab11[5]), .c_in(ab12[4]), .s(ab20[7]), .c_out(ab22[3]));
full_adder fa17 (.a(ab13[3]), .b(ab14[2]), .c_in(ab15[1]), .s(ab21[5]), .c_out(ab23[1]));
full_adder fa18 (.a(ab10[7]), .b(ab11[6]), .c_in(ab12[5]), .s(ab20[8]), .c_out(ab22[4]));
full_adder fa19 (.a(ab13[4]), .b(ab14[3]), .c_in(ab15[2]), .s(ab21[6]), .c_out(ab23[2]));
half_adder ha13 (.a(ab11[7]), .b(ab12[6]), .s(ab20[9]), .c_out(ab22[5]));
full_adder fa110(.a(ab13[5]), .b(ab14[4]), .c_in(ab15[3]), .s(ab21[7]), .c_out(ab23[3]));
assign ab22[6] = ab12[7];
full_adder fa111(.a(ab13[6]), .b(ab14[5]), .c_in(ab15[4]), .s(ab22[7]), .c_out(ab23[4]));
full_adder fa112(.a(ab13[7]), .b(ab14[6]), .c_in(ab15[5]), .s(ab22[8]), .c_out(ab23[5]));
half_adder ha14 (.a(ab14[7]), .b(ab15[6]), .s(ab22[9]), .c_out(ab23[6]));
assign ab23[7] = ab15[7];
//////////////////////2 стадия:///////////////////////////
assign ab30[1:0] = ab20[1:0];
half_adder ha21(.a(ab20[2]), .b(ab21[0]), .s(ab30[3]), .c_out(ab30[2]));
full_adder fa21(.a(ab20[3]), .b(ab21[1]), .c_in(ab22[0]), .s(ab30[4]), .c_out(ab31[0]));
full_adder fa22(.a(ab20[4]), .b(ab21[2]), .c_in(ab22[1]), .s(ab30[5]), .c_out(ab31[1]));
full_adder fa23(.a(ab20[5]), .b(ab21[3]), .c_in(ab22[2]), .s(ab30[6]), .c_out(ab31[2]));
assign ab32[0] = ab23[0];
full_adder fa24(.a(ab20[6]), .b(ab21[4]), .c_in(ab22[3]), .s(ab30[7]), .c_out(ab31[3]));
half_adder ha22(.a(ab23[1]), .b(ab24[0]), .s(ab31[4]), .c_out(ab32[1]));
full_adder fa25(.a(ab20[7]), .b(ab21[5]), .c_in(ab22[4]), .s(ab30[8]), .c_out(ab32[2]));
full_adder fa26(.a(ab23[2]), .b(ab24[1]), .c_in(ab25[0]), .s(ab31[5]), .c_out(ab33[0]));
full_adder fa27(.a(ab20[8]), .b(ab21[6]), .c_in(ab22[5]), .s(ab30[9]), .c_out(ab32[3]));
full_adder fa28(.a(ab23[3]), .b(ab24[2]), .c_in(ab25[1]), .s(ab31[6]), .c_out(ab33[1]));
full_adder fa29(.a(ab20[9]), .b(ab21[7]), .c_in(ab22[6]), .s(ab30[10]), .c_out(ab32[4]));
full_adder fa210(.a(ab23[4]), .b(ab24[3]), .c_in(ab25[2]), .s(ab31[7]), .c_out(ab33[2]));
assign ab32[7:5] = ab22[9:7];
full_adder fa211(.a(ab23[5]), .b(ab24[4]), .c_in(ab25[3]), .s(ab31[8]), .c_out(ab33[3]));
full_adder fa212(.a(ab23[6]), .b(ab24[5]), .c_in(ab25[4]), .s(ab31[9]), .c_out(ab33[4]));
full_adder fa213(.a(ab23[7]), .b(ab24[6]), .c_in(ab25[5]), .s(ab32[8]), .c_out(ab33[5]));
half_adder ha23(.a(ab24[7]), .b(ab25[6]), .s(ab32[9]), .c_out(ab33[6]));
assign ab33[7] = ab25[7];
//////////////////////3 стадия:///////////////////////////
assign ab42 = ab33;
assign ab41[10:9] = ab32[9:8];
assign ab40[2:0] = ab30[2:0];
half_adder ha31(.a(ab30[3]), .b(ab31[0]), .s(ab40[4]), .c_out(ab40[3]));
half_adder ha32(.a(ab30[4]), .b(ab31[1]), .s(ab40[5]), .c_out(ab41[0]));
full_adder fa31(.a(ab30[5]), .b(ab31[2]), .c_in(ab32[0]), .s(ab40[6]), .c_out(ab41[1]));
full_adder fa32(.a(ab30[6]), .b(ab31[3]), .c_in(ab32[1]), .s(ab40[7]), .c_out(ab41[2]));
full_adder fa33(.a(ab30[7]), .b(ab31[4]), .c_in(ab32[2]), .s(ab40[8]), .c_out(ab41[3]));
full_adder fa34(.a(ab30[8]), .b(ab31[5]), .c_in(ab32[3]), .s(ab40[9]), .c_out(ab41[4]));
full_adder fa35(.a(ab30[9]), .b(ab31[6]), .c_in(ab32[4]), .s(ab40[10]), .c_out(ab41[5]));
full_adder fa36(.a(ab30[10]), .b(ab31[7]), .c_in(ab32[5]), .s(ab40[11]), .c_out(ab41[6]));
half_adder ha33(.a(ab31[8]), .b(ab32[6]), .s(ab40[12]), .c_out(ab41[7]));
half_adder ha34(.a(ab31[9]), .b(ab32[7]), .s(ab40[13]), .c_out(ab41[8]));
//////////////////////4 стадия:///////////////////////////
assign ab50[3:0] = ab40[3:0];
half_adder ha41(.a(ab40[4]), .b(ab41[0]), .s(ab50[5]), .c_out(ab50[4]));
half_adder ha42(.a(ab40[5]), .b(ab41[1]), .s(ab50[6]), .c_out(ab51[0]));
half_adder ha43(.a(ab40[6]), .b(ab41[2]), .s(ab50[7]), .c_out(ab51[1]));
full_adder fa41(.a(ab40[7]), .b(ab41[3]), .c_in(ab42[0]), .s(ab50[8]), .c_out(ab51[2]));
full_adder fa42(.a(ab40[8]), .b(ab41[4]), .c_in(ab42[1]), .s(ab50[9]), .c_out(ab51[3]));
full_adder fa43(.a(ab40[9]), .b(ab41[5]), .c_in(ab42[2]), .s(ab50[10]), .c_out(ab51[4]));
full_adder fa44(.a(ab40[10]), .b(ab41[6]), .c_in(ab42[3]), .s(ab50[11]), .c_out(ab51[5]));
full_adder fa45(.a(ab40[11]), .b(ab41[7]), .c_in(ab42[4]), .s(ab50[12]), .c_out(ab51[6]));
full_adder fa46(.a(ab40[12]), .b(ab41[8]), .c_in(ab42[5]), .s(ab50[13]), .c_out(ab51[7]));
full_adder fa47(.a(ab40[13]), .b(ab41[9]), .c_in(ab42[6]), .s(ab50[14]), .c_out(ab51[8]));
half_adder ha44(.a(ab41[10]), .b(ab42[7]), .s(ab50[15]), .c_out(ab51[9]));
//////////////////////////////////////////////////////////
assign c = ab50 + {ab51, 5'b0};
endmodule
