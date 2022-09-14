clc; clear; close all; warning off all;

%%%% Terlalu Matang
% menetapkan nama folder citra
nama_folder = 'Data Uji\Terlalu Matang';
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
nama_folder = 'Data Uji\Matang';
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

%%%% Setengah Matang
% menetapkan nama folder citra
nama_folder = 'Data Uji\Setengah Matang';
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

%%%% Mentah
% menetapkan nama folder citra
nama_folder = 'Data Uji\Mentah';
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

% menggabungkan citra pada masing2 kelas
Img_pisang = cat(4,Img_busuk,Img_matang,Img_mengkal,Img_mentah);

% men-setting nilai target (1=busuk, 2=matang, 3=mengkal, 4=mentah)
target_busuk = 1*ones(1,jumlah_busuk);
target_matang = 2*ones(1,jumlah_matang);
target_mengkal = 3*ones(1,jumlah_mengkal);
target_mentah = 4*ones(1,jumlah_mentah);
target_pisang = categorical([target_busuk,target_matang,target_mengkal,target_mentah]);

% proses pengujian CNN
load net
predictedLabels = classify(net,Img_pisang);

% menghitung nilai akurasi
test_acc = (sum(predictedLabels==target_pisang')/length(predictedLabels))*100;
disp(['Testing Accuracy : ',num2str(test_acc),' %'])


% export to xlsx

data = ["Nama File", "R", "G", "B", "H", "S", "V", "Keterangan Klasifikasi", "status"];
total_rows = length(target_pisang);

%%%% Terlalu Matang
% menetapkan nama folder citra
nama_folder = 'Data Uji\Terlalu Matang';
% membaca nama file yang berekstensi .jpg
nama_file = dir(fullfile(nama_folder,'*.jpg'));
% membaca jumlah file
jumlah_busuk = numel(nama_file);

for n = 1:jumlah_busuk
    % membaca citra rgb
    Img = im2double(imread(fullfile(nama_folder,nama_file(n).name)));
    R = Img(:,:,1);
    G = Img(:,:,2);
    B = Img(:,:,3);

    % menghitung nilai rata2 masing2 komponen
    Red = mean(R(:));
    Green = mean(G(:));
    Blue = mean(B(:));

    % Convert RGB to HSV
    hsvImage = rgb2hsv(Img);
    hImage = hsvImage(:, :, 1);
    sImage = hsvImage(:, :, 2);
    vImage = hsvImage(:, :, 3);

    hHist = mean(hImage(:));
    sHist = mean(sImage(:));
    vHist = mean(vImage(:));

    file_name=fullfile(nama_folder,nama_file(n).name);
    
    predictedLabel = predictedLabels(n);
    
    switch predictedLabel
        case '1'
            kelas_keluaran = "Terlalu Matang";
        case '2'
            kelas_keluaran = "Matang";
        case '3'
            kelas_keluaran = "Setengah Matang";
        case '4'
            kelas_keluaran = "Mentah";
        otherwise
            kelas_keluaran = "Tidak Dikenali";
    end

     if(predictedLabel == '1')
        status =  "Benar";
    else 
        status = "Salah"; 
     end

    data_temp = [file_name, Red, Green, Blue, hHist, sHist, vHist, kelas_keluaran, status];
    disp(data_temp);
    data = [data; data_temp];
end

%%%% Matang
% menetapkan nama folder citra
nama_folder = 'Data Uji\Matang';
% membaca nama file yang berekstensi .jpg
nama_file = dir(fullfile(nama_folder,'*.jpg'));
% membaca jumlah file
jumlah_matang = numel(nama_file);
jumlah_keseluruhan = jumlah_busuk;

for n = 1:jumlah_matang
    % membaca citra rgb
    Img = im2double(imread(fullfile(nama_folder,nama_file(n).name)));
    R = Img(:,:,1);
    G = Img(:,:,2);
    B = Img(:,:,3);

    % menghitung nilai rata2 masing2 komponen
    Red = mean(R(:));
    Green = mean(G(:));
    Blue = mean(B(:));

    % Convert RGB to HSV
    hsvImage = rgb2hsv(Img);
    hImage = hsvImage(:, :, 1);
    sImage = hsvImage(:, :, 2);
    vImage = hsvImage(:, :, 3);

    hHist = mean(hImage(:));
    sHist = mean(sImage(:));
    vHist = mean(vImage(:));

    file_name=fullfile(nama_folder,nama_file(n).name);
    
    predictedLabel = predictedLabels(n+jumlah_keseluruhan);
    
    switch predictedLabel
        case '1'
            kelas_keluaran = "Terlalu Matang";
        case '2'
            kelas_keluaran = "Matang";
        case '3'
            kelas_keluaran = "Setengah Matang";
        case '4'
            kelas_keluaran = "Mentah";
        otherwise
            kelas_keluaran = "Tidak Dikenali";
    end

    if(predictedLabel == '2')
        status =  "Benar";
    else 
        status = "Salah"; 
    end

    data_temp = [file_name, Red, Green, Blue, hHist, sHist, vHist, kelas_keluaran, status];
    disp(data_temp);
    data = [data; data_temp];
end

%%%% Setengah Matang
% menetapkan nama folder citra
nama_folder = 'Data Uji\Setengah Matang';
% membaca nama file yang berekstensi .jpg
nama_file = dir(fullfile(nama_folder,'*.jpg'));
% membaca jumlah file
jumlah_mengkal = numel(nama_file);
jumlah_keseluruhan = jumlah_busuk + jumlah_matang;

for n = 1:jumlah_mengkal
    % membaca citra rgb
    Img = im2double(imread(fullfile(nama_folder,nama_file(n).name)));
    R = Img(:,:,1);
    G = Img(:,:,2);
    B = Img(:,:,3);

    % menghitung nilai rata2 masing2 komponen
    Red = mean(R(:));
    Green = mean(G(:));
    Blue = mean(B(:));

    % Convert RGB to HSV
    hsvImage = rgb2hsv(Img);
    hImage = hsvImage(:, :, 1);
    sImage = hsvImage(:, :, 2);
    vImage = hsvImage(:, :, 3);

    hHist = mean(hImage(:));
    sHist = mean(sImage(:));
    vHist = mean(vImage(:));

    file_name=fullfile(nama_folder,nama_file(n).name);
    
    predictedLabel = predictedLabels(n+jumlah_keseluruhan);
    
    switch predictedLabel
        case '1'
            kelas_keluaran = "Terlalu Matang";
        case '2'
            kelas_keluaran = "Matang";
        case '3'
            kelas_keluaran = "Setengah Matang";
        case '4'
            kelas_keluaran = "Mentah";
        otherwise
            kelas_keluaran = "Tidak Dikenali";
    end

    if(predictedLabel == '3')
        status =  "Benar";
    else 
        status = "Salah"; 
    end

    data_temp = [file_name, Red, Green, Blue, hHist, sHist, vHist, kelas_keluaran, status];
    disp(data_temp);
    data = [data; data_temp];
end

%%%% Mentah
% menetapkan nama folder citra
nama_folder = 'Data Uji\Mentah';
% membaca nama file yang berekstensi .jpg
nama_file = dir(fullfile(nama_folder,'*.jpg'));
% membaca jumlah file
jumlah_mengkal = numel(nama_file);
jumlah_keseluruhan = jumlah_busuk + jumlah_matang + jumlah_mengkal;

for n = 1:jumlah_mengkal
    % membaca citra rgb
    Img = im2double(imread(fullfile(nama_folder,nama_file(n).name)));
    R = Img(:,:,1);
    G = Img(:,:,2);
    B = Img(:,:,3);

    % menghitung nilai rata2 masing2 komponen
    Red = mean(R(:));
    Green = mean(G(:));
    Blue = mean(B(:));

    % Convert RGB to HSV
    hsvImage = rgb2hsv(Img);
    hImage = hsvImage(:, :, 1);
    sImage = hsvImage(:, :, 2);
    vImage = hsvImage(:, :, 3);

    hHist = mean(hImage(:));
    sHist = mean(sImage(:));
    vHist = mean(vImage(:));

    file_name=fullfile(nama_folder,nama_file(n).name);
    
    predictedLabel = predictedLabels(n+jumlah_keseluruhan);
    
    switch predictedLabel
        case '1'
            kelas_keluaran = "Terlalu Matang";
        case '2'
            kelas_keluaran = "Matang";
        case '3'
            kelas_keluaran = "Setengah Matang";
        case '4'
            kelas_keluaran = "Mentah";
        otherwise
            kelas_keluaran = "Tidak Dikenali";
    end

    if(predictedLabel == '4')
        status =  "Benar";
    else 
        status = "Salah"; 
    end

    data_temp = [file_name, Red, Green, Blue, hHist, sHist, vHist, kelas_keluaran, status];
    disp(data_temp);
    data = [data; data_temp];
end

recycle on % Send to recycle bin instead of permanently deleting.
file = 'Data-Pisang.xlsx';
delete(file);

xlswrite('Data-Pisang.xlsx',[data]);
