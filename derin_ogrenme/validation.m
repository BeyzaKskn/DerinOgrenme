% Train ve validation klasörlerinin yolları
train_klasoru = 'train';
validation_klasoru = 'validation';

% Eğer validation klasörü yoksa oluştur
if ~exist(validation_klasoru, 'dir')
    mkdir(validation_klasoru);
end

% Train klasöründeki klasörleri listele
klasorler = dir(train_klasoru);

% Her bir sınıf için %20'sini validation klasörüne taşı
for i = 1:numel(klasorler)
    if klasorler(i).isdir && ~strcmp(klasorler(i).name, '.') && ~strcmp(klasorler(i).name, '..')
        klasor_adi = klasorler(i).name;
        train_klasor_yolu = fullfile(train_klasoru, klasor_adi);
        validation_klasor_yolu = fullfile(validation_klasoru, klasor_adi);
        if ~exist(validation_klasor_yolu, 'dir')
            mkdir(validation_klasor_yolu);
        end
        
        % Train klasöründeki resimleri al ve %20'sini validation klasörüne taşı
        dosyalar = dir(fullfile(train_klasor_yolu, '*.jpg')); % veya *.png, *.jpeg gibi uygun dosya uzantılarına göre değiştirin
        for j = 1:numel(dosyalar)
            if rand < 0.2 % %20 olasılıkla
                resim_yolu = fullfile(train_klasor_yolu, dosyalar(j).name);
                hedef_yol = fullfile(validation_klasor_yolu, dosyalar(j).name);
                movefile(resim_yolu, hedef_yol); % Resmi taşı
            end
        end
    end
end

disp('Train klasöründen validation klasörüne %20 oranında resim taşındı.');