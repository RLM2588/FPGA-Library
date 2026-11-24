module delay #(
	parameter int DATA_WIDTH = 16,
	parameter int DELAY      = 1
)(
	input  logic                         clk   ,
	input  logic signed [DATA_WIDTH-1:0] i_data,
	input  logic signed                  en    ,
	output logic signed [DATA_WIDTH-1:0] o_data
);


Параметризация: DELAY >= 0

При DELAY 0, 1, 2 - первые N сигналов - X

tb запускает несколько линий задержки 0 1 2 3 и пускает 4х битный счетчик на вход + en
Сброс нужен только для счетчика в тестбенче.