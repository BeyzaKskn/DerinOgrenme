% Resimlerin bulunduğu klasör
resim_klasoru = 'Matlab/train';

% Yeniden boyutlandırılmış resimlerin kaydedileceği klasör
yeniden_boyutlanmis_klasor = 'Matlab/Alzheimer_s_Dataset/resized_train';

% Yeniden boyutlandırma boyutları
yeniden_boyut = [128, 128];

% Klasörü oluşturma
if ~exist(yeniden_boyutlanmis_klasor, 'dir')
    mkdir(yeniden_boyutlanmis_klasor);
end

% Yeniden boyutlandırma işlemi
klasorler = dir(resim_klasoru);
for i = 1:numel(klasorler)
    if klasorler(i).isdir && ~strcmp(klasorler(i).name, '.') && ~strcmp(klasorler(i).name, '..')
        klasor_adi = klasorler(i).name;
        yeni_klasor_yolu = fullfile(yeniden_boyutlanmis_klasor, klasor_adi);
        if ~exist(yeni_klasor_yolu, 'dir')
            mkdir(yeni_klasor_yolu);
        end
        dosyalar = dir(fullfile(resim_klasoru, klasor_adi, '*.jpg')); % veya *.png, *.jpeg gibi uygun dosya uzantılarına göre değiştirin
        for j = 1:numel(dosyalar)
            resim_yolu = fullfile(resim_klasoru, klasor_adi, dosyalar(j).name);
            resim = imread(resim_yolu);
            yeniden_boyutlanmis_resim = imresize(resim, yeniden_boyut);
            yeni_resim_yolu = fullfile(yeni_klasor_yolu, dosyalar(j).name);
            imwrite(yeniden_boyutlanmis_resim, yeni_resim_yolu);
        end
    end
end

disp('Tüm resimler başarıyla yeniden boyutlandırıldı ve kaydedildi.');