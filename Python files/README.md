This folder contains of 3 Jupyter Notebooks:
1. "models testing"
2. "inductive transfer learning training"
3. "transductive transfer learning application"

All of these notebooks has the same data preprocessing techniques, training and evaluation functions. All of them uses ResNet-101 as the encoder.


"models testing" notebook consists of various segmentation models such as PSPNet, U-Net, DeepLabV3+ and SegFormer. 
Most of these can be easily applied by this high-level API library: https://github.com/qubvel-org/segmentation_models.pytorch


"inductive transfer learning training" notebook uses the best-performing model determined by "model testing" notebook, and will then perform some hyperparameter tuning
and have the training function configuration efficiently finetuned using the Optuna framework. 3 types of analyses (Performance, Interpretability and Classification)
will be performed to evaluate and understand the model. The model architecture and weights will be saved for transductive adoption.


"transductive transfer learning application" notebook uses the saved inductive model architecture and weights on a new dataset: "UnkownScenariosDataset". 
This is done to evaluate the inductive model's performance on a variant of the trained dataset that introduces new interferences, fadings and wider signal parameter ranges (SNR and Doppler shift).
The inductive model's ResNet-101 encoder, which was trained on the original TrainingData", will be frozen while the DeepLabV3+ decoder will be unfrozen with limited training parameters.
This is done to test out the pretrained encoder's feature extraction ability on a new, unseen but related dataset. 
Similar finetuning and analyses as the "inductive transfer learning training" notebook, was done to understand this hybrid model's strengths and weaknesses.

