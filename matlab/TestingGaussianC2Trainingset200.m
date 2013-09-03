LEARNING_SET_PARAMETERS = [-15,0,1; 15,0,1; 0,15,1; 0,-15,1];

NumberOfClasses = length(LEARNING_SET_PARAMETERS);

LEARNING_SET_ELEMENTS_COUNT = 200;

LEARNING_SET = generateRandomTrainingSet(LEARNING_SET_PARAMETERS, LEARNING_SET_ELEMENTS_COUNT);

ELEMENTS = generateRandomCircleSet(0,0,27, 1000);

KERNEL = @kernel_gaussian;