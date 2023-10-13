# LTC2264_decoder
This project aim to read the LTC2264 sensor.

## Specification of the design
- 1 Data Lane (1 LVDS pair) configured from SPI 
- SPI configuration: CPOL = CPHA = 0
- ADC depth = 14 bits 

In order to test, the low clock frequency (5 MHz) is utilized. This can be scaled up to the maximum of the ADC. To reduce the pin usage, the FRAME_CLK considered a parallel clock from LTC2264 is not used. The parallel clock plays an important role in serial decoders due to the fact that it specifies the length of the data. Therefore, we need to generate our own parallel clock with the clock wizard, and it will be slower than the serial clock seven times. Note that this parallel clock needs to be generated from the serial clock only in order to prevent the misalignment of these two clocks.

## adcDecodeLVDS
This module mainly translate the serial data to parallel. The operation of this module is begin as follow: 
1. The module translate the serial data to parallel data intuitively. This will resulting in data misalignment. 
2. The SPI module need to config the ADC as well as its training data. Here is set to 0x455. 
3. The adcDecodeLVDS module wait for the starttraining flag in order to perform bit correction operation based on the bitslip. 
4. Once the operation is finish, the module will translate the training data correctly. 
5. The SPI module can be turn off training mode and send the real data.  

## The SPI module 
We utilize the AXI_QUAD_SPI IP from Xilinx which we need to use the PS section to program. The input clock of this module is 10 MHz while the clock divider is two. So that is resulting in SPI CLK is around 5 MHz. We need to program the SPI polarity in which the CPOL and CPHA are equal to zero based on its document.