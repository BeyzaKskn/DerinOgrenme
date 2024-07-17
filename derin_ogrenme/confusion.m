% Test verilerini yükleyin
testData = imageDatastore('Alzheimer_s_Dataset\resized_test\', 'IncludeSubfolders', true, 'LabelSource', 'foldernames'); % test verilerinin dosya yolunu belirtin

trueLabels = testData.Labels; % Gerçek etiketleri alın
predictedLabels = classify(trainedNetwork_1, testData); % Tahmin edilen etiketleri alın

% Doğru tahmin sayısını hesaplayın
correctPredictions = sum(trueLabels == predictedLabels);

% Toplam veri sayısını alın
totalData = numel(trueLabels);

% Doğruluk oranını hesaplayın
accuracy = correctPredictions / totalData;

disp(['Doğruluk Oranı: ', num2str(accuracy)]);


% Konfüzyon matrisinin görselleştirilmesi
figure;
confusionchart(trueLabels,predictedLabels);
xlabel('Tahmin Edilen Etiketler');
ylabel('Gerçek Etiketler');
title('Konfüzyon Matrisi');