function generateRandomData(howMuch, numberOfFeatures) {
    var data = [];

    for (var i = howMuch; i >= 0; i--) {
        var features = [];
        for (var j = 0; j < numberOfFeatures; j += 1) {
            features.push(Math.random());
        }

        data.push(features);
    }

    return data;
}

function avg(arr) {
    return arr.reduce(function(a, b) {
        return a + b;
    }) / (arr.length);
}

function stdDev(arr) {
    var average = avg(arr);
    var n = arr.length;
    var sum = 0;
    for (var i = 0; i < n; i += 1) {
        sum += Math.pow((arr[i] - average), 2);
    }

    return sum;
}

function getFeature(elements, featureIndex) {
    return elements.map(function(element) {
        return element[featureIndex];
    });
}

function getNumberOfFeatures(arr) {
    var containsArrays = Array.isArray(arr[0]);
    var isArray = Array.isArray(arr);
    return containsArrays ? arr[0].length : isArray ? arr.length : 1;
}

function selectBandwidthFor(arr) {
    var containsArrays = Array.isArray(arr[0]);
    var numberOfFeatures = getNumberOfFeatures(arr);

    var result = [];
    var n = arr.length;

    if (numberOfFeatures === 1 && !containsArrays) {
        arr = arr.map(function(element) {
            return [element];
        });
    }

    for (var i = 0; i < numberOfFeatures; i += 1) {
        // var data = [];
        // arr.forEach(function(element) {
        //     data.push(element[i]);
        // });

        // The bigger the deviation among the elements, the larger the bandwidth
        // This serves to retain reasonable functino smoothing. If the value is too small
        // the function will not look smooth.
        result.push(3.486 * stdDev(getFeature(arr, i)) / Math.sqrt(n));
    }

    return result;
}

function K(u) {
    var e = Math.exp(1);
    return (Math.sqrt(2 * Math.PI) ^ -1) * (e ^ (-0.5 * u ^ 2));
}

function K_uniform(u) {
    return (0.5 * Math.abs(u)) <= 1 ? 1 : 0;
}

/**
 * Formula 2.84
 * @param  {Function} kernel
 * @param  {Number} _class                      The class for which the probability density is to be calculated.
 * @param  {Array[Array[Number]]} arr           The collection to which the processed element belongs.
 *                                              Used for calculating bandwidth for individual features.
 * @param  {Array[Number]} element              The element to calculate the probability for.
 * @param  {Array[Array[Number]]} trainingSet   A set of elements used to train the classifier.
 */

function discriminateFunction(kernel, _class, arr, element, trainingSet) {
    var n_i = trainingSet.length;
    var numberOfFeatures = getNumberOfFeatures(element);
    var result = 1;
    for (var f = 0; f < numberOfFeatures; ++f) {
        var data = getFeature(arr, f);
        var bandwidth = selectBandwidthFor(data);

        var trainingFeatures = getFeature(trainingSet, f);
        var feature = element[f];

        var sum = 0;
        for (var i = 0; i < n_i; ++i) {
            sum += kernel((feature - trainingFeatures[i]) / bandwidth);
        }

        result *= sum / bandwidth;
    }

    return result;
}

/**
 * Formula 2.86.
 * @param  {Function} kernel
 * @param  {Array[Number]} classes              The collection of classes to be considered while classifying the element.
 * @param  {Array[Array[Number]]} arr           The collection to which the processed element belongs.
 *                                              Used for calculating bandwidth for individual features.
 * @param  {Array[Number]} element              The element to classify.
 * @param  {Array[Array[Number]]} trainingSet   A set of elements used to train the classifier.
 *
 * @return {Number}                             The class to which the processed element belongs.
 */

function psi(kernel, classes, arr, element, trainingSet) {
    var results = [];
    classes.forEach(function() {
        results.push(Math.min());
    });

    for (var i = 0; i < classes.length; i++) {
        var trainingSetForClassI = trainingSet.filter(function(element) {
            return element["class"] === classes[i];
        });
        var tmpResultForClassI = discriminateFunction(kernel, classes[i], arr, element, trainingSetForClassI);
        for (var j = 0; j < classes.length; j++) {
            var trainingSetForClassJ = trainingSet.filter(function(element) {
                return element["class"] === classes[i];
            });

            var tmpResultForClassJ = discriminateFunction(kernel, classes[j], arr, element, trainingSetForClassJ);
            if (tmpResultForClassI > tmpResultForClassJ) {
                if (result[i] < tmpResultForClassI) {
                    result[i] = tmpResultForClassI;
                }
            }
        }
    }

    return classes[results.indexOf(Math.max.apply(null, results))];
}

/**
 * Iterates through every element of a given data set and classifies it using the implemented Bayesian classifier.
 * @param  {Function} kernel
 * @param  {Array[Number]} classes              The collection of classes to be considered while classifying the element.
 * @param  {Array[Array[Number]]} elements      The collection to which the processed element belongs.
 *                                              Used for calculating bandwidth for individual features.
 * @param  {Array[Array[Number]]} trainingSet   A set of elements used to train the classifier.
 */

function classifyElements(kernel, classes, elements, trainingSet) {
    var result = elements.map(function(element) {
        return {
            features: element
        };
    });
    /*
        [{
            features: [1,2],
            class: 1
        }, ...
        ]
     */

    result.forEach(function(element, index) {
        result[index]["class"] = psi(kernel, classes, elements, element, trainingSet);
    });
}

