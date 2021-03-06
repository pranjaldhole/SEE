% Auto-generated by cameraCalibrator app on 04-Jun-2018
%-------------------------------------------------------


% Define images to process
imageFileNames = {'/home/pranjal/gitRepos/SEE/optical_tracking_system/data/1.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/10.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/11.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/12.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/13.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/14.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/15.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/16.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/17.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/18.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/19.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/2.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/20.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/21.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/22.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/23.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/24.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/25.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/26.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/27.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/28.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/29.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/3.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/30.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/31.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/32.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/33.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/34.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/35.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/36.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/37.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/38.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/39.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/4.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/40.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/41.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/42.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/43.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/44.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/45.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/46.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/47.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/48.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/49.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/5.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/50.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/51.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/6.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/7.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/8.jpg',...
    '/home/pranjal/gitRepos/SEE/optical_tracking_system/data/9.jpg',...
    };

% Detect checkerboards in images
[imagePoints, boardSize, imagesUsed] = detectCheckerboardPoints(imageFileNames);
imageFileNames = imageFileNames(imagesUsed);

% Read the first image to obtain image size
originalImage = imread(imageFileNames{1});
[mrows, ncols, ~] = size(originalImage);

% Generate world coordinates of the corners of the squares
squareSize = 72;  % in units of 'millimeters'
worldPoints = generateCheckerboardPoints(boardSize, squareSize);

% Calibrate the camera
[cameraParams, imagesUsed, estimationErrors] = estimateCameraParameters(imagePoints, worldPoints, ...
    'EstimateSkew', true, 'EstimateTangentialDistortion', true, ...
    'NumRadialDistortionCoefficients', 3, 'WorldUnits', 'millimeters', ...
    'InitialIntrinsicMatrix', [], 'InitialRadialDistortion', [], ...
    'ImageSize', [mrows, ncols]);

% View reprojection errors
h1=figure; showReprojectionErrors(cameraParams);

% Visualize pattern locations
h2=figure; showExtrinsics(cameraParams, 'CameraCentric');

% Display parameter estimation errors
displayErrors(estimationErrors, cameraParams);

% For example, you can use the calibration data to remove effects of lens distortion.
undistortedImage = undistortImage(originalImage, cameraParams);

% See additional examples of how to use the calibration data.  At the prompt type:
% showdemo('MeasuringPlanarObjectsExample')
% showdemo('StructureFromMotionExample')
