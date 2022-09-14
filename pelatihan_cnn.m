clc; clear; close all; warning off all;

%%%% Setengah Matang
% menetapkan nama folder citra
nama_folder = 'Data Latih\Setengah Matang';
% membaca nama file yang berekstensi .jpg
nama_file = dir(fullfile(nama_folder,'*.jpg'));
% membaca jumlah file
jumlah_mengkal = numel(nama_file);
% menginisialisasi variabel Img_mengkal
Img_mengkal = zeros(28,28,3,jumlah_mengkal);
% melakukan pengolahan citra terhadap masing-masing file
for n = 1:jumlah_mengkal
    % membaca citra rgb
    Img = im2double(imread(fullfile(nama_folder,nama_file(n).name)));
    % cropping
    [height, width] = size(Img);
    size_x = floor(height / 2);
    size_y = floor(width / 10);
    targetSize = [size_x size_y];
    win1 = centerCropWindow2d(size(Img),targetSize);
    Img = imcrop(Img,win1);
    % melakukan konversi ke hsv daan resizing citra
    Img_rsz = imresize(rgb2hsv(Img),[28 28]);
    % menyusun matriks Img_mengkal
    Img_mengkal(:,:,:,n) = Img_rsz;
end

%%%% Terlalu Matang
% menetapkan nama folder citra
nama_folder = 'Data Latih\Terlalu Matang';
% membaca nama file yang berekstensi .jpg
nama_file = dir(fullfile(nama_folder,'*.jpg'));
% membaca jumlah file
jumlah_busuk = numel(nama_file);
% menginisialisasi variabel Img_busuk
Img_busuk = zeros(28,28,3,jumlah_busuk);
% melakukan pengolahan citra terhadap masing-masing file
for n = 1:jumlah_busuk
    % membaca citra rgb
    Img = im2double(imread(fullfile(nama_folder,nama_file(n).name)));
    % cropping
    [height, width] = size(Img);
    size_x = floor(height / 2);
    size_y = floor(width / 10);
    targetSize = [size_x size_y];
    win1 = centerCropWindow2d(size(Img),targetSize);
    Img = imcrop(Img,win1);
    % melakukan konversi ke hsv daan resizing citra
    Img_rsz = imresize(rgb2hsv(Img),[28 28]);
    % menyusun matriks Img_busuk
    Img_busuk(:,:,:,n) = Img_rsz;
end

%%%% Matang
% menetapkan nama folder citra
nama_folder = 'Data Latih\Matang';
% membaca nama file yang berekstensi .jpg
nama_file = dir(fullfile(nama_folder,'*.jpg'));
% membaca jumlah file
jumlah_matang = numel(nama_file);
% menginisialisasi variabel Img_matang
Img_matang = zeros(28,28,3,jumlah_matang);
% melakukan pengolahan citra terhadap masing-masing file
for n = 1:jumlah_matang
    % membaca citra rgb
    Img = im2double(imread(fullfile(nama_folder,nama_file(n).name)));
    % cropping
    [height, width] = size(Img);
    size_x = floor(height / 2);
    size_y = floor(width / 10);
    targetSize = [size_x size_y];
    win1 = centerCropWindow2d(size(Img),targetSize);
    Img = imcrop(Img,win1);
    % melakukan konversi ke hsv daan resizing citra
    Img_rsz = imresize(rgb2hsv(Img),[28 28]);
    % menyusun matriks Img_matang
    Img_matang(:,:,:,n) = Img_rsz;
end

%%%% Mentah
% menetapkan nama folder citra
nama_folder = 'Data Latih\Mentah';
% membaca nama file yang berekstensi .jpg
nama_file = dir(fullfile(nama_folder,'*.jpg'));
% membaca jumlah file
jumlah_mentah = numel(nama_file);
% menginisialisasi variabel Img_mentah
Img_mentah = zeros(28,28,3,jumlah_mentah);
% melakukan pengolahan citra terhadap masing-masing file
for n = 1:jumlah_mentah
    % membaca citra rgb
    Img = im2double(imread(fullfile(nama_folder,nama_file(n).name)));
    % cropping
    [height, width] = size(Img);
    size_x = floor(height / 2);
    size_y = floor(width / 10);
    targetSize = [size_x size_y];
    win1 = centerCropWindow2d(size(Img),targetSize);
    Img = imcrop(Img,win1);
    % melakukan konversi ke hsv daan resizing citra
    Img_rsz = imresize(rgb2hsv(Img),[28 28]);
    % menyusun matriks Img_mentah
    Img_mentah(:,:,:,n) = Img_rsz;
