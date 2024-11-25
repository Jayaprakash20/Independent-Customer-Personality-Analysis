# Independent-Customer-Personality-Analysis
## Overview  
This repository houses the analysis and implementation for the **Customer Personality Analysis** project. The goal is to optimize marketing strategies by identifying and targeting specific customer segments based on attributes like marital status, education levels, income, and spending behavior. Insights were derived from an open-source Kaggle dataset.

## Project Files  
- **Analysis Presentation** (`Personal Project - CPA.pptx`):  
  A PowerPoint presentation summarizing the findings, visualizations, and recommendations.  
- **R Code** (`Personal Project - CPA.R`):  
  The implementation of the analysis, including data cleaning, visualization, and key statistical insights.

## Dataset  
The dataset used in this project is sourced from Kaggle:  
[Customer Personality Analysis Dataset](https://www.kaggle.com/datasets/imakash3011/customer-personality-analysis).  

It contains customer information to help businesses gain deeper insights into customer profiles and design targeted marketing strategies. Key fields include:  
- **Income**: Annual income of customers.  
- **Education**: Highest educational qualification.  
- **Web Purchases**: Frequency of online purchases.  
- **Spending**: Patterns in spending across product categories.  
- **Marital Status**: Demographic segmentation.

## Key Insights  
1. **Income vs. Web Purchases**: Positive correlation; customers with higher incomes tend to make more web purchases.  
2. **Education Impact**: Graduates are the most consistent online shoppers, showing significant spending patterns.  
3. **Spending Habits**: Spending increases with higher education levels and income brackets.  
4. **Gold Purchases**: Consistently observed among married, single, and "together" status groups, aged 25–80 years.  

These insights guide targeted marketing strategies, including personalized offers and cross-selling high-value products.

## Usage Instructions  
1. **Prerequisites**:  
   - Install R (latest version).  
   - Required libraries: `ggplot2`, `dplyr`, `readr`.  

2. **Steps to Run**:  
   - Clone the repository:  
     ```bash
     git clone https://github.com/your-username/customer-personality-analysis.git
     ```
   - Open the R script `analysis.R` in RStudio or another IDE.  
   - Run the code to reproduce the results or adapt it to your dataset.  

## License  
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments  
- **Dataset**: [Kaggle - Customer Personality Analysis](https://www.kaggle.com/datasets/imakash3011/customer-personality-analysis).  
- **References**:  
  - R Documentation: [Sys.Date() and format](https://stat.ethz.ch/R-manual/R-devel/library/base/html/Sys.time.html).  
  - ggplot2 Charts: [Bubble Chart Example](https://r-charts.com/correlation/bubble-chart-ggplot2/).  