/**
 * Formula 2.83 (uogólniony przypadek d-wymiarowy estymatora jądrowego)
 * @param  {[type]} arr [description]
 * @return {[type]}     [description]
 */
// function kernelEstimator(arr) {
//     var n = arr.length;
//     var result = [];
//     var coefficient = 1 / (n * selectBandwidthFor(arr).reduce(function(a,b){
//         return a * b;
//     }));

//     for (var i = 0; i < numberOfFeatures; ++i) {
//         var data = getFeature(arr, i);
//         var sum = data.reduce(function(a, b) {
//             return a + K_uniform(b);
//         });

//         result.push(sum * coefficient);
//     }

//     return result;
// }

// tests
var numberOfElements = 100;
var numberOfFeatures = 2;
var rnd;

// Bandwidth selection tests
// for (var i = 0; i < numberOfElements; i += 1) {
//     var rnd = generateRandomData(i + 1, numberOfFeatures);
//     console.log("for", rnd.length, "elements");
//     for (var feature = 0; feature < numberOfFeatures; feature += 1) {
//         console.log("stdDev for feature", feature, stdDev(getFeature(rnd, feature)));
//     }

//     console.log("bandwidth", selectBandwidthFor(rnd));
// }

// rnd = [5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5];
// console.log("for", rnd.length, "IDENTICAL elements");
// console.log("stdDev", stdDev(rnd));
// console.log("bandwidth", selectBandwidthFor(rnd));

// rnd = [5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 1000];
// console.log("for", rnd.length, "IDENTICAL elements with one DEVIANT!");
// console.log("stdDev", stdDev(rnd));
// console.log("bandwidth", selectBandwidthFor(rnd));

rnd = [
    [5, 5],
    [5, 5],
    [5, 5],
    [5, 5],
    [5, 5],
    [5, 5] /*, 1000*/
];



var TRAINING_SET = [{
        features: [-4.887, -4.489],
        "class": 1
    }, {
        features: [-2.928, -1.104],
        "class": 1
    }, {
        features: [-0.707, -3.145],
        "class": 1
    }, {
        features: [-2.566, -2.883],
        "class": 1
    }, {
        features: [-2.442, -4.940],
        "class": 1
    }, {
        features: [-1.861, -2.228],
        "class": 1
    }, {
        features: [-3.582, -2.765],
        "class": 1
    }, {
        features: [-3.976, -2.535],
        "class": 1
    }, {
        features: [-3.247, -2.940],
        "class": 1
    }, {
        features: [-1.844, -3.978],
        "class": 1
    }, {
        features: [-2.176, -3.810],
        "class": 1
    }, {
        features: [-2.928, -2.286],
        "class": 1
    }, {
        features: [-3.099, -3.135],
        "class": 1
    }, {
        features: [-1.755, -2.504],
        "class": 1
    }, {
        features: [-2.586, -2.703],
        "class": 1
    }, {
        features: [-4.112, -2.949],
        "class": 1
    }, {
        features: [-2.852, -2.046],
        "class": 1
    }, {
        features: [-1.481, -3.658],
        "class": 1
    }, {
        features: [-3.633, -4.108],
        "class": 1
    }, {
        features: [-1.434, -2.475],
        "class": 1
    }, {
        features: [-5.462, -1.062],
        "class": 1
    }, {
        features: [-4.157, -3.055],
        "class": 1
    }, {
        features: [-3.100, -3.281],
        "class": 1
    }, {
        features: [-0.565, -2.653],
        "class": 1
    }, {
        features: [-0.974, -3.332],
        "class": 1
    },
C

    {
        features: [1.241, -4.208],
        "class": 2
    }, {
        features: [-0.318, 3.301],
        "class": 2
    }, {
        features: [6.026, 6.620],
        "class": 2
    }, {
        features: [3.895, 4.423],
        "class": 2
    }, {
        features: [2.210, 2.911],
        "class": 2
    }, {
        features: [2.652, 6.866],
        "class": 2
    }, {
        features: [13.673, -0.834],
        "class": 2
    }, {
        features: [1.895, 1.942],
        "class": 2
    }, {
        features: [0.636, 0.080],
        "class": 2
    }, {
        features: [1.072, 5.711],
        "class": 2
    }, {
        features: [6.560, -3.787],
        "class": 2
    }, {
        features: [-2.024, 5.388],
        "class": 2
    }, {
        features: [2.936, 4.015],
        "class": 2
    }, {
        features: [-0.565, 5.748],
        "class": 2
    }, {
        features: [6.636, -1.928],
        "class": 2
    }, {
        features: [3.015, 5.635],
        "class": 2
    }, {
        features: [1.826, 7.418],
        "class": 2
    }, {
        features: [6.180, 2.612],
        "class": 2
    }, {
        features: [3.049, 0.808],
        "class": 2
    }, {
        features: [3.464, 9.363],
        "class": 2
    }, {
        features: [1.152, 5.554],
        "class": 2
    }, {
        features: [0.294, 3.051],
        "class": 2
    }, {
        features: [7.186, 3.293],
        "class": 2
    }, {
        features: [5.028, 0.581],
        "class": 2
    }, {
        features: [3.926, 3.987],
        "class": 2
    }
];