module ff ( input data, input c, input r, output q);
reg q;
always @(posedge c or negedge r) 
begin
 if(r==1'b0)
  q <= 1'b0; 
 else 
  q <= data; 
end 
endmodule //End 

/*     d    +-------+
     +----->|       |
         e  |address|out  (2 bits)
        +-->|       +----+
        |   |       |    |
        |   +-------+    |
        |                |
        |      +---+     |
        +------+   |+----+
          e    |st0| pe
               +---+                 */
module stateMem(input clk,input res,input [1:0] A, output [2:0] C);
reg [5:0] StateMachine [0:31]; // Exemplo com 4 linhas (2 bits de endereço) e largura 5 bits
initial
begin
StateMachine[0] = 6'h12; // statemachine[linha] = conteúdo da linha
StateMachine[1] = 6'h12;   
StateMachine[2] = 6'h30;
//StateMachine[3] = 6'h1;
StateMachine[4] = 6'h14;
StateMachine[5] = 6'h13;
StateMachine[6] = 6'h9;
//StateMachine[7] = 6'h1;
StateMachine[8] = 6'h12;
StateMachine[9] = 6'h32;
StateMachine[10] = 6'h8;
//StateMachine[11] = 6'h1;
StateMachine[12] = 6'h14;
StateMachine[13] = 6'h13;
StateMachine[14] = 6'h1;
//StateMachine[15] = 6'h1;
StateMachine[16] = 6'h12;
StateMachine[17] = 6'h12;
StateMachine[18] = 6'h10;
//StateMachine[19] = 6'h1;
StateMachine[20] = 6'h20;
StateMachine[21] = 6'h2B;
StateMachine[22] = 6'h11;
//StateMachine[23] = 6'h1;
StateMachine[24] = 6'h12;
StateMachine[25] = 6'h12;
StateMachine[26] = 6'h28;
//StateMachine[27] = 6'h1;
StateMachine[28] = 6'h14;
StateMachine[29] = 6'h23;
StateMachine[30] = 6'h11;
end
wire [4:0] address;  // exemplo 2 bits de endereço = 4 linhas
wire [5:0] dout;   // exemplo com largura 5 bits
assign dout = StateMachine[address]; // captura a saida da memoria (proximo,saidas)
// saidas nos bits 2, 1, 0 (exemplo)..
assign C = {dout[2], dout[1], dout[0]}; 
// flip flop de estados, Proximo estado nos bits 3 e 4 (exemplo).
ff st0(dout[3],clk,res,address[0]);
ff st1(dout[4],clk,res,address[1]);
ff st2(dout[5],clk,res,address[2]);
assign address[3] = A[0];
assign address[4] = A[1];
endmodule
