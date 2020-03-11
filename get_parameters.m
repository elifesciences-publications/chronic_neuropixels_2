% GET_PARAMETERS Returns a structure with the parameters for analyses for
% the manuscript, such as file paths
%
%=OUTPUT
%
%   P
%       A structure with parameters for analyses
%
function P = get_parameters()
%% paths
P.repository_path = fileparts(mfilename('fullpath'));
P.rat_info_path =               [P.repository_path filesep 'behavioral_performance' filesep 'rat_info.csv'];
P.behavior_table_path =         [P.repository_path filesep 'behavioral_performance' filesep 'behavior_table.csv'];
P.recording_sessions_path =     [P.repository_path filesep 'behavioral_performance' filesep 'recording_sessions.csv'];
P.performance_by_session_path = [P.repository_path filesep 'behavioral_performance' filesep 'performance_by_session.csv'];
P.performance_by_rat_path =     [P.repository_path filesep 'behavioral_performance' filesep 'performance_by_rat.csv'];
P.behavior_plots_folder =       [P.repository_path filesep 'behavioral_performance' filesep 'plots'];
P.opto_ephys_log_path =         [P.repository_path filesep 'behavioral_performance' filesep 'Opto-ephys log.xlsx'];
P.pharmacology_log_path =       [P.repository_path filesep 'behavioral_performance' filesep 'Pharmacology log.xlsx'];
P.gain_noise_fldr_path =        [P.repository_path filesep 'gain_noise'];
P.gain_noise_log_path =         [P.gain_noise_fldr_path filesep 'gain_noise_log.csv'];
P.gain_noise_data_path = 'X:\RATTER\PhysData\NP_gain_noise\';

%% plotting formats
P.figure_image_format = {'png', 'svg'};
P.figure_position_psychometrics = [rand*1000, rand*1000, 250, 250];
P.figure_position_behavioral_comparison = [rand*1000, rand*1000, 250, 250];
P.figure_position_gn = [rand*1000, rand*1000, 350, 250];
P.figure_position_gn_summary = [rand*1000, rand*1000, 250, 250];
P.axes_properties_behavior = {'FontSize', 14, ...
                             'Color', 'none', ...
                             'TickDir', 'Out',...
                             'Nextplot', 'add', ...
                             'LineWidth', 1,...
                             'XColor', [0,0,0], ...
                             'YColor', [0,0,0], ...
                             'LabelFontSizeMultiplier', 1};
P.custom_axes_properties.trials_done = {'XScale', 'log', ...
                                        'YScale', 'log', ...
                                        'XLim', [100, 2e3], ...
                                        'YLim', [100, 2e3]};
P.custom_axes_properties.abs_bias = {'XScale', 'log', ...
                                        'YScale', 'log', ...
                                        'XLim', [0.05, 15], ...
                                        'YLim', [0.05, 15], ...
                                        'XTick', [0.1, 1, 10], ...
                                        'YTick', [0.1, 1, 10]};
P.custom_axes_properties.sens = {'XLim', [0, 0.3], ...
                                        'YLim', [0, 0.3]};
P.color_order = 1/255 *  [230,  25,  75; ...
                               60, 180,  75; ...
                              255, 225,  25; ...
                                0, 130, 200; ...
                              245, 130,  48; ...
                              145,  30, 180; ...
                               70, 240, 240; ...
                              240,  50, 230; ...
                              210, 245,  60; ...
                              250, 190, 190; ...
                                0, 128, 128; ...
                              230, 190, 255; ...
                              170, 110,  40; ...
                              255, 250, 200; ...
                              128,   0,   0; ...
                              170, 255, 195; ...
                              128, 128,   0; ...
                              255, 215, 180; ...
                                0,   0, 128];
P.color_order = repmat(P.color_order, 10, 1);
%% analyses
P.noise_threshold_uV = 20;
P.gain_noise_example = 'gain_noise_17131311352_2019_10_09';