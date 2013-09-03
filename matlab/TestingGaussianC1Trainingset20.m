LEARNING_SET_PARAMETERS = [-15,-15,1; 15,15,1; -15,15,1; 15,-15,1];

NumberOfClasses = length(LEARNING_SET_PARAMETERS);

LEARNING_SET_ELEMENTS_COUNT = 20;

LEARNING_SET = generateRandomTrainingSet(LEARNING_SET_PARAMETERS, LEARNING_SET_ELEMENTS_COUNT);

ELEMENTS = generateRandomCircleSet(0,0,27, 1000);

KERNEL = @kernel_gaussian;