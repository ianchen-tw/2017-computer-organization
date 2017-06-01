# PipeLine CPU - Overview

    這次的lab重點是將的Lab3的CPU轉為pipeLine版本。
    除了要產生pipeLine Register以外，還需要處理因為pipeLine而產生的data hazard& control hazard,這兩項問題分別是透過新增forwarding unit 與 hazard detection unit來解決。
    另外，因為PipeLine的產生，所以將硬體平均分配在各stages也是十分重要的一件事情


# **新增的硬體單元**

# Pipe_Reg
    Pipe_Reg 主要是拿來儲存各個階段訊號的的結果，並將需要在往後 stage 使用到的訊號傳下去。

# Forwarding Unit
    
# Hazard Detection Unit 
# Mux_3to1
    
# **更動的硬體硬體單元(與lab3比較)**
## PC

## Decoder, ALU_control, ALU  

# 整體架構寫法

# debug過程 
    


