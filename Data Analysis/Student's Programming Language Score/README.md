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




Insight
- Since no skill reached significance, technical skill scores alone do not explain placement.
- The strongest trend is ML, but evidence suggests its effect is weaker than OR=2, and not a standalone predictor.
- Future models should include non-technical predictors (e.g., interview performance, projects, work experience).


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
