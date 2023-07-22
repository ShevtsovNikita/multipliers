`timescale 1ns / 1ps 
module w32x32_tb();

// создаем тактирование:
logic clock;
always begin
  clock <= 0; #5;
  clock <= 1; #5;
end

// память для считывания массива тестовых векторов
reg [127:0] test_vectors [0:2047];
// счетчик, указывающий на номер вектора, и счетчик ошибок
reg [10:0] counter, errors;

initial begin
  counter <= 11'h0;
  errors <= 11'h0;
  $readmemb("test_vectors.mem", test_vectors);
end

logic [31:0] a, b;
logic [63:0] c, expected_result;

wallace dut(.a(a), .b(b), .c(c));

always @(posedge clock)
begin
  {a, b, expected_result} <= test_vectors[counter];
  counter <= counter + 1;
  if(expected_result !== c)
    errors <= errors + 1;
  if(counter == 11'h7ff)
    begin
      if(errors == 0)
        $display("Тесты завершены без ошибок");
      else
        $display("Количество ошибок: ", errors);
      $finish;
    end
end

endmodule
