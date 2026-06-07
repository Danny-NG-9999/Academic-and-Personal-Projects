# Basel-Aligned Multi-Stage Credit Risk Modeling Framework: Development and Application

## 
In modern institutional lending, quantifying portfolio credit risk is not merely a regulatory compliance exercise, but a core driver of proactive capital allocation and strategic underwriting. This repository implements an end-to-end, production-grade credit risk architecture strictly aligned with the Basel Committee on Banking Supervision (BCBS) internal ratings-based (IRB) guidelines. Unlike traditional singular classification benchmarks that stop at predicting whether a borrower will default, this project deploys an integrated, multi-stage conditional modeling framework. It systematically quantifies the complete credit risk lifecycle by decoupling risk into three regulatory parameters:

Probability of Default (PD): A class-weighted logistic regression model optimized using advanced threshold discovery (Youden's Index) to identify baseline default probability.

Loss Given Default (LGD): A conditional two-stage hurdle model that isolates actual default events, determining first the probability of zero-recovery and second the continuous recovery rate via linear modeling.

Exposure at Default (EAD): A continuous regressor tracking the estimated credit exposure factor at the exact moment of breach.

By dynamically integrating these distinct component models, the architecture yields a robust Expected Loss (EL) provisioning engine capable of predicting absolute dollar write-offs across complex retail loan portfolios.

This framework presents a Basel‑aligned, multi‑stage approach to credit risk modeling, developed for regulatory capital (IRB) and impairment estimation. Built on the three core risk parameters—Probability of Default (PD), Loss Given Default (LGD), and Exposure at Default (EAD)—the framework translates regulatory standards into a replicable analytical pipeline. It serves as a reference implementation for practitioners seeking to bridge machine learning techniques with prudential requirements, using publicly available unsecured consumer loan data.
