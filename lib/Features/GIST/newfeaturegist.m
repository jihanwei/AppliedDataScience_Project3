addpath(genpath('.'));
 datasets = {'chicken', 'dog'};  % specify name of datasets
 c = conf();    % load the config structure
 dinfo = dir('.'); %make sure it is the clean data file
 names_cell = {dinfo.name};
 train_lists = {{names_cell{4}}, {names_cell{5}}};        % specify lists of train images, this line exists just because the toolbox cannot be run without train set, please ignore
test_lists = {{names_cell{4:1003}}, {names_cell{1004:2003}}};      % specify lists of test images
feature = 'gist';                                               % specify feature to use 
                                                       
 datasets_feature(datasets, train_lists, test_lists, feature, c);  % perform feature extraction
 train_features = load_feature(datasets{1}, feature, 'train', c);  % load train features ,no use

 test_features_1 = load_feature(datasets{1}, feature, 'test', c);    % load test features of chicken and dog
test_features_2 = load_feature(datasets{2}, feature, 'test', c);
csvwrite('chickf.csv',test_features_1 ); %save the csv, these two files need to be deleted manually if you want to rerun the code
csvwrite('dogf.csv',test_features_2 );