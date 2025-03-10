function helperSpecSenseDownloadData(trainingDataSource,trainNow, ...
  useCapturedData,baseNetwork,imageSize)
%helperSpecSenseDownloadData Download data files
%   helperSpecSenseDownloadData(SRC,TRAIN,CAP,NET,SIZE) downloads data files
%   and trained networks used by the spectrum sensing for 5G and LTE
%   signals examples. If GEN is true, then training data is not downloaded.
%   If TRAIN is true, then trained networks are not downloaded. NET is the
%   base network and SIZE is the image size.

%   Copyright 2021-2023 The MathWorks, Inc.

downloadData = {};
if trainingDataSource == "Downloaded data"
  if isequal(imageSize, [128 128])
    downloadFileName = "SpectrumSensingTrainingData128x128.zip";
    expFileNames = [
      "license.txt"
      fullfile("TrainingData","128x128","NR_frame_103.png")
      fullfile("TrainingData","128x128","NR_frame_103.hdf")
      fullfile("TrainingData","128x128","LTE_NR","LTE_NR_frame_862.png")
      fullfile("TrainingData","128x128","LTE_NR","LTE_NR_frame_862.hdf")
      ];
  else
    downloadFileName = "SpectrumSensingTrainingData256x256.zip";
    expFileNames = [
      "license.txt"
      fullfile("TrainingData","256x256","LTE_frame_54.png")
      fullfile("TrainingData","256x256","LTE_frame_54.hdf")
      fullfile("TrainingData","256x256","LTE_NR","LTE_NR_frame_862.png")
      fullfile("TrainingData","256x256","LTE_NR","LTE_NR_frame_862.hdf")
      ];
  end
  downloadData{end+1} = struct("DownloadFile",downloadFileName, ...
    "ExpectedFiles",expFileNames);
end
if ~trainNow
  switch baseNetwork
    case "custom"
      downloadFileName = "SpectrumSensingTrainedCustom_2024.zip";
      expFileNames = [
        "license_semantic_segmentation_network.txt"
        "specSenseTrainedNetCustom.mat"
        ];
    case "resnet18"
      downloadFileName = "SpectrumSensingTrainedResnet18_2024.zip";
      expFileNames = [
        "license_semantic_segmentation_network.txt"
        "specSenseTrainedNetResnet18.mat"
        ];
    case "resnet50"
      downloadFileName = "SpectrumSensingTrainedResnet50_2024.zip";
      expFileNames = [
        "license_semantic_segmentation_network.txt"
        "specSenseTrainedNetResnet50.mat"
        ];
    case "mobilenetv2"
      downloadFileName = "SpectrumSensingTrainedMobileNetv2_2024.zip";
      expFileNames = "specSenseTrainedNetMobileNetv2.mat";
  end
  downloadData{end+1} = struct("DownloadFile",downloadFileName, ...
    "ExpectedFiles",expFileNames);
end
if useCapturedData
  if isequal(imageSize, [128 128])
    downloadFileName = "SpectrumSensingCapturedData128x128.zip";
    expFileNames = [
      "license.txt"
      fullfile("TrainingData","128x128","captured", ...
        "CF800MHz_BW200MHz_20230621151545934_frame_3.png")
      ];
  else
    downloadFileName = "SpectrumSensingCapturedData256x256.zip";
    expFileNames = [
      "license.txt"
      fullfile("TrainingData","256x256","captured", ...
        "CF800MHz_BW200MHz_20230621151545934_frame_3.png")
      ];
  end
  downloadData{end+1} = struct("DownloadFile",downloadFileName, ...
    "ExpectedFiles",expFileNames);
end

urlBase = "https://www.mathworks.com/supportfiles/spc/SpectrumSensing/";

dstFolder = pwd;

helperDownloadDataFile(urlBase, ...
  downloadData, ...
  dstFolder);
end

function helperDownloadDataFile(urlBase, downloadData, dstFolder)
%helperDownloadDataFile Download and uncompress data file from URL
%   helperDownloadDataFile(URL,DATAFILE,EXPFILES,DST) downloads and
%   uncompresses DATAFILE from URL to DST folder. EXPFILES is a list of
%   expected uncompressed files.

for p=1:length(downloadData)
  archive = downloadData{p}.DownloadFile;
  expFileNames = downloadData{p}.ExpectedFiles;
  url = urlBase + archive;
  
  [~, ~, fExt] = fileparts(archive);

  skipDownloadExtract = true;
  for q=1:length(expFileNames)
    tmpFileName = fullfile(dstFolder, expFileNames(q));
    if ~exist(tmpFileName, 'file')
      skipDownloadExtract = false;
      break
    end
  end

  if skipDownloadExtract
    disp("Files already exist. Skipping download and extract.")
  else
    fprintf("Starting download of data files from:\n\t%s\n", url)
    fileFullPath = matlab.internal.examples.downloadSupportFile('spc/SpectrumSensing',...
      archive);
    disp('Extracting files.')
    switch fExt
      case '.zip'
        unzip(fileFullPath, dstFolder);
      case '.tgz'
        untar(fileFullPath, dstFolder);
    end
    disp("Extract complete.")
  end
end
end