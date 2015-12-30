%Patrick Aubin
%North Sound Innovations, LLC
%Canary Medical IMU Metrics
%Created: 12/28/2015

%Revision History
%12/28/2015 - First version created. 


%Close all figures and clear MATLAB memory
close all
clear all
clc

filenames = ['C:\Users\ipaubin\Documents\NSI\Canary Medical\CHIRP Data 12-28-2015\IMU Data\Bosch Data Sets\S1 921S T1.txt'; %slow walking
            'C:\Users\ipaubin\Documents\NSI\Canary Medical\CHIRP Data 12-28-2015\IMU Data\Bosch Data Sets\S1 921S T3.txt';  %slow walking
            'C:\Users\ipaubin\Documents\NSI\Canary Medical\CHIRP Data 12-28-2015\IMU Data\Bosch Data Sets\S1 921S T4.txt';  %med walking
            'C:\Users\ipaubin\Documents\NSI\Canary Medical\CHIRP Data 12-28-2015\IMU Data\Bosch Data Sets\S1 921S T5.txt';  %med walking
            'C:\Users\ipaubin\Documents\NSI\Canary Medical\CHIRP Data 12-28-2015\IMU Data\Bosch Data Sets\S1 921S T6.txt';  %fast walking
            'C:\Users\ipaubin\Documents\NSI\Canary Medical\CHIRP Data 12-28-2015\IMU Data\Bosch Data Sets\S1 921S T7.txt'];  %fast walking
        
gyr_peak = zeros(2,3);% variable for peak angular velocities.  Columns are trials.  
acc_peak = zeros(2,3);% variable for the peak tibia acceleration. columns are trials.

for i=1:1 %for each filename.
    %Load IMU data from file and save into acc and gyr struct variables
    IMU = importdata(filenames(i,:), ',', 9); %comma delim, skip 9 header lines

    acc.x = IMU.data(:, 1); %m/s^2
    acc.y = IMU.data(:, 2); %m/s^2
    acc.z = IMU.data(:, 3); %m/s^2

    gyr.x=IMU.data(:, 10); %deg/s
    gyr.y=IMU.data(:, 11); %deg/s
    gyr.z=IMU.data(:, 12); %deg/s
    
    %Calculate peak sagittal plane angular velocity. 
    gyr_peak(i) = peakGyro(gyr.y);   
    
    

end

%Calculate peak acc of tibia
acc_mag = peakAcc([acc.x acc.y acc.z])

gyr_peak = [gyr_peak(1) gyr_peak(3) gyr_peak(5);
           gyr_peak(2) gyr_peak(4) gyr_peak(6);];

boxplot(gyr_peak, 'labels', {'Slow Walk' 'Medium Walk' 'Fast Walk'});
ylabel('Peak Sagittal Plane Angular Velocity (deg/s)');
ylim([0 500]);

figure
plot(acc.z);
xlabel('sample');
ylabel('Acceleration Z-axis');

figure
plot(gyr.y);
xlabel('sample');
ylabel('Gyro Y-axis');

figure
plot(acc_mag);
xlabel('sample');
ylabel('Acceleration Magnitude');
