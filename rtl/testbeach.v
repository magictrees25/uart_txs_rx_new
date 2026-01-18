`timescale 1ns/1ps





module testbeach();


    reg     clk;
    reg     rst;

    reg     uart_tx_req;
    wire    uart_txs_done;
    reg[23:0]   idats;



    wire        uart;
    


    wire[23:0]  odats;
    wire        uart_rxs_done;




    always #50 clk = ~clk;

    initial begin
        clk = 1'b1;
        rst = 1'b1;
        //idats =20'h5a5e ;
		  idats = 'd12256;
        uart_tx_req = 1'b0;//在initial中用reg

        #100
        rst = 1'b0;
        #100
        rst = 1'b1;

        #100
        uart_tx_req <= 1'b1;
    end
    

//    always@(posedge clk)
//        if(uart_txs_done == 1'b1)
//            idats <= idats + 'd2323;



uart_rxs#(
    .MulRXNum (3)
)UART_MulRX_HP(
    .sys_clk                            (clk),         /*ϵͳʱ�� 50M*/
    .rst_n                              (rst),          /*ϵͳ��λ*/

    .uart_rxs_done                      (uart_rxs_done),    /*���ڽ�������*/
   .odats                               (odats),           /*��������*/

    .uartrx                           (uart)         /*uart rx������*/
);

uart_str #( 
    .MulTXNum(3))   /*ÿ�η��͵ı�����*/
	 

UART_MulTXHP(
    
    .sys_clk                            (clk),         /*ϵͳʱ�� 50M*/
    .rst_n                              (rst),          /*ϵͳ��λ*/

    .uart_tx_req                        (uart_tx_req),   /*���ڷ�������*/
    .uart_txs_done                      (uart_txs_done),  /*���ڷ�������*/       

    .idats                              (idats),           /*���͵�����*/
    .uarttx                             (uart)        /*uart tx������*/
);




endmodule