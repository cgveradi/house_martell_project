# 🏰 Project: House Martell – Vanguard CX A/B Test Analysis

## 📌 Project Overview

As a Data Analyst in the Customer Experience (CX) team at **Vanguard**, I evaluated a digital experiment conducted from March 15, 2017, to June 20, 2017.

The primary objective was to determine if a **new, modern User Interface (UI)** with in-context prompts would lead to a higher process completion rate compared to the **traditional interface**.

---

## 🗃️ Data Sources & Integration

The analysis was performed on three primary datasets, merged into a single "Source of Truth":

- **`df_final_demo`**: Client demographics (Age, Gender, Account Balance, Tenure).
- **`df_final_web_data`**: Digital footprints (Step-by-step navigation logs from `pt_1` and `pt_2`).
- **`df_final_experiment_clients`**: The experiment roster identifying **Control** (Traditional UI) vs. **Test** (New UI) groups.

---

## 🛠 1. EDA & Data Cleaning

Before diving into the experiment results, we ensured the data was clean and understood the client base:

- **Data Consolidation**: Merged web traffic data and joined it with demographic and experiment rosters.
- **Cleaning**: Handled "Unknown" genders and addressed missing values in age and balance columns.
- **Feature Engineering**: Segmented clients into **Age Bins** (Young, Middle, Senior) and **Tenure Bins** (New, Established, Long-standing).

### Key Demographic Findings:

- **The Average Client**: 48 years old with 12 years of tenure at Vanguard.
- **Segment Distribution**: 68% of the clients are "Mid-Career" or "Pre-Retirees."
- **Logon Behavior**: High correlation (**0.99**) between logons and phone calls, suggesting that digital friction often forces users to seek human support.

---

## 📊 2. Performance Metrics (KPIs)

We evaluated the design effectiveness through three primary KPIs:

| KPI                          | Control (Traditional) | Test (New UI) | Result               |
| :--------------------------- | :-------------------- | :------------ | :------------------- |
| **Completion Rate**          | 65.59%                | **69.29%**    | ✅ +3.7% Increase    |
| **Initial Speed (Start)**    | 177s                  | **153s**      | ✅ 24s Faster        |
| **Error Rate (Back-clicks)** | **6.90%**             | 9.25%         | ❌ 34% More Friction |

**Insight**: The new UI is excellent at "hooking" users initially, but it introduces unexpected confusion in the middle of the funnel (Step 2), leading to more backtracking than the original design.

---

## 🧪 3. Hypothesis Testing

We used statistical testing to validate whether the observed changes were due to the design or random chance.

### A. Completion Rate Significance

- **Test**: Z-test for Proportions.
- **Result**: **Z-statistic = 8.87** (P-value < 0.0001).
- **Conclusion**: The improvement is **statistically significant**.

### B. Cost-Effectiveness Threshold

- **Vanguard Threshold**: Minimum 5% increase required to justify rollout costs.
- **Observed Lift**: **3.71%**.
- **Conclusion**: While statistically better, the design **did not meet the business threshold** for cost-effectiveness.

### C. Bias Check (Age & Balance)

- **Test**: T-test on Age and Account Balance across groups.
- **Result**: No significant differences (p > 0.05).
- **Conclusion**: The groups were balanced, ensuring a fair "apples-to-apples" comparison.

---

## 🏛 4. Final Evaluation & Recommendations

### Design Effectiveness

The experiment was structurally sound. However, the increased **Error Rate** (back-clicks) in the Test group suggests that the prompts/hints in the new UI might be causing cognitive overload.

### Duration Assessment

The 97-day duration was highly adequate. The massive sample size (>300k interactions) provided enough power to detect even small differences in behavior with high confidence.

### 💡 Strategic Recommendations

1. **Fix the "Step 2" Bottleneck**: Redesign Step 2 to reduce the time spent and the likelihood of users hitting the "Back" button.
2. **Iterative Rollout**: Instead of a full launch, pilot a **"Test V2"** that addresses the friction found in this analysis.
3. **Target High-Value Seniors**: Since the wealthiest segment (Seniors) had the lowest completion rate, focus on making the modern UI more accessible for older users.

---

## 💻 Tech Stack

- **Python** (Pandas, NumPy, Matplotlib, Seaborn)
- **Jupyter Notebooks**
- **Statistical Logic**: Z-tests, T-tests, and Correlation Matrices.
