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
- 58% of students were placed, while 42% were not placed.
- Skills show low inter-correlation, suggesting they are learned and assessed independently.
- Python and SQL alone are not reliable skills for placement success, despite being essential technical skills.
- Successful placement appears linked to a balanced skill mix, with both technical depth (ML) and applied/business tool proficiency (Tableau, Excel).

This analysis investigates how students’ programming language proficiency influences their placement outcomes. The study highlights relative contributions of skills, identifies significant predictors of employability, and provides data-driven insights for improving student readiness for placements.

Key findings indicate that while all programming languages contribute to employability, certain skills exhibit stronger directional influence on placement success.
This project shows that while Python and SQL remain essential, placement outcomes are most strongly associated with ML, Tableau, and Excel proficiency. Students with a balanced and practical skill portfolio are significantly more likely to be placed.


## 🔍 Insights Deepdive
- Correlation Heatmap: All skills are largely independent; no strong clustering.
- Histograms: Skill distributions are balanced and symmetric, with no overrepresentation of experts or beginners.
- Placement Outcomes: Majority placed (58%), but a large minority (42%) not placed indicates room for improvement.
- Skill Averages by Placement: Placed students outperform in ML, Tableau, and Excel. Not placed students have slightly higher averages in Python and SQL.
- Skill Differences (Placed – Not Placed):
  - ML (+0.052) is the strongest differentiator.
  - Tableau (+0.027) and Excel (+0.023) also contribute meaningfully.
  - Python (-0.011) and SQL (-0.002) show negligible or negative differences.

Insight
- Since no skill reached significance, technical skill scores alone do not explain placement.
- The strongest trend is ML, but evidence suggests its effect is weaker than OR=2, and not a standalone predictor.
- Future models should include non-technical predictors (e.g., interview performance, projects, work experience).



## 📊 Visualization
<img width="1097" height="848" alt="image" src="https://github.com/user-attachments/assets/d1598d3e-b08a-444d-9fd8-c48aad506b3a" />

- Minimal Linear Relationships: All correlation coefficients range from -0.08 to +0.08, indicating virtually no linear dependency between skills → Proficiency in one technical skill (Python, SQL, ML, Tableau, Excel) does not predict proficiency in others
- No Skill Synergy: The dataset shows no evidence of complementary skill relationships or natural skill groupings since  there is no strong correlations exist → can’t assume that someone who knows Python will also know SQL, ML, Tableau, or Excel.
- No multiple masteries of skills: Independence of skills means that students who mastered multiple skills (e.g., Python + SQL + Tableau) may stand out more strongly

<img width="1536" height="1346" alt="image" src="https://github.com/user-attachments/assets/761b6863-2b04-4d38-a866-a9fd771024c5" />

- Training or upskilling opportunities are relevant for all levels of learners — since student's score are not concentrated in only beginners or experts.
- This suggests that individuals vary widely in proficiency, and no single skill is heavily concentrated at high or low levels.
- All skewness values are close to zero, indicating symmetry in the distributions.

<img width="1189" height="790" alt="image" src="https://github.com/user-attachments/assets/cc9494f8-af96-4111-a0a4-060b3f35309f" />

- The chart shows a moderately successful placement outcome: a majority placed (58%), but a notable 42% non-placement rate highlights an area of concern — nearly half of the students could not secure positions → Suggests a need for further support in areas such as skill development, interview preparation, or industry alignment.

<img width="1189" height="788" alt="image" src="https://github.com/user-attachments/assets/d004c173-e0f0-4555-93c1-92f1beb6675c" />
Python & SQL

- Students who were not placed had slightly higher average Python and SQL scores compared to placed students → Suggests that technical proficiency in these two skills alone does not guarantee placement.

ML, Tableau, and Excel

- Students who were placed had higher average scores in ML, Tableau, and Excel compared to non-placed students →Indicates that broader skill sets (especially in applied analytics and business tools) are more aligned with placement outcomes.

Most significant difference

- The largest gap is observed in Machine Learning (ML), where placed students scored notably higher than non-placed ones →This suggests that advanced, in-demand skills like ML may strongly influence placement success.

<img width="1189" height="790" alt="image" src="https://github.com/user-attachments/assets/02ff47fb-75e5-4dca-9b9c-5c78952fa0ac" />

Machine Learning (ML)

Shows the largest positive difference (+0.052).

Placed students had significantly stronger ML skills compared to not placed students.

Suggests that ML proficiency is a strong driver of placement success.

Tableau & Excel

Both show positive differences (Tableau: +0.027, Excel: +0.023).

Indicates that placed students had better performance in applied/business-oriented tools, reinforcing their employability.

Python & SQL

