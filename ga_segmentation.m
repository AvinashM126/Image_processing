% MULTI-THRESHOLDING IMAGE SEGMENTATION USING GENETIC ALGORITHMS
pkg load image
pkg load statistics
clc;
% Default variables
n_population =  100;
n_iterations =  25;
n_bins       = 256;
n_thresholds =  5;
% Ratios of all GA operations
p_selection = 0.1;
p_crossover = 0.8;
p_mutation  = 0.1;
assert(sum([p_selection, p_crossover, p_mutation]) == 1, 'Total sum of proportions have to be 1!');
% Read image
image = imread("images/MRI-of-knee-Univ-Mich.tif");
%image = imread("images/tungsten.png");
disp("loading image");
% Convert image to gray levels
if (size(image, 3) == 3)
    image_gray = rgb2gray(image);
else
    image_gray = image;
endif
% Display image
figure(1),subplot(2,2,1),imshow(image),title('Original Image');
figure(1),subplot(2,2,2),imhist(image),title('Histogram');
% Initialization
population = initialization(n_population, n_bins, n_thresholds);
printf("Running algorithm");
for i = 1:n_iterations
    new_population = [];
    printf(".");
    % Evaluation of fitness
    ranking = fitness(image, population, n_thresholds);
    %% Reproduction
    % Selection
    % TODO create more strategies (like roulette wheel)
    new_population = first_best(ranking, population, p_selection, new_population);
    % Crossover
    new_population = crossover(population, p_crossover, new_population);
    % Mutation
    new_population = mutation(population, p_mutation, new_population);
    population = new_population;
endfor
% Accepting the solution
accept_solution(image_gray, population, n_thresholds);