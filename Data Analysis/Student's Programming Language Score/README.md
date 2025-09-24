## 📘 Project Background & Overview

Modern hiring for data and analytics roles is driven by demonstrable proficiency across a stack of practical skills—typically **Python**, **SQL**, **Machine Learning**, **Tableau**, and **Excel**. Training programs and universities increasingly assess students on these skills, yet it’s often unclear *which skills most influence placement outcomes (e.g., getting placed vs. not placed)

This project analyzes a cohort of students with recorded scores in the five core skills above and their corresponding placement outcomes. My aim is to *quantify the relationship* between skill proficiency and placement to identify *which skill areas carry the most predictive power*

### Objectives
- **Explain** how each skill (individually and in combination) relates to student placement.
- **Prioritize** the skills that matter most using interpretable importance metrics.
- **Identify thresholds** and “minimum viable profiles” (balanced skill mixes that consistently correlate with successful placement).
- **Guide interventions** for students and instructors (where to focus practice time to maximize placement probability).

### Stakeholders & Use Cases
- **Students:** Understand which skills to improve first to cross critical placement thresholds.
- **Instructors / Program Leads:** Calibrate curriculum emphasis and assessment rubrics to align with hiring signals.
- **Placement Cells / Career Services:** Target workshops and mock interviews for skills that yield the highest uplift.

### Assumptions & Limitations
- The analysis is **observational**, not causal; results should be interpreted as **associations** rather than proofs of cause and effect.
- Placement outcomes can be influenced by additional factors (projects, internships, interview performance, networking) that may not be fully captured in the dataset.
- Thresholds and importance may shift across cohorts, markets, and time; periodic refresh is recommended.





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


