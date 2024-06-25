module TB;
    reg car_entered;
    reg is_uni_car_entered;
    reg car_exited;
    reg is_uni_car_exited;
    reg [4:0] hour;
    wire [9:0] uni_parked_car;
    wire [9:0] free_parked_car;
    wire [9:0] uni_vacated_space;
    wire [9:0] free_vacated_space;
    wire uni_is_vacated_space;
    wire free_is_vacated_space;
    wire parking_is_vacated_space;
    
    integer i = 0;

    ParkingSystem sample_system (
        .car_entered(car_entered),
        .is_uni_car_entered(is_uni_car_entered),
        .car_exited(car_exited),
        .hour(hour),
        .is_uni_car_exited(is_uni_car_exited),
        .uni_parked_car(uni_parked_car),
        .free_parked_car(free_parked_car),
        .uni_vacated_space(uni_vacated_space),
        .free_vacated_space(free_vacated_space),
        .uni_is_vacated_space(uni_is_vacated_space),
        .free_is_vacated_space(free_is_vacated_space),
        .parking_is_vacated_space(parking_is_vacated_space)
    );

    initial
        hour = 0;
    always begin
        #200
        if (hour >= 23)
            hour = 0;
        else
            hour = hour + 1;
    end

    initial begin
        car_entered = 1;
        is_uni_car_entered = 1;
        car_exited = 1;
        is_uni_car_exited = 0;

        // Testbench 1:
        // for (i = 0; i < 600; i = i + 1) begin
        //     #1 car_entered <= !car_entered;
        // end


        // Testbench 2:
        // for (i = 0; i < 600; i = i + 1) begin
        //     #1 car_entered <= !car_entered;
        // end

        // #1000
        // for (i = 0; i < 600; i = i + 1) begin
        //     #1 car_entered <= !car_entered;
        // end

        // #10
        // is_uni_car_entered = 0;

        // for (i = 0; i < 400; i = i + 1) begin
        //     #1 car_entered <= !car_entered;
        // end


        // Testbench 3:
        for (i = 0; i < 600; i = i + 1) begin
            #1 car_entered <= !car_entered;
        end

        #1000
        for (i = 0; i < 600; i = i + 1) begin
            #1 car_entered <= !car_entered;
        end

        #10
        is_uni_car_entered = 0;

        for (i = 0; i < 400; i = i + 1) begin
            #1 car_entered <= !car_entered;
        end

        #100
        for (i = 0; i < 50; i = i + 1) begin
            #1 car_entered <= !car_entered;
        end

        #500
        is_uni_car_exited = 1;
        for (i = 0; i < 50; i = i + 1) begin
            #1 car_exited <= !car_exited;
        end

        #100
        is_uni_car_entered = 1;
        for (i = 0; i < 50; i = i + 1) begin
            #1 car_entered <= !car_entered;
        end

        #100
        is_uni_car_entered = 0;
        for (i = 0; i < 100; i = i + 1) begin
            #1 car_entered <= !car_entered;
        end


        #3000 $stop();
    end

endmodule