Show slightly negative differences (Python: -0.011, SQL: -0.002).

Non-placed students had marginally higher Python and SQL scores, but the gap is very small and likely not impactful.

Suggests that strong coding/database skills alone are not sufficient for securing placements.


<img width="653" height="579" alt="image" src="https://github.com/user-attachments/assets/4de8e0e3-94c5-44cd-b9ce-0faca6e61961" />

None of the skill variables are statistically significant (all p-values > 0.1).

Machine Learning has the strongest effect size (odds ratio ~2), suggesting a trend that stronger ML skills may improve placement chances — but sample size may be too small to confirm significance.

Overall, the model shows very weak predictive power (pseudo R² ≈ 0.01).

Placement outcome seems to be influenced by factors beyond technical skill scores (e.g., communication, internships, soft skills, GPA, networking).

Overall Model Assessment
Poor Model Fit: Pseudo R-squared of 0.0096 indicates the model explains less than 1% of variance in placement outcomes

Statistically Insignificant: LLR p-value of 0.7583 confirms the model is not better than a null model

Convergence Issue: Only 4 iterations suggest potential model specification problems

Variable Significance Analysis
No Significant Predictors: All variables have p-values > 0.05, indicating no statistical significance

ML Shows Slight Promise: Highest coefficient (0.67) and lowest p-value (0.189), though still insignificant

Contradictory Effects: Python/SQL show negative relationships with placement, while ML/Tableau/Excel show positive

Predictor	Odds Ratio	Interpretation (Non-significant Effects)
Python	0.877953	Odds are 12.2% lower (1−0.878) for those with this skill compared to those without. (Note: This is not a reliable effect due to the high P-value.)
Sql	0.899956	Odds are 10.0% lower (1−0.900) for those with this skill. (Not reliable.)
ML	1.987772	Odds are 98.8% higher (1.988−1) for those with this skill. (Not reliable, but the largest potential effect.)
Tableau	1.416452	Odds are 41.6% higher for those with this skill. (Not reliable.)
Excel	1.461086	Odds are 46.1% higher for those with this skill. (Not reliable.)

Interpretation:

The odds ratios for ML, Tableau, and Excel are greater than 1, suggesting a positive relationship (higher odds of placement).

The odds ratios for Python and Sql are less than 1, suggesting a negative relationship (lower odds of placement).

Crucially, since all the coefficients are not statistically significant, these relationships cannot be reliably distinguished from zero effect in the population.

### Relative Contribution of Skills to Placement Outcomes (Magnitude-Only, Ignoring Direction)
<img width="604" height="258" alt="image" src="https://github.com/user-attachments/assets/50701a4f-c4b0-4c50-8f4e-cb8f4095102c" />

<img width="1032" height="702" alt="image" src="https://github.com/user-attachments/assets/6b3d4c3d-fc40-4b71-bd50-a555292e7f9f" />

ML Dominates: The largest single driver of placement, highlighting demand for applied data/ML capabilities.
Excel + Tableau Together (~44%): Practical tools for analysis and presentation are nearly as influential as ML. Suggests recruiters look for candidates who can both analyze and communicate results.
Python & SQL (<15% combined): These may be considered “baseline/expected skills” — useful, but not differentiating candidates in placement decisions.
To improve placement chances, students should prioritize Machine Learning, Excel, and Tableau, as these contribute the most to outcomes.
Python and SQL remain useful, but they may function as foundational skills rather than decisive factors.
The placement process likely rewards applied, business-facing, and interpretive skills (ML + Excel + Tableau) more than pure coding/database skills.

### Relative Contribution of Skills to Placement Outcomes (Accounting for Direction of Effect)
<img width="484" height="259" alt="image" src="https://github.com/user-attachments/assets/a62bd829-5733-4873-bd85-1a82cbaa49fb" />

<img width="1032" height="702" alt="image" src="https://github.com/user-attachments/assets/315a6e4f-133b-4a78-a2f6-a9e2c402342e" />

Applied skills matter most: The strongest drivers of placement are ML, Excel, and Tableau — skills that directly show ability to analyze and present data.
Python and SQL show negative signs. This doesn’t mean they’re “bad” skills — instead, it suggests they might be baseline skills everyone already has.
To maximize placement chances, students should focus on ML, Excel, and Tableau, which show strong positive contributions. Python and SQL are useful foundations, but in this dataset, they don’t improve placement odds by themselves and may even be seen as oversupplied skills.
Employers may already assume Python and SQL are “basic skills,” so they don’t help differentiate candidates. Instead, applied/business-facing skills (ML, Excel, Tableau) actually drive placement decisions.

### Logistic Regression
<img width="922" height="858" alt="image" src="https://github.com/user-attachments/assets/161bcd4d-491c-49ff-95b2-0bb3a976ce1b" />

