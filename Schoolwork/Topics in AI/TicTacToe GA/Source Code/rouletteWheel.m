function choice = rouletteWheel(weights)
% ---------------------------------------------------------
% Roulette Wheel Selection Algorithm. A set of weights
% represents the probability of selection of each
% individual in a group of choices. It returns the index
% of the chosen individual.
% Usage example:
% rouletteWheel ([1 5 3 15 8 1])
%    most probable result is 4 (weights 15)
% www.playmedusa.com/blog/2011/01/11/roulette-wheel-selection-algorithm-in-matlab-2/
% ---------------------------------------------------------
  accumulation = cumsum(weights);
  p = rand() * accumulation(end);
  chosen_index = -1;
  for index = 1 : length(accumulation)
    if (accumulation(index) > p)
      chosen_index = index;
      break;
    end
  end
  choice = chosen_index;
end