classdef app1 < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                        matlab.ui.Figure
        SINIFLabel                      matlab.ui.control.Label
        CNNvenEitimliAlarileAlzheimerHastalnnSnflandrlmasLabel  matlab.ui.control.Label
        Image                           matlab.ui.control.Image
        Label                           matlab.ui.control.Label
        OPTMZASYONALGORTMALARIDropDown  matlab.ui.control.DropDown
        OPTMZASYONALGORTMALARIDropDownLabel  matlab.ui.control.Label
        ADropDown                       matlab.ui.control.DropDown
        ADropDownLabel                  matlab.ui.control.Label
        SnflandrButton                  matlab.ui.control.Button
        ResimSeButton                   matlab.ui.control.Button
    end

    
    properties (Access = public)
        filepath; % Description
        image;
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: ResimSeButton
        function ResimSeButtonPushed(app, event)
            % Resim seçme işlemi
            [filename, app.filepath] = uigetfile({'*.jpg;*.png;*.bmp', 'Image Files (*.jpg, *.png, *.bmp)'}, 'Select an image file');
            image = fullfile(app.filepath, filename);
            %imshow(image, 'Parent', app.UIAxes);
            %app.image = imread(image);
            app.image = imread(image);
            app.Image.ImageSource = image; % Image bileşeninin kaynak dosyasını belirle
        end

        % Button pushed function: SnflandrButton
        function SnflandrButtonPushed(app, event)
            % Seçili model ve optimizasyon algoritması
            selectedModel = app.ADropDown.Value;
            selectedAlgorithm = app.OPTMZASYONALGORTMALARIDropDown.Value;
            
            % Seçilen modele göre eğitilmiş ağı yükle
            switch selectedModel
                case 'GoogLeNet'
                    switch selectedAlgorithm
                        case 'adam'
                            load('C:\Users\beyza\OneDrive\Masaüstü\Derin Öğrenme\derin\googlenet\train_adam_yuksek\googlenet_adam_yuksek.mat');
                        case 'sgdm'
                            load('C:\Users\beyza\OneDrive\Masaüstü\Derin Öğrenme\derin\googlenet\train_sgdm_yuksek\googlenet_sgdm_yuksek.mat');
                        case 'rmsprop'
                            load('C:\Users\beyza\OneDrive\Masaüstü\Derin Öğrenme\derin\googlenet\train_rmsprop_yuksek\googlenet_rmsprop_yuksek.mat');
                        otherwise
                            error('Geçersiz optimizasyon algoritması');
                    end
                case 'MobileNet-v2'
                    switch selectedAlgorithm
                        case 'adam'
                            load('C:\Users\beyza\OneDrive\Masaüstü\Derin Öğrenme\derin\mobilenetv2\train_adam_yuksek\mobilenet_adam_yuksek.mat');
                        case 'sgdm'
                            load('C:\Users\beyza\OneDrive\Masaüstü\Derin Öğrenme\derin\mobilenetv2\train_sgdm_yuksek\mobilenet_sgdm_yuksek.mat');
                        case 'rmsprop'
                            load('C:\Users\beyza\OneDrive\Masaüstü\Derin Öğrenme\derin\mobilenetv2\train_rmsprop_yuksek\mobilenet_rmsprop_yuksek.mat');
                        otherwise
                            error('Geçersiz optimizasyon algoritması');
                    end
                case 'MyCNN'
                    switch selectedAlgorithm
                        case 'adam'
                            load('C:\Users\beyza\OneDrive\Masaüstü\Derin Öğrenme\derin\mycnn\train_adam_yuksek\mycnn_adam_yuksek.mat');
                        case 'sgdm'
                            load('C:\Users\beyza\OneDrive\Masaüstü\Derin Öğrenme\derin\mycnn\train_sgdm_yuksek\mycnn_sgdm_yuksek.mat');
                        case 'rmsprop'
                            load('C:\Users\beyza\OneDrive\Masaüstü\Derin Öğrenme\derin\mycnn\train_rmsprop_yuksek\mycnn_rmsprop_yuksek.mat');
                        otherwise
                            error('Geçersiz optimizasyon algoritması');
                    end
                otherwise
                    error('Geçersiz model');
            end
            
            % Eğitilmiş ağı yükle
            %load(modelPath);
            %pretrainedNet = pretrainedNetStruct.net;
            %resim =imread(image);

            %[filename, app.filepath] = uigetfile({'*.jpg;*.png;*.bmp', 'Image Files (*.jpg, *.png, *.bmp)'}, 'Select an image file');
            %image = fullfile(app.filepath, filename);
            %imshow(image, 'Parent', app.UIAxes);
            %resim =imread(image);
            the_network = trainedNetwork_1;
            clc;
            %dir(string(classify(the_network, resim)));
            result = string(classify(the_network, app.image));
            app.Label.Text = result;
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Get the file path for locating images
            pathToMLAPP = fileparts(mfilename('fullpath'));

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [0.7059 0.7059 0.7216];
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'MATLAB App';

            % Create ResimSeButton
            app.ResimSeButton = uibutton(app.UIFigure, 'push');
            app.ResimSeButton.ButtonPushedFcn = createCallbackFcn(app, @ResimSeButtonPushed, true);
            app.ResimSeButton.FontName = 'Times New Roman';
            app.ResimSeButton.FontSize = 18;
            app.ResimSeButton.Position = [100 127 113 31];
            app.ResimSeButton.Text = 'Resim Seç';

            % Create SnflandrButton
            app.SnflandrButton = uibutton(app.UIFigure, 'push');
            app.SnflandrButton.ButtonPushedFcn = createCallbackFcn(app, @SnflandrButtonPushed, true);
            app.SnflandrButton.FontName = 'Times New Roman';
            app.SnflandrButton.FontSize = 18;
            app.SnflandrButton.Position = [438 127 117 31];
            app.SnflandrButton.Text = 'Sınıflandır';

            % Create ADropDownLabel
            app.ADropDownLabel = uilabel(app.UIFigure);
            app.ADropDownLabel.HorizontalAlignment = 'right';
            app.ADropDownLabel.FontName = 'Times New Roman';
            app.ADropDownLabel.FontSize = 14;
            app.ADropDownLabel.FontWeight = 'bold';
            app.ADropDownLabel.Position = [397 251 26 22];
            app.ADropDownLabel.Text = 'AĞ';

            % Create ADropDown
            app.ADropDown = uidropdown(app.UIFigure);
            app.ADropDown.Items = {'GoogLeNet', 'MobileNet-v2', 'MyCNN'};
            app.ADropDown.FontName = 'Times New Roman';
            app.ADropDown.FontSize = 14;
            app.ADropDown.Position = [438 251 117 22];
            app.ADropDown.Value = 'GoogLeNet';

            % Create OPTMZASYONALGORTMALARIDropDownLabel
            app.OPTMZASYONALGORTMALARIDropDownLabel = uilabel(app.UIFigure);
            app.OPTMZASYONALGORTMALARIDropDownLabel.HorizontalAlignment = 'right';
            app.OPTMZASYONALGORTMALARIDropDownLabel.FontName = 'Times New Roman';
            app.OPTMZASYONALGORTMALARIDropDownLabel.FontSize = 14;
            app.OPTMZASYONALGORTMALARIDropDownLabel.FontWeight = 'bold';
            app.OPTMZASYONALGORTMALARIDropDownLabel.Position = [294 180 129 34];
            app.OPTMZASYONALGORTMALARIDropDownLabel.Text = {'OPTİMİZASYON '; 'ALGORİTMALARI'};

            % Create OPTMZASYONALGORTMALARIDropDown
            app.OPTMZASYONALGORTMALARIDropDown = uidropdown(app.UIFigure);
            app.OPTMZASYONALGORTMALARIDropDown.Items = {'adam', 'sgdm', 'rmsprop'};
            app.OPTMZASYONALGORTMALARIDropDown.FontName = 'Times New Roman';
            app.OPTMZASYONALGORTMALARIDropDown.FontSize = 14;
            app.OPTMZASYONALGORTMALARIDropDown.Position = [438 192 117 22];
            app.OPTMZASYONALGORTMALARIDropDown.Value = 'adam';

            % Create Label
            app.Label = uilabel(app.UIFigure);
            app.Label.FontName = 'Times New Roman';
            app.Label.FontSize = 18;
            app.Label.FontWeight = 'bold';
            app.Label.Position = [400 80 202 24];
            app.Label.Text = '';

            % Create Image
            app.Image = uiimage(app.UIFigure);
            app.Image.Position = [42 168 229 147];
            app.Image.ImageSource = fullfile(pathToMLAPP, 'upload.png');

            % Create CNNvenEitimliAlarileAlzheimerHastalnnSnflandrlmasLabel
            app.CNNvenEitimliAlarileAlzheimerHastalnnSnflandrlmasLabel = uilabel(app.UIFigure);
            app.CNNvenEitimliAlarileAlzheimerHastalnnSnflandrlmasLabel.HorizontalAlignment = 'center';
            app.CNNvenEitimliAlarileAlzheimerHastalnnSnflandrlmasLabel.FontName = 'Times New Roman';
            app.CNNvenEitimliAlarileAlzheimerHastalnnSnflandrlmasLabel.FontSize = 24;
            app.CNNvenEitimliAlarileAlzheimerHastalnnSnflandrlmasLabel.FontWeight = 'bold';
            app.CNNvenEitimliAlarileAlzheimerHastalnnSnflandrlmasLabel.Position = [108 370 428 59];
            app.CNNvenEitimliAlarileAlzheimerHastalnnSnflandrlmasLabel.Text = {'CNN ve Ön Eğitimli Ağlar ile'; 'Alzheimer Hastalığının Sınıflandırılması'};

            % Create SINIFLabel
            app.SINIFLabel = uilabel(app.UIFigure);
            app.SINIFLabel.FontName = 'Times New Roman';
            app.SINIFLabel.FontSize = 18;
            app.SINIFLabel.FontWeight = 'bold';
            app.SINIFLabel.Position = [329 80 59 24];
            app.SINIFLabel.Text = 'SINIF:';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = app1

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end