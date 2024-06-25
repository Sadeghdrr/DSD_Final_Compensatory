module ParkingSystem (
    input car_entered,
    input is_uni_car_entered,
    input car_exited,
    input is_uni_car_exited,
    output reg signed [9:0] uni_parked_car = 0,
    output reg signed [9:0] free_parked_car = 0,
    output signed [9:0] uni_vacated_space,
    output signed [9:0] free_vacated_space,
    output uni_is_vacated_space,
    output free_is_vacated_space,
    output parking_is_vacated_space,
    output reg [4:0] hour = 0
);

localparam PARKING_SIZE = 700;

reg signed [9:0] uni_space = 0;
wire signed [9:0] free_space;

assign free_space = PARKING_SIZE - uni_space;
assign uni_vacated_space = uni_space - uni_parked_car;
assign free_vacated_space = free_space - free_parked_car;
assign parking_is_vacated_space = uni_vacated_space + free_vacated_space > 0;
assign uni_is_vacated_space = uni_vacated_space > 0 && parking_is_vacated_space;
assign free_is_vacated_space = free_vacated_space > 0 && parking_is_vacated_space;


always begin
    if (hour >= 24)
        hour = 0;
    
    if (hour >= 8 && hour < 13)
        uni_space = 500;
    else if (hour >= 13 && hour < 16) 
        uni_space = PARKING_SIZE - 200 - (hour - 12) * 50;
    else
        uni_space = 200;
        
    #200
    hour = hour + 1;
end

always @(negedge car_entered) begin
    case (is_uni_car_entered)
        1: 
            if (uni_is_vacated_space)
                uni_parked_car <= uni_parked_car + 1;
        0:
            if (free_is_vacated_space)
                free_parked_car <= free_parked_car + 1;
    endcase
end

always @(negedge car_exited) begin
        case (is_uni_car_exited)
        1: 
            if (uni_parked_car > 0)
                uni_parked_car <= uni_parked_car - 1;
        0:
            if (free_parked_car > 0)
                free_parked_car <= free_parked_car - 1;
    endcase
end



endmodule
