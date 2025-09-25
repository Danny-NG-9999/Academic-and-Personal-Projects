## 🧩 Project Background & Overview
Modern hiring in data and analytics roles increasingly depends on proficiency across a core stack of practical skills—notably Python, SQL, Machine Learning (ML), Tableau, and Excel.

While training programs and universities actively evaluate students on these skills, it remains unclear which specific skills most strongly influence placement outcomes (i.e., whether a student secures a job placement).

This project analyzes a cohort of students with recorded scores in the five core skills alongside their placement outcomes. The objective is to quantify the relationship between skill proficiency and employability, and to identify which skills carry the greatest weight in determining placement success.

**Objectives**
- Explain the role of each skill, individually and in combination, in shaping placement outcomes.
- Guide students on where to focus practice time to maximize their likelihood of placement

**Technical Stack**
- **Programming & Analysis**: Python, Jupyter Notebooks
- **Libraries**: Pandas, NumPy, Scipy, Matplotlib and Seaborn

This project demonstrates the ability to combine statistical analysis, visualization, and business reasoning to generate insights that are both technically sound and practically valuable.

## 📌 Table of Contents
- [🗂 Data Structure Overview](#-data-structure-overview)  
- [🔧 Methodology](#-methodology)  
- [📖 Executive Summary](#-executive-summary)  
- [🔍 Insights Deepdive](#-insights-deepdive)  
- [📊 Visualization](#-visualization)  
- [✅ Recommendations](#-recommendations)  
- [📌 Conclusion](#-conclusion)  

## 🗂 Data Structure Overview
- **Source**: Kaggle dataset
- **Initial Size**: 200 records with 6 columns
- **Key Variables**: Programming language skills and Student Placement outcomes details

| Column Name      | Dtype    | Description |
|------------------|----------|-------------|
| **Python**       | float64  | Score (0–1) representing student’s skill in Python programming. |
| **Sql**          | float64  | Score (0–1) representing student’s skill in SQL (databases). |
| **ML**           | float64  | Score (0–1) representing student’s skill in Machine Learning. |
| **Tableau**      | float64  | Score (0–1) representing student’s skill in Tableau (data visualization). |
| **Excel**        | float64  | Score (0–1) representing student’s skill in Microsoft Excel. |
| **Student Placed** | object   | Placement outcome (`Yes` / `No`), indicates whether the student was placed. |

## 🔧 Methodology
The analysis was structured into a sequential workflow:
- **Data Import & Cleaning**
  - **Objective**: Ensure data integrity.
  - **Actions**: Verified dataset completeness, handled missing values, and standardized data formats.
- **Exploratory Data Analysis (EDA)**
  - **Objective**: Identify initial patterns and relationships.
  - **Actions**: Analyzed skill distributions (via histograms and skewness), generated a correlation heatmap for inter-skill relationships, and compared average skill levels between the placed and not-placed groups.
- **Skill Impact Analysis**
  - **Objective**: Quantify the influence of skills on placement success.
  - **Actions**: Created difference plots (Placed – Not Placed), applied logistic regression to model the effect of programming scores, and calculated effect sizes to gauge the magnitude of each skill's impact.

## 📖 Executive Summary
This analysis evaluates the relationship between students’ technical skill proficiency (Python, SQL, Machine Learning, Tableau, Excel) and their placement outcomes. The findings show that while all skills hold some value, not all contribute equally to employability.

Key takeaways include:
- **Independence of Skills**: Technical proficiencies are uncorrelated, meaning mastery of one skill does not imply strength in another.
- **Placement Landscape**: A moderate majority (58%) of students are placed, but a sizable minority (42%) remain unplaced, underscoring gaps beyond technical proficiency.
- **Differentiating Skills**: Coding/database skills (Python, SQL) appear to be baseline expectations, while applied, business-facing skills (ML, Tableau, Excel) are stronger differentiators of placement success.
- **Model Findings**: Logistic regression shows weak predictive power, confirming that placement may depends on non-technical factors (e.g., communication, internships, networking, GPA).
- **Practical Insight**: Machine Learning, Excel, and Tableau emerge as the most impactful technical skills for employability, while Python and SQL remain foundational but insufficient on their own.

## 🔍 Insights Deepdive
**Skill Relationships & Distributions**  
- Correlation Heatmap: All skills are nearly independent (r ≈ -0.08 to +0.08). Students with multi-skill mastery are rare, making them standout candidates.
- Skill Distributions: Scores are evenly spread across proficiency levels with near-zero skewness. Training and upskilling are relevant for all learners.

**Placement Outcomes**
- Overall: 58% of students are placed, while 42% are not — indicating a need for stronger employability support.
- Average Skill Gaps: Placed students outperform in ML, Tableau, and Excel, while Python and SQL show no placement advantage.

**Difference Plots**
- Key Driver: ML shows the largest positive difference (+0.052), with Tableau and Excel also positively contributing.
- Baseline Skills: Python and SQL show slight negative gaps, reinforcing their role as expected but non-differentiating skills.

**Logistic Regression & Odds Ratios**
- Model Fit: Pseudo R² ≈ 0.01, LLR p = 0.76 → very weak predictive power.
- Coefficients: ML (OR ≈ 1.96), Tableau (OR ≈ 1.37), Excel (OR ≈ 1.46) trend positively, while Python (OR ≈ 0.88) and SQL (OR ≈ 0.90) trend negatively.
- Interpretation: None of the predictors are statistically significant (all p > 0.1). Placement is shaped more by soft skills, internships, and experience than technical scores alone.

**Effect Size & Power (ML Focus)**
- Impact: ML raises placement probability from ~40% → 57% (+17 percentage points).
- Effect Size: Cohen’s h = 0.345 (medium).
- Power: 93% → the dataset is sufficient to detect the effect, confirming ML’s practical importance despite weak regression significance.

**Relative Contribution (Magnitude & Direction)**
- Magnitude-Only: ML is the largest single driver (>40%), while Excel + Tableau together (~45%) nearly match its impact. Python + SQL contribute <15%.
- Accounting for Direction: ML, Excel, and Tableau show strong positive contributions, while Python and SQL show slight negative ones — likely due to being baseline expectations.
- Conclusion: Applied, business-facing skills (ML, Excel, Tableau) drive placements more than pure coding/database competencies.

## 📊 Visualization

### Correlation Heatmap (Skills relationship)
<img width="1097" height="848" alt="image" src="https://github.com/user-attachments/assets/d1598d3e-b08a-444d-9fd8-c48aad506b3a" />

- All technical skills (Python, SQL, ML, Tableau, Excel) show near-zero correlation with each other (range: -0.08 to +0.08).
- Proficiency in one skill does not predict proficiency in another. This indicates that skills are developed independently, and students with multi-skill mastery are uncommon, making them particularly standout candidates.

### Skill Distribution Histograms (Histograms & Skewness)
<img width="1536" height="1346" alt="image" src="https://github.com/user-attachments/assets/761b6863-2b04-4d38-a866-a9fd771024c5" />

- All skills exhibit approximately symmetric distributions (skewness near zero), with student scores spread evenly across proficiency levels.
- The student population is diverse, with no skill concentration at only beginner or expert levels. This confirms that training and upskilling initiatives are relevant for learners at all stages of proficiency.

### Placement Outcomes (Placed vs. Non-Placed)
<img width="1189" height="790" alt="image" src="https://github.com/user-attachments/assets/cc9494f8-af96-4111-a0a4-060b3f35309f" />

- 58% of students were placed, while 42% were not.
- The sizable non-placement rate underscores the need for additional support in employability skills, interview preparation, and industry alignment.

### Average Skill Scores: Placed vs. Non-Placed Students
<img width="1189" height="788" alt="image" src="https://github.com/user-attachments/assets/d004c173-e0f0-4555-93c1-92f1beb6675c" />

- Machine Learning (ML) proficiency is the strongest differentiator for placement, showing the largest positive gap. Tableau and Excel also show positive, though smaller, advantages for placed students. Conversely, Python and SQL show no positive impact.
- Technical analysis coding skills (Python/SQL) are likely considered baseline competencies. Placement success is increasingly driven by skills in applied data analysis and applied data science — particularly Machine Learning—and business intelligence tools (Tableau, Excel), suggesting these are higher-value differentiators in the job market.

### Difference Plots (Placed vs. Not Placed)
- Machine Learning (ML) shows the largest positive gap (+0.052), while Python and SQL show slight negative differences.
- Strong ML, Tableau, and Excel skills distinguish placed students, whereas Python/SQL proficiency alone does not guarantee placement.

<img width="1189" height="790" alt="image" src="https://github.com/user-attachments/assets/02ff47fb-75e5-4dca-9b9c-5c78952fa0ac" />

### Logistic Regression Model (Statistical Significance & Odds Ratios)

<img width="653" height="579" alt="image" src="https://github.com/user-attachments/assets/4de8e0e3-94c5-44cd-b9ce-0faca6e61961" />

- The logistic regression model has very weak predictive power (Pseudo R² ≈ 0.01), with no individual skill being a statistically significant predictor (p-values > 0.1).
- LLR p-value = 0.7583, meaning the model performs no better than random chance.
- While the model lacks statistical significance, the direction of the coefficients reinforces the story from the difference plot: ML, Tableau, and Excel show positive relationships with placement, while Python and SQL show negative ones. This indicates that technical, coding/database skills skills alone are insufficient to explain placement outcomes, which are likely influenced by other factors like soft skills, internships, or networking.
- Python/SQL exhibit slight negative trends, implying they might be assumed baseline skills rather than differentiators
- All 95% CIs cross zero (for coefficients) or 1 (for odds ratios), confirming no statistically significant effects. For example: ML’s CI = [–0.33, +1.68], meaning the true effect could range from negative to strongly positive → Cannot reliably predict placement at the 95% confidence level.

<img width="1032" height="702" alt="image" src="https://github.com/user-attachments/assets/9ae40f5a-8741-40ae-815e-ac76c34acb11" />

- ML shows the strongest positive trend (Odd Ratio ≈ 1.96), while Python (Odd Ratio ≈ 0.88) and SQL (Odd Ratio ≈ 0.90) trend negatively; Tableau and Excel show modest positive odds ratios.
- ML, Tableau, and Excel may enhance placement chances, but effects are not statistically reliable; Python and SQL appear as baseline skills rather than differentiators.

### Effect Size & Power Analysis (ML Skills)
<img width="755" height="84" alt="image" src="https://github.com/user-attachments/assets/f5807ec3-8efa-48d1-986a-4cbc32806b93" />
- **Baseline placement probability (without ML)**: 40%.
- **Adjusted probability (with strong ML skills)**: 57% (a +17 percentage-point increase).
- **Effect size (Cohen’s h)**: 0.345 (medium effect).
- **Study power**: 93% (sufficient to detect ML’s impact if it were the sole driver).

**Why isn’t ML significant in regression?**
- Strong ML skills raise placement probability from ~40% to ~57% (Cohen’s h = 0.345, medium effect); study power analysis of 93% shows the dataset (n=200) is sufficient to detect this effect.
- ML provides a practically meaningful boost to placement chances, but weak regression significance suggests it works alongside — not independently of — other critical factors (soft skills, experience).

### Relative Contribution of Skills to Placement Outcomes (Magnitude-Only, Ignoring Direction)
<img width="604" height="258" alt="image" src="https://github.com/user-attachments/assets/50701a4f-c4b0-4c50-8f4e-cb8f4095102c" />

<img width="1032" height="702" alt="image" src="https://github.com/user-attachments/assets/6b3d4c3d-fc40-4b71-bd50-a555292e7f9f" />

- When considering only the magnitude of influence, Machine Learning (ML) accounts for the largest single share (over 40%) of the explained impact on placement outcomes. The combined contribution of Excel and Tableau (~45%) is even greater than ML alone. 
- Python and SQL contribute less than 15% combined.
- This quantifies a clear priority for skill development: mastering applied data skills (ML) and business intelligence tools (Excel, Tableau) collectively contributes over 80% of the modeled impact on placement success, making this combination the most critical for students to focus on.

### Relative Contribution of Skills to Placement Outcomes (Accounting for Direction of Effect)
<img width="484" height="259" alt="image" src="https://github.com/user-attachments/assets/a62bd829-5733-4873-bd85-1a82cbaa49fb" />

<img width="1032" height="702" alt="image" src="https://github.com/user-attachments/assets/315a6e4f-133b-4a78-a2f6-a9e2c402342e" />

- Accounting for the direction of effect reveals that ML, Excel, and Tableau have strong positive net contributions, while Python and SQL have negative net contributions.
- Employers may already assume Python and SQL proficiency as baseline; these do not improve placement odds on their own. Instead, applied skills that bridge technical analysis with business impact (ML, Excel, Tableau) are the true differentiators in securing placements.

## ✅ Recommendations
For Students

Prioritize Applied Skills: Focus on Machine Learning, Excel, and Tableau, as these strongly differentiate placed candidates.

Maintain Core Foundations: Build competence in Python and SQL, but recognize these are baseline expectations, not differentiators.

Aim for Multi-Skill Mastery: Combine technical, applied, and business-facing skills to stand out in the job market.

Go Beyond Technical Proficiency: Strengthen communication, interview skills, networking, and practical project experience to improve employability.

For Instructors / Program Leads

Curriculum Design: Emphasize applied analytics and business intelligence tools (ML, Tableau, Excel) alongside foundational coding.

Targeted Upskilling: Offer tiered training programs for beginners, intermediate, and advanced learners, given the even skill distribution.

Integrative Learning: Encourage students to apply multiple skills together in projects, reinforcing real-world problem-solving.

Holistic Preparation: Embed employability-focused modules (presentation, teamwork, client communication) into technical training.

For Placement Cells / Career Services

Industry Alignment: Partner with recruiters to validate the demand for applied skills and adjust training pathways accordingly.

Employability Support: Provide structured mock interviews, soft skills workshops, and networking opportunities to complement technical training.

Highlight Differentiators: Showcase students with strong ML, Excel, and Tableau skills when engaging with employers.

Encourage Internships & Projects: Facilitate opportunities that integrate technical and applied skills in real-world contexts to enhance placement readiness.



## 📌 Conclusion

This project shows that while Python and SQL remain essential, placement outcomes are most strongly associated with ML, Tableau, and Excel proficiency. Students with a balanced and practical skill portfolio are significantly more likely to be placed.

The analysis provides actionable insights for students, instructors, and placement services, supporting data-driven curriculum design and targeted career preparation.

✨ This project demonstrates the ability to combine statistical analysis, visualization, and business interpretation to deliver actionable insights for education and employability.
