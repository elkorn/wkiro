LEARNING_SET_PARAMETERS = [-3,0,1; 3,0,1; 0,3,1; 0,-3,1];

NumberOfClasses = length(LEARNING_SET_PARAMETERS);

LEARNING_SET_ELEMENTS_COUNT = 200;

LEARNING_SET = generateRandomTrainingSet(LEARNING_SET_PARAMETERS, LEARNING_SET_ELEMENTS_COUNT);

ELEMENTS = generateRandomCircleSet(0,0,7, 1000);

KERNEL = @kernel_triangle;