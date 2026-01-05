# 🏰 Project: House Martell – Vanguard CX A/B Test Analysis

## 📌 Project Overview

As a team of Data Analysts in the Customer Experience (CX) team at **Vanguard**, we evaluated a digital experiment conducted from March 15, 2017, to June 20, 2017.

The primary objective was to determine if a **new, modern User Interface (UI)** with in-context prompts would lead to a higher process completion rate compared to the **traditional interface**.

---

## 🗃️ Data Sources & Integration

The analysis was performed on three primary datasets, merged into a single "Source of Truth":

- **`df_final_demo`**: Client demographics (Age, Gender, Account Balance, Tenure).
- **`df_final_web_data`**: Digital footprints (Step-by-step navigation logs from `pt_1` and `pt_2`).
- **`df_final_experiment_clients`**: The experiment roster identifying **Control** (Traditional UI) vs. **Test** (New UI) groups.

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

## 📊 3. Performance Metrics (KPIs)

| KPI                          | Control (Traditional) | Test (New UI) | Result               |
| :--------------------------- | :-------------------- | :------------ | :------------------- |
| **Completion Rate**          | 65.59%                | **69.29%**    | ✅ +3.7% Increase    |
| **Initial Speed (Start)**    | 177s                  | **153s**      | ✅ 24s Faster        |
| **Error Rate (Back-clicks)** | **6.90%**             | 9.25%         | ❌ 34% More Friction |

**Insight**: While the new UI is better at "hooking" users initially, our **Error Rate** analysis shows that users backtrack 34% more often in the Test group. We identified **Step 2** as the primary friction point where users require more clarity.

---

## 4. Hypothesis Testing & Business ROI

- **Z-Test Result**: Z-statistic = **8.87**. We found this to be **Statistically Significant** with a p-value effectively at zero.
- **ROI Analysis**: Vanguard's **5% lift threshold** was not met (Observed: **3.71%**).
- **Bias Check**: We performed a T-test on Age and Account Balance across groups. With $p > 0.05$, we confirmed the groups were balanced and the test was fair.
- **Our Recommendation**: The redesign is a functional success but does not yet meet the economic requirements for a full rollout. We recommend iterating on Step 2 to reduce back-clicks and confusion.

---

## 🎨 5. Tableau Visualizations

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
