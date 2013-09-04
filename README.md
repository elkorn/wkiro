wkiro
=====

An implementation of a parameterless empiric Bayesian classifier with a kernel estimator and bandwidth selection.

Fully implemented in Matlab, partially in JS.

Usage instructions
---
`main.m` is the application entry point. The simplest way to run the whole thing is to just type `main` in Matlab's 
Command Window.

The application execution can be parameterized by the following variables:

- `TRAINING_SET_PARAMETERS`, specifying a matrix of parameter vectors for each training dataset. 
 - Generated sets can be adjusted in the following dimensions:
   - X,Y coordinates of the training set center,
   - radius of the training set.
   
 - The number of parameter vectors in the matrix also specifies the number of classes, to which the target elements 
    will be ascribed.

 - One parameter vector describes the features of one training set.
    
 - The data format for the training set parameter matrix is the following:

```matlab
[x1,y1,r1; x2,y2,r2; x3,y3,r3] % unrestricted matrix length
```
 - In case no value is defined for the variable, the following default is used:

```matlab
[-15,-15,1; 15,15,1; -15,15,1; 15,-15,1];
```

- `TRAINING_SET_ELEMENTS_COUNT`, specifying the quantity of elements forming each training set.
 - Every training set has an equal number of elements.

 - In case no value is defined for the variable, the following default is used:

```matlab
20
```

- `ELEMENTS`, specifying the set of elements to classify.
 - An element is represented by a pair of coordinates.
 - The format for the data within this variable is as follows:

```matlab
[x1,y1; x2,y2; x3,y3] % unrestricted matrix length
```
 - In case no value is defined for the variable, a set of 100 elements generated randomly within a circular area cenetered at `(0,0)` and with a radius of `7` is used as the default.

- `KERNEL`, specifying the function used for kernel estimation by the classifier.
 - The variable is meant to be a function handle and can be used only as such.
 - There are a few predefined kernel functions available in the `kernels` directory for you to use.
 - In case no value is defined for the variable, the Gaussian kernel is used as the default.

todo
---
- update the implementation in JS
- add unit test coverage in JS
- fix the bug under Octave.
