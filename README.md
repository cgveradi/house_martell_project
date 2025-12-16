# 📈 House Martell Project

## Customer Experience (CX) - Vanguard

This project focuses on analyzing the results of a digital A/B test conducted by Vanguard's Customer Experience (CX) team. The experiment aimed to determine if a **new, modern User Interface (UI)** combined with **in-context prompts** could increase the client process completion rate compared to the traditional interface.

Our role is to act as Data Analysts, cleaning the provided datasets, decoding the experiment's performance, and presenting key findings and recommendations.

## 🗃️ 2. Data Sources

We are working with three primary datasets, which were merged into a single master data frame for analysis:

| Dataset                       | Content            | Key Information                                                                      |
| :---------------------------- | :----------------- | :----------------------------------------------------------------------------------- |
| `df_final_demo`               | Client Profiles    | Demographics (Age, Gender) and Account Details.                                      |
| `df_final_web_data`           | Digital Footprints | Detailed trace of client online interactions (merged from pt_1 and pt_2).            |
| `df_final_experiment_clients` | Experiment Roster  | Which clients were assigned to the Control (Traditional UI) or Test (New UI) groups. |

## Day 1 & 2: Data Cleaning Summary & EDA

The initial two days were dedicated to foundational data work: setup, merging, cleaning, and Exploratory Data Analysis (EDA) to understand the client base.

### - Data Preparation and Cleaning

1.  **Data Consolidation:** Successfully loaded and merged the three source files (`demo`, combined `web_data`, and `experiment`) into a single **Master Data Frame** keyed on `client_id`.
2.  **Missing Value Handling:** (Detailed description of specific actions taken, e.g., _Missing values in the 'Gender' column were imputed with the mode, while web activity NaNs were interpreted as no activity._)
3.  **Data Type Validation:** Ensured all key date and time columns were converted to `datetime` objects and numerical features were correctly typed.
4.  **Feature Engineering:** A critical new binary column, `process_completed`, was created in the Master Data Frame to act as the primary **Conversion Metric** for the A/B test analysis.

### - Initial Client Demographic Analysis
