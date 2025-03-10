imageSize = {[128 128]};    % pixels
sampleRate = 61.44e6;     % Hz
numSubFrames = 40;        % corresponds to 40 ms
frameDuration = numSubFrames*1e-3;    % seconds
trainDirRoot = fullfile(pwd,"UnkownScenariosData");
classNames = ["Noise" "NR" "LTE" "Unknown"];
trainingDataSource = "Generated data";
trainNow = false;
useCapturedData = true;
if trainingDataSource == "Generated data"
  numFramesPerStandard = 1050;
  saveChannelInfo = true;
  helperSpecSenseTrainingData(numFramesPerStandard,classNames,imageSize, ...
      trainDirRoot,numSubFrames,sampleRate,saveChannelInfo);
end