# Project: House Martell – Vanguard CX A/B Test Analysis

## Project Overview

**Project:** House Martell – Digital Transformation Initiative  
**Objective:** Evaluate if the "Modern UI" redesign meets the Vanguard 5% ROI threshold for full-scale rollout.

---

## 🗃️ Data Sources & Integration

The analysis was performed on three primary datasets, merged into a single Data Source:

- **`df_demo`**: Client demographics (Age, Gender, Account Balance, Tenure).
- **`df_web_data`**: Digital footprints (Step-by-step navigation logs from `pt_1` and `pt_2`).
- **`df_experiment`**: The experiment roster identifying **Control** (Traditional UI) vs. **Test** (New UI) groups.

---

## 🛠 1. Multi-Tool Technical Implementation

We executed this project using a full data stack to ensure cross-tool validation and robust insights.

### 🐍 Python (EDA & Hypothesis Testing)

- **Libraries**: Pandas, NumPy, Matplotlib, Seaborn.
- **Process**: We performed deep-dive cleaning, handled nulls, and executed **Z-Tests for Proportions** and **T-Tests** for age/balance verification to ensure scientific accuracy.

### 🗄️ SQL (KPI Calculation)

- **Logic**: We utilized **Window Functions** (`LEAD`, `LAG`) to calculate the exact time-to-next-step and identify "Backward Movement" errors.
- **Structure**: We built **Common Table Expressions (CTEs)** to organize the navigation data into sequential steps, allowing us to flag any instance where a user moved from a later step back to an earlier one.
- **Validation**: Our SQL summaries provided a structured database layer that confirmed our Python findings, ensuring 100% data integrity.

### 📊 Tableau (Visualization & Storytelling)

- **Interactive Dashboards**: We built comparison charts to visualize Completion Rates against the ROI Threshold.
- **Calculated Fields**: We engineered custom metrics in Tableau to create "Success Funnels" and "Friction Heatmaps" that clearly show where clients struggled.

---

## 🛠 2. EDA & Data Cleaning

Before analyzing the experiment, we ensured the data was clean and understood our client base:

- **Data Consolidation**: We merged web traffic data with demographic and experiment rosters into a master dataframe.
- **Cleaning**: We addressed "Unknown" genders and missing values in age and balance columns to prevent bias.
- **Feature Engineering**: We segmented clients into **Age Bins** (Young, Middle, Senior) and **Tenure Bins**.

### Key Demographic Findings:

- **The Average Client**: 48 years old with 12 years of tenure at Vanguard.
- **Segment Distribution**: 68% of the clients are "Mid-Career" or "Pre-Retirees."
- **Logon Behavior**: We found a high correlation (**0.99**) between logons and phone calls, suggesting digital friction often leads to manual support needs.

---

Executive Summary: UI/UX Modernization A/B Test

**Project:** House Martell – Digital Transformation Initiative  
**Objective:** Evaluate if the "Modern UI" redesign meets the Vanguard 5% ROI threshold for full-scale rollout.

---

### Results

The A/B test was a **statistical success** but a **strategic caution**. While the new UI significantly improved user completion rates, it introduced a specific friction point at **Step 2** that prevented the project from maximizing its potential ROI.

---

### 3. Key Performance Indicators (KPIs)

| Metric                       | Control (Old)         | Test (New)                     | Performance                       |
| :--------------------------- | :-------------------- | :----------------------------- | :-------------------------------- |
| **Completion Rate**          | 65.59%                | 69.29%                         | **+3.71% (Absolute Lift)**        |
| **Relative Growth**          | 65.59% - 69.29% / 100 | **+5.65% (Exceeds 5% Target)** |
| **Initial Speed (Start)**    | 177.2s                | 152.9s                         | **24.3s Faster (Efficiency Win)** |
| **Error Rate (Back-clicks)** | 6.90%                 | 9.25%                          | **34% Increase (Friction Alert)** |

---

### 4. Statistical Validation