end

%% 24layer
layers = [ ...
    imageInputLayer([28 28 3])  
    convolution2dLayer(3,8,'Padding','same')
    batchNormalizationLayer
    reluLayer   
    maxPooling2dLayer(2,'Stride',2)
    convolution2dLayer(3,16,'Padding','same')
    batchNormalizationLayer
    reluLayer   
    maxPooling2dLayer(2,'Stride',2)
    convolution2dLayer(3,32,'Padding','same')
    batchNormalizationLayer
    reluLayer   
    maxPooling2dLayer(2,'Stride',2)
    convolution2dLayer(3,64,'Padding','same')
    batchNormalizationLayer
    reluLayer   
    fullyConnectedLayer(32)
    reluLayer   
    fullyConnectedLayer(16)
    reluLayer   
    fullyConnectedLayer(8)
    fullyConnectedLayer(4)
    softmaxLayer
    classificationLayer ];

%% 15 layer
% Define the convolutional neural network architecture.
% layers=[
%     imageInputLayer([28 28 3]);
%     convolution2dLayer(3,16,'Padding','same')
%     maxPooling2dLayer(3,'Stride',2);
%     reluLayer();
%     convolution2dLayer(3,32,'Padding','same')
%     reluLayer();
%     averagePooling2dLayer(3,'Stride',2);
%     convolution2dLayer(3,64,'Padding','same');
%     reluLayer();
%     averagePooling2dLayer(3,'Stride',2);
%     fullyConnectedLayer(256)
%     reluLayer();
%     fullyConnectedLayer(4)
%     softmaxLayer()
%     classificationLayer()
% ];

%% 8layer
% layers = [
%     imageInputLayer([20 20 3]) % 20X20X3 refers to number of features per sample
%     convolution2dLayer(3,16,'Padding','same')
%     reluLayer
%     fullyConnectedLayer(384) % 384 refers to number of neurons in next FC hidden layer
%     fullyConnectedLayer(384) % 384 refers to number of neurons in next FC hidden layer
%     fullyConnectedLayer(4)   % 4 refers to number of neurons in next output layer (number of output classes)
%     softmaxLayer
%     classificationLayer];

% menetapkan nilai2 parameter CNN
max_epoch = 200;
minibatch = 128;
learn_rate = 0.01;
momentum = 0.95;

options = trainingOptions('sgdm',...
    'InitialLearnRate',learn_rate,...
    'MaxEpochs',max_epoch,...
    'MiniBatchSize',minibatch,...
    'Momentum',momentum,...
    'Verbose',false,...
    'Plots','training-progress');

% menggabungkan citra pada masing2 kelas
Img_pisang = cat(4,Img_busuk,Img_matang,Img_mengkal,Img_mentah);

% men-setting nilai target (1=busuk, 2=matang, 3=mengkal, 4=mentah)
target_busuk = 1*ones(1,jumlah_busuk);
target_matang = 2*ones(1,jumlah_matang);
target_mengkal = 3*ones(1,jumlah_mengkal);
target_mentah = 4*ones(1,jumlah_mentah);
target_pisang = categorical([target_busuk,target_matang,target_mengkal,target_mentah]);

% proses pelatihan CNN
net = trainNetwork(Img_pisang,target_pisang,layers,options);
predictedLabels = classify(net,Img_pisang);

% menghitung nilai akurasi
train_acc = (sum(predictedLabels==target_pisang')/length(predictedLabels))*100;
disp(['Training Accuracy : ',num2str(train_acc),' %'])

% menyimpan jaringan CNN
save net net