module uart_top(
    input           sys_clk,      // 系统时钟 50MHz
    input           rst_n,        // 系统复位，低电平有效
    
    // 发送部分接口
    input           uart_tx_req,  // 发送请求信号
    output          uart_txs_done,// 发送完成信号
    input   [23:0]  idats,        // 发送数据
    
    // 接收部分接口
    output          uart_rxs_done,// 接收完成信号
    output  [23:0]  odats,        // 接收数据
    
    // UART接口
    output          uarttx,       // UART发送数据线
    input           uartrx        // UART接收数据线
);

// 实例化多字节发送模块
uart_str #(
    .MulTXNum(3)  // 每次发送3个字节
) UART_MulTX_inst (
    .sys_clk        (sys_clk),
    .rst_n          (rst_n),
    .uart_tx_req    (uart_tx_req),
    .uart_txs_done  (uart_txs_done),
    .idats          (idats),
    .uarttx         (uarttx)
);

// 实例化多字节接收模块
uart_rxs #(
    .MulRXNum(3)  // 每次接收3个字节
) UART_MulRX_inst (
    .sys_clk        (sys_clk),
    .rst_n          (rst_n),
    .uart_rxs_done  (uart_rxs_done),
    .odats          (odats),
    .uartrx         (uartrx)
);






endmodule 