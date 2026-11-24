module filterTap #(
	parameter int INP_WIDTH = 16,
	parameter int SUM_WIDTH = 20,
	parameter int KFF_WIDTH = 2,
	parameter int DELAY     = 2
) (
	input  logic                        clk,
	input  logic signed [INP_WIDTH-1:0] i_smpl,
	input  logic                        i_smpl_v,
	input  logic signed [KFF_WIDTH-1:0] i_koeff,
	input  logic signed [SUM_WIDTH-1:0] i_prevTap,
	output logic signed [SUM_WIDTH-1:0] o_nextTap 
);
Использует файл из DELAY для создания задержки - имеет фактически те же ограничения

Все знаковое, есть насыщение, работает с разными размерами SUM_WIDTH

Идет сравнение с полной размерностью
localparam int FULL_SUM_WIDTH = (INP_WIDTH + KFF_WIDTH) + 1;