- **Methodology:** Two-proportion Z-test (one-tailed).
- **Confidence Level:** 99.9%.
- **Z-Statistic:** **8.87** (Significant threshold is 1.96).
- **P-Value:** `< 0.00001`.
- **Conclusion:** We successfully **Reject the Null Hypothesis**. The improvement in completion is directly attributable to the design changes and is not due to random variance.

---

### 5. Behavioral Insight: The "Step 2" Bottleneck

Despite the overall success, our diagnostic analysis (Funnel & Heatmap) identified a critical performance "leak":

- **The Hook:** The new UI is significantly more intuitive at the start, reducing time-to-onboarding by **14%**.
- **The Wall:** Users encountered a "Cognitive Trap" at **Step 2**, where time-on-page increased by **23% (approx. 9 seconds)** and backward-navigation (errors) spiked by **34%**.
- **Causality:** The 1.29% gap between the observed absolute lift (3.71%) and the ideal target (5.00%) is primarily located in this specific step.

---

### Design Effectiveness

- **Structure:** The experiment was well-structured as a **Randomized Controlled Trial (RCT)**. By isolating the UI change as the single independent variable, we were able to calculate a clear Z-statistic (8.87) to prove causality between the design and user behavior.
- **Randomization & Division:** \* **Randomization:** Clients were effectively randomized, as evidenced by the balanced baseline completion rates across both groups during the early stages of the funnel.
  - **Equality:** While the groups were not a perfect 50/50 split in size, they were sufficiently large to minimize **Standard Error (SE)**, ensuring that the results are statistically valid and representative.
- **Potential Biases:**
  - **Novelty Effect:** Users might have interacted differently simply because the design was _new_, rather than _better_.
  - **Selection Bias:** If the experiment was weighted toward specific tiers of clients (e.g., more active traders), the results may not generalize to the entire Vanguard population.

---

### Duration Assessment

- **Timeframe:** 03/15/2017 to 06/20/2017 (Approx. 97 Days).
- **Adequacy:** **YES.**
  - The 3-month window is ideal for financial services data. It accounts for **weekly cycles** (weekend vs. weekday behavior) and **monthly cycles** (payday cycles and monthly financial planning habits).
  - This duration allows the data to stabilize past the initial "Novelty Effect," ensuring the 3.71% lift reflects a permanent change in user behavior rather than a temporary reaction to a new interface.

---

### Additional Data Needs

To move from an "Absolute 3.71% lift" to exceeding the "5% ROI threshold," the following data points would be required for a deeper diagnostic:

1.  **Demographic Data:** Age and "Digital Literacy" scores. This would confirm if the **Step 2 friction** (34% error spike) is affecting specific age cohorts disproportionately.
2.  **Device Metadata:** Analyzing performance by Mobile vs. Desktop. Interface constraints on smaller screens often correlate with the "Back-click" errors observed at Step 2.
3.  **Qualitative Feedback:** Exit surveys or "Click-maps." Understanding exactly _where_ on the Step 2 page users clicked before retreating would turn our "Step 2 Problem" into a specific "Design Fix."
4.  **Client Tenure:** Data on how long a client has been with Vanguard would help identify **Habitual Bias** (where long-term users struggle with change more than new users).

---

## 🎨 6. Tableau Visualizations

Our final presentation includes an interactive Tableau Dashboard featuring:

- **Completion vs. Threshold**: A bar chart with a constant reference line at 70.59% to show the "Target Gap."
- **Success Funnel**: A visual breakdown of drop-offs at each stage of the investor journey.
- **Friction Heatmap**: Using our SQL-derived time data to highlight Step 2 as the primary bottleneck.

---

## 💻 Tech Stack

- **SQL**: Data extraction, CTEs, and Window Functions.
- **Python**: Pandas, NumPy, Scipy, Matplotlib, Seaborn.
- **Tableau**: Visual storytelling and KPI Dashboards.
- **Statistical Logic**: Z-tests, T-tests, and Correlation Matrices.
