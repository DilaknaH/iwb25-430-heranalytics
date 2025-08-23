public function calculateFootprint(decimal meet, decimal gas, decimal shopping, 
                                  decimal carTravel, decimal electricity, decimal flights) returns decimal {
    return (meet * 2.5) + (gas * 0.2) + (shopping * 0.1) +
           (carTravel * 0.21) + (electricity * 0.43) + (flights * 0.18);
}
