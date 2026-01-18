`timescale 1ns/1ps


/*
���� : ValentineHP
�ϵ��ʽ : ΢�Ź��ں�  FPGA֮��
*/




/*���ڽ���ģ��*/
module uart_rxs #(
    parameter MulRXNum = 3
)(
    input                             sys_clk,        /*ϵͳʱ�� 50M*/
    input                             rst_n,          /*ϵͳ��λ*/

    output                            uart_rxs_done,   /*���ڽ�������*/
    output[MulRXNum * 'd8 - 'd1:0]    odats,           /*��������*/

    input                             uartrx         /*uart rx������*/
);


wire        uart_rx_done;
wire[7:0]   odat;

reg[2:0]    MulRxCnt;
reg[MulRXNum * 'd8 - 'd1:0] RXDataReg;

/*���ݽ�������*/
assign uart_rxs_done = ((MulRxCnt == (MulRXNum - 'd1)) && uart_rx_done == 1'b1) ? 1'b1 : 1'b0;

assign odats = RXDataReg;
/*���յ����ݼ���*/
always@(posedge sys_clk or negedge rst_n)
begin
    if(rst_n == 1'b0)
        MulRxCnt <= 'd0;
    else if(uart_rxs_done == 1'b1)
        MulRxCnt <= 'd0;
    else if(uart_rx_done == 1'b1) 
        MulRxCnt <= MulRxCnt + 1'b1;
    else
        MulRxCnt <= MulRxCnt;
end


/*�������ݼĴ���*/
always@(posedge sys_clk or negedge rst_n)
begin
    if(rst_n == 1'b0)
        RXDataReg <= 'd0;
    else if(uart_rx_done == 1'b1)
        RXDataReg <= {odat,RXDataReg[MulRXNum * 'd8 - 'd1:8]};
    else
        RXDataReg <= RXDataReg;
end



/*���ڽ���ģ��*/
uart_rx #(
    .UARTBaud(115200)
)UART_RXHP(
    .sys_clk            (sys_clk),        /*ϵͳʱ�� 50M*/
    .rst_n              (rst_n),          /*ϵͳ��λ*/

    .uart_rx_done       (uart_rx_done),   /*���ڽ�������*/
    .odat               (odat),           /*��������*/

    .uartrx             (uartrx)         /*uart rx������*/
);


endmodule