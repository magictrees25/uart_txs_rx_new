`timescale 1ns/1ps

module testbeach();


    reg     clk;
    reg     rst;
    
    // 发送部分信号
    reg     uart_tx_req;
    wire    uart_txs_done;
    reg[23:0]   idats;
    
    // 接收部分信号
    wire    uart_rxs_done;
    wire[23:0]  odats;
    
    // UART接口信号
    //wire        uarttx;
    //wire        uartrx;
	 wire        uart;

    // 创建UART内部连接回路（用于自环测试）
    //assign uartrx = uarttx;
    
    // 生成50MHz时钟（周期20ns）
    always #50 clk = ~clk;

    // 测试序列
//    initial begin
//        // 初始化信号
//        clk = 1'b1;
//        rst = 1'b1;
//        
//        idats = 16'ha3dc;  // 测试数据（3字节）
//        uart_tx_req = 1'b0;
//
//        // 系统复位
//        #100
//        rst = 1'b0;
//		  #100
//        rst = 1'b1;
//        // 发起第一个数据包发送请求
//        #100
//        uart_tx_req = 1'b1;

        
 initial begin
        clk = 1'b1;
        rst = 1'b1;
        idats = 'd12256;
        uart_tx_req = 1'b0;

        #100
        rst = 1'b0;
        #100
        rst = 1'b1;

        #100
        uart_tx_req <= 1'b1;
    end
    

    always@(posedge clk)
        if(uart_txs_done == 1'b1)
            idats <= idats + 'd2323;
        
   
    
    // 实例化uart_top模块（用于综合测试的顶层模块）
    uart_top uart_top_inst (
        .sys_clk        (clk),
        .rst_n          (rst),
        
        // 发送部分接口
        .uart_tx_req    (uart_tx_req),
        .uart_txs_done  (uart_txs_done),
        .idats          (idats),
        
        // 接收部分接口
        .uart_rxs_done  (uart_rxs_done),
        .odats          (odats),
        
        // UART接口
        .uarttx         (uart),
        .uartrx         (uart)
    );




endmodule