# Universal-Asynchronous-Receiver-and-Transmitter-UART
A simple UART which is built using Verilog.

UARTs are easy ways to transmit and receive data between the computer and the peripherals.
It has two basic functionalities: Parallel to serial data conversion (transmitter) and Serial to parallel (receiver).

Transmitter and Receiver must have process the data at same frequency which is called Baud Rate.

## Data Stream
Start Bit: Always low and initially the receiver is driven high. Whenever zero is found it understand this is start bit of a data stream.
<br>Data 0-7: Actual 8-bit data that is supposed to be transmitted and received.
<br>Stop Bit: End of the data stream and always high.

## Transmitter Operation
![transmit](https://user-images.githubusercontent.com/16850746/79694842-cb8ce280-8294-11ea-85ff-59ac638276dd.PNG)

## Reciever Operation
![recieve](https://user-images.githubusercontent.com/16850746/79694851-e2cbd000-8294-11ea-9099-b423fa2d3975.PNG)

### EDAPLAYGROUND Link
https://www.edaplayground.com/x/5ZUd
