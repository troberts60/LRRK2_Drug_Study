LRRK2 Drug Study

Introduction:
	This project attempts to create a machine learning model that can be used to find possible drug therapies for the 
LRRK2(Leucine Rich Repeat Kinase) protein. LRRK2 is a protein that has been linked to Parkinson's Disease and is believed 
that over activation of the kinase leads to production of alpha-synuclein which is found in patients with Parkinson's 
Disease. Therefore, finding new drugs that could possibly inhibit LRRK2 is an interesting area of study and creating a
machine learning model that can take new or existing drugs and predict if they could have an effect on LRRK2 can be useful
in finding new therapies.
	This project was done in Google Colab, which is based on the Jupyter Notebook open source software. The primary 
coding language used for this project was Python. Python was the ideal programming language for this project because it
has several libraries that can be used for machine learning, such as the panda library. Google Colab was used because its
connection to the cloud allowed for easier changes to the Python environment. For example, the project requried the use of
the Conda environment and Google Colab made it easy to download the libraries needed for the environment. There is also an
Rstudio script as well that was used to analyze the Lipinski data.

LRRK2_Data_Prep:
- The first part of the project was to download information from the ChEMBL database. The ChEMBL database has a collection
of drugs that have bioactivity information to certain proteins and I was able to search for known drugs that have
interacted with the LRRK2 protein.
- I was able to find a total of 2000 molecules that have documented interactions with LRRK2 in humans. I then cleaned the 
data by dropping any NA values and any duplicates based on the Canonical Smiles. The Canonical Smiles is the 1D molecular
formation of a molecule. I also selected for standard types of IC50. IC50 displays a standard value that shows the
concentration of a drug that inhibits half of the target protein. Therefore, lower IC50 scores represent a stronger
interaction because lower concentrations of the drug inhibits the target protein. By the end, I had 1204 molecules
- Next I based each molecule if it was active, intermediate or inactive based on the IC50 standard value. After doing 
research on kinases, I chose an active score of 100 or less and an inactive score of 300 or greater. In between 100 and
300 would represent intermediate interaction. I attached the active, intermediate and inactive to the final data frame
for further study

LRRK2_Lipinski:
- First, I had to download the rdkit library from Conda in order to calculate the Lipinski Descriptors for the drugs.
Lipinski Descriptors take a look at the molecules molecular weight, solubility, Hydrogen acceptors and Hydrogen donors
to form a basic knowledge of how well a molecule could be used for drug therapy.
- I created a function that found the Lipkinski Descriptors for every molecule and I attached it to the data frame that
was created in the Data_Prep section
- Next, I did some data transformation by chaning the IC50 scores into pIC50 scores, which is the negative log of 10^-9
of the standard scores. This changed the scores so that all active drugs had a pIC50 score of at least 7 and the inactives
had a pIC50 score of no greater than 6.52. I dropped the standard value and added the pIC50 value to the data frame and 
this was used in the LRRK2_Fingerpring_ML
- Then I removed the intermediate molecules from the data frame and created a bar graph to show how many active vs inactive
drugs in the data frame. Also I created boxplots that show the Lipinski Descriptors of the active and inactive molecules
- I used an Rstudio script to show the Wilcox test between each Lipinski Descriptor and the if it was active or inactive
in order to statistically show which Descriptor correlated to whether the molecule was active or inactive. The Wilcox test
showed that each descriptor had a significant effect (p < 0.05) on the beging active or inactive
- Finally, just to add to the Wilcox test, I created a Logit model that showed that each Descriptor correlated to how the
molecule interacts with LRRK2. Also, I used the model to create predicted values and compared it the expermental values
and showed that the model was roughly 76% accurate.
- In order to run the LRRK2_Lipinski program, you just need the "lrrk2_preprocessed_data.csv" obtained from the Data_Prep.
For the Rstudio script, you just need to download "lrrk2_stat_data.csv" into Rstudio.

LRRK2_Fingerprint_ML:
- This part creates a different machine learning model that focuses on the Pubchem molecular fingerprints. The Lipinski
Descriptors give an overall view of the molecule where the Pubchem fingerprints show an in depth view of the interactions
of molecules.
- The first part was to download an open source software called PaDEL-Descriptor which calculates the Pubchem fingerprints.
I used the github from a dataprofessor to obtain this software.
- I calculated the fingerprints from each molecule with the pIC50 value that was created in LRRK2_Lipinski. The PaDEL
software takes the chem id and the SMILES notation to calculate the fingerprints. Once all the fingerprints were calculated 
the pIC50 value was attached to the fingerpint data frame.
- For this, I used the Random Forest Model because there are 881 different Pubchem fingerprints calculated for each
molecule so I couldn't use the Logit model done in the previous experiment. I downloaded the necessary libraries for the
Random Forest Model. Next, I removed the fingerpints that had a low varience, meaning they didn't differ much between each
molecule, to make the model run smoother.
- I created an 80:20 train:test ratio and found that the model has an r-squared value of 0.52, which shows that the model
is moderately effective at predicting if a molecule interacts with LRRK2
- In order to run this all you need is the "lrrk2_ml_data.csv" data set.

      