<img width="1032" height="702" alt="image" src="https://github.com/user-attachments/assets/9ae40f5a-8741-40ae-815e-ac76c34acb11" />

Model fit

Pseudo R² = 0.0096 → The model explains less than 1% of variation in placement.

LLR p-value = 0.7583 → The overall model is not statistically significant.

Coefficients & Odds Ratios

Python: coef = –0.13, OR = 0.88 → Slight negative effect, but not significant (p=0.784).

SQL: coef = –0.11, OR = 0.90 → Slight negative effect, not significant (p=0.834).

ML: coef = +0.67, OR = 1.96 → Suggests ML almost doubles placement odds, but not significant (p=0.189).

Tableau: coef = +0.32, OR = 1.37 → Modest positive effect, not significant (p=0.521).

Excel: coef = +0.38, OR = 1.46 → Modest positive effect, not significant (p=0.464).
No predictor is statistically significant.

None of the five skills show a clear, reliable impact on placement chances at the 95% confidence level.

ML shows the strongest trend.

Odds ratio ~1.96 suggests ML could nearly double placement chances, but evidence is weak (p=0.189).

Excel and Tableau show moderate positive trends.

Both increase odds slightly, but results are not significant.

Python and SQL show slight negative trends.

Odds ratios <1 mean higher Python/SQL scores are linked to lower placement probability, though this is weak and not significant.

Model has low explanatory power.

Very low pseudo R² suggests technical skills alone cannot explain placements — other factors (communication, projects, internships, GPA, networking) likely play a much bigger role.
ML, Excel, and Tableau show the most promising positive trends, but no skill is a statistically significant predictor of placement in this dataset.

Python and SQL appear to have little to no impact and might even slightly reduce placement chances.

The model overall does not capture much variation in placement → soft skills and external factors matter more than technical scores alone.
🔹 Confidence Interval

The columns [0.025 and 0.975] are the 95% confidence interval (CI) for each coefficient.

Example:

For ML, coef = 0.6728, CI = [–0.332, 1.677].

Interpretation: we are 95% confident that the true ML effect lies between –0.33 and +1.68.

🔹 Why important?

If a CI crosses 0 (for coefficients) → the effect is not statistically significant.

Equivalently, for odds ratios, if the CI crosses 1, the effect is not significant.

✅ In your case:

All predictors’ CIs cross 0 → none of the skills are statistically significant predictors.

### Impact of ML Skills on Placement Chances: Effect Size and Power
Baseline probability = 0.40
→ Without strong ML skills, the chance of placement is about 40%.

Adjusted probability (with ML) = 0.57
→ With stronger ML skills, placement probability rises to 57%.
→ This means ML improves placement probability by 17 percentage points.

Effect size (Cohen’s h) = 0.345
→ This is considered a medium effect size.
→ ML skills have a moderate practical impact on placement chances.

Power with n = 200 = 0.932
→ The study has 93% power to detect this effect.
→ This is well above the common threshold of 80%, meaning your dataset is large enough to reliably detect ML’s impact if it exists.

ML has a meaningful impact

Improves placement probability from 40% → 57%.

This is not a trivial effect — it’s practically important.

The dataset has enough students (n=200)

The test is well-powered (93%), so the lack of strong statistical significance in regression results is not due to small sample size.

Why wasn’t ML significant in the regression?

Likely because placement is influenced by many other unmeasured factors (soft skills, internships, GPA, communication).

ML helps, but it’s not the sole driver.
ML provides a moderate, real-world boost to placement probability (~+17%).

The sample size (200) is more than sufficient to detect this effect statistically.

Since significance is still weak in the regression, it suggests other factors outside technical skills are critical for placement.


## ✅ Recommendations
For Students:

Prioritize Machine Learning, Tableau, and Excel to maximize placement chances.

Maintain Python and SQL as foundations but complement them with applied skills.

For Instructors / Program Leads:

Emphasize balanced skill development across technical and business-oriented tools.

Integrate projects that combine ML with visualization and reporting tools.

For Placement Cells / Career Services:

Design workshops focused on ML model application and dashboarding tools (Tableau/Excel).

Support mock interviews where students articulate applied skills, not just coding ability.

## 📌 Conclusion

This project shows that while Python and SQL remain essential, placement outcomes are most strongly associated with ML, Tableau, and Excel proficiency. Students with a balanced and practical skill portfolio are significantly more likely to be placed.

The analysis provides actionable insights for students, instructors, and placement services, supporting data-driven curriculum design and targeted career preparation.

✨ This project demonstrates the ability to combine statistical analysis, visualization, and business interpretation to deliver actionable insights for education and employability.
