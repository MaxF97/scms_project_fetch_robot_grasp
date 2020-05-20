% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 553.599234489766104 ; 553.614309214737091 ];

%-- Principal point:
cc = [ 319.166862061345000 ; 239.433267282686018 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.002258102983589 ; -0.006305430967096 ; -0.000131457973087 ; -0.000224092504813 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 0.943935630413647 ; 0.967376721548703 ];

%-- Principal point uncertainty:
cc_error = [ 0.696751738445468 ; 0.694426589140316 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.003204233130871 ; 0.008732814128453 ; 0.000397728921738 ; 0.000409867057546 ; 0.000000000000000 ];

%-- Image size:
nx = 640;
ny = 480;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 15;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ 3.120110e+00 ; -1.493186e-04 ; -2.889425e-04 ];
Tc_1  = [ -8.863843e+02 ; 6.902438e+02 ; 2.509989e+03 ];
omc_error_1 = [ 1.763268e-03 ; 4.399695e-04 ; 2.787091e-03 ];
Tc_error_1  = [ 3.227540e+00 ; 3.239799e+00 ; 4.778244e+00 ];

%-- Image #2:
omc_2 = [ 3.091968e+00 ; 4.654448e-03 ; 4.174729e-01 ];
Tc_2  = [ -8.596343e+02 ; 6.854070e+02 ; 2.310363e+03 ];
omc_error_2 = [ 1.688968e-03 ; 4.893737e-04 ; 2.602840e-03 ];
Tc_error_2  = [ 3.066249e+00 ; 3.027776e+00 ; 4.529518e+00 ];

%-- Image #3:
omc_3 = [ 3.101023e+00 ; -3.669727e-03 ; -3.520577e-01 ];
Tc_3  = [ -8.672924e+02 ; 6.934187e+02 ; 2.678091e+03 ];
omc_error_3 = [ 1.644958e-03 ; 5.013426e-04 ; 2.513695e-03 ];
Tc_error_3  = [ 3.370827e+00 ; 3.399425e+00 ; 4.710723e+00 ];

%-- Image #4:
omc_4 = [ -2.945003e+00 ; 3.134236e-02 ; 2.711450e-01 ];
Tc_4  = [ -8.457157e+02 ; 6.803913e+02 ; 2.797924e+03 ];
omc_error_4 = [ 1.641246e-03 ; 4.891389e-04 ; 2.396959e-03 ];
Tc_error_4  = [ 3.502983e+00 ; 3.523036e+00 ; 4.780126e+00 ];

%-- Image #5:
omc_5 = [ -2.859671e+00 ; 5.831579e-02 ; 1.485445e-01 ];
Tc_5  = [ -8.414090e+02 ; 6.799909e+02 ; 2.809786e+03 ];
omc_error_5 = [ 1.621790e-03 ; 4.873097e-04 ; 2.335337e-03 ];
Tc_error_5  = [ 3.521062e+00 ; 3.537641e+00 ; 4.764949e+00 ];

%-- Image #6:
omc_6 = [ 2.881813e+00 ; -1.900490e-01 ; 2.521864e-01 ];
Tc_6  = [ -7.569778e+02 ; 7.423174e+02 ; 2.215241e+03 ];
omc_error_6 = [ 1.624606e-03 ; 4.935069e-04 ; 2.359421e-03 ];
Tc_error_6  = [ 2.920416e+00 ; 2.945555e+00 ; 4.385134e+00 ];

%-- Image #7:
omc_7 = [ 2.859017e+00 ; 2.427237e-01 ; 1.948190e-01 ];
Tc_7  = [ -9.443756e+02 ; 6.856275e+02 ; 2.152274e+03 ];
omc_error_7 = [ 1.585983e-03 ; 4.676429e-04 ; 2.334139e-03 ];
Tc_error_7  = [ 2.878044e+00 ; 2.885679e+00 ; 4.269604e+00 ];

%-- Image #8:
omc_8 = [ 3.092414e+00 ; -3.630108e-01 ; 1.897310e-01 ];
Tc_8  = [ -5.987401e+02 ; 6.173344e+02 ; 2.735503e+03 ];
omc_error_8 = [ 2.006800e-03 ; 5.778229e-04 ; 3.103136e-03 ];
Tc_error_8  = [ 3.514106e+00 ; 3.517110e+00 ; 5.286456e+00 ];

%-- Image #9:
omc_9 = [ 3.100619e+00 ; -8.236731e-03 ; 1.855020e-01 ];
Tc_9  = [ -9.506891e+02 ; 6.915824e+02 ; 2.109390e+03 ];
omc_error_9 = [ 1.505510e-03 ; 3.990100e-04 ; 2.413334e-03 ];
Tc_error_9  = [ 2.783905e+00 ; 2.789478e+00 ; 4.141858e+00 ];

%-- Image #10:
omc_10 = [ 3.093457e+00 ; -1.651987e-02 ; -3.003735e-01 ];
Tc_10  = [ -4.433019e+02 ; 6.979914e+02 ; 2.402605e+03 ];
omc_error_10 = [ 1.556840e-03 ; 4.313700e-04 ; 2.503875e-03 ];
Tc_error_10  = [ 3.053079e+00 ; 3.032076e+00 ; 4.257814e+00 ];

%-- Image #11:
omc_11 = [ -2.929297e+00 ; -7.231735e-03 ; -1.267152e-01 ];
Tc_11  = [ -4.706209e+02 ; 6.746797e+02 ; 2.375803e+03 ];
omc_error_11 = [ 1.517961e-03 ; 4.474011e-04 ; 2.275556e-03 ];
Tc_error_11  = [ 3.028916e+00 ; 2.969002e+00 ; 4.217587e+00 ];

%-- Image #12:
omc_12 = [ 2.355755e+00 ; 5.387359e-02 ; 1.690546e-01 ];
Tc_12  = [ -4.471237e+02 ; 4.041310e+02 ; 1.677274e+03 ];
omc_error_12 = [ 1.333080e-03 ; 7.161651e-04 ; 1.664643e-03 ];
Tc_error_12  = [ 2.160907e+00 ; 2.160428e+00 ; 3.456656e+00 ];

%-- Image #13:
omc_13 = [ -2.892828e+00 ; -9.992323e-02 ; -1.329368e-01 ];
Tc_13  = [ -7.963216e+02 ; 5.965645e+02 ; 2.358746e+03 ];
omc_error_13 = [ 1.500543e-03 ; 4.209151e-04 ; 2.170089e-03 ];
Tc_error_13  = [ 3.009125e+00 ; 2.980749e+00 ; 4.210821e+00 ];

%-- Image #14:
omc_14 = [ -2.715848e+00 ; -1.362531e-02 ; -1.147716e-01 ];
Tc_14  = [ -9.145901e+02 ; 6.705389e+02 ; 2.504235e+03 ];
omc_error_14 = [ 1.417490e-03 ; 4.824047e-04 ; 1.964918e-03 ];
Tc_error_14  = [ 3.161714e+00 ; 3.173103e+00 ; 4.184549e+00 ];

%-- Image #15:
omc_15 = [ -2.954964e+00 ; -2.012092e-05 ; -1.229676e-01 ];
Tc_15  = [ -7.300276e+02 ; 8.092302e+02 ; 2.155822e+03 ];
omc_error_15 = [ 1.401813e-03 ; 3.902325e-04 ; 2.068777e-03 ];
Tc_error_15  = [ 2.783846e+00 ; 2.728537e+00 ; 3.991198e+00 ];

