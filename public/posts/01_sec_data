+++
author = "Oliver Bock"
title = "A Framework for financial data extraction and normalization"
date = "2025-03-03"
description = "A Framework for financial data extraction and normalization"
tags = [
    "emoji",
]

+++
<!--more-->

Factor-based investing relies heavily on the comparability of financial data, such as balance sheets, cash flow statements, and income statements. Unfortunately these reports often differ due to sector-specific and company-specific variations. This research addresses the challenges of comparing financial data across companies, which arise from varying reporting standards and schemes and proposes a meta model to extract and normalize financial data, which enables the calculation of key metrics for comparison in factor-based investing. Furthermore, the model facilitates the comparison of financial performance across companies by categorizing data into standardized sections such as revenues, profits, assets, and liabilities. The methodology discussed here emphasizes data normalization and aggregation, providing a robust framework for analyzing and comparing fundamental company performance in factor-based investing.

# Table of Contents

1. [Introduction](#introduction)
2. [Meta Model](#meta-model)
3. [Data Updates](#data-updates)
4. [Processing](#processing)

# Introduction
When doing factor based investing we need to be able to compare the fundamentals of the companies balance sheets, cashflow statements and income statements. 
The problem lies in that companies have different reporting standards. There are general submission rules but reporting schemes can differ from company to company and sector to sector.
This makes comparability even more difficult even for simple information like revenues, gross profit etc.
To have better standardization XBRL[^1] has been established in response to the growing need for efficient method of exchanging financial information.
The history of XBRL can be traced back to 1998 when Charles Hoffman proposed using XML to automate financial reporting. 
In addition to that Hoffman developed rules to have better comparability across different companies and sector.
He identified more than 50 different reporting schemes[^2] and therefore laid the groundwork for further data normalization.

The second we will desribe the current data update process
The third section will outline the current processing of the raw data and the aggregation into a standardized, normalized scheme based on a defined aggregation ruleset as well as impute and consistency rules.
The fourth section focus on the calculation of ratios
THe fifth section outlines Grading. 

# Meta Model

Factor-based investing necessitates the use of comparable and standardized financial data to make meaningful assessments of company performance. 
A critical aspect of this process is the ability to harmonize data across companies with varying reporting standards. Hoffmans foundational work on impute and consistency rules plays a pivotal role in enabling such comparability. 
By leveraging these rules, we can standardize diverse financial reporting schemes into a unified meta-model, which serves as the basis for data normalization and cross-company comparison.

The normalization of base financial data is the first step, allowing for the computation of key performance metrics. 
These metrics, derived from normalized data, enable a fair comparison of fundamental financial performance across different companies and sectors. 
The meta-model developed in this study is structured around core financial categories such as Revenues, Gross Profit, Assets, Liabilities, and other key components. 
A series of predefined rules facilitates the mapping of reported data entries to these standardized categories, ensuring consistent and accurate alignment with the meta-model. 
This approach not only enables the extraction of comparable financial metrics but also supports the application of analytical tools for factor-based investment strategies.

# Data Updates

To ensure the data remains current, it is essential to implement a mechanism for regular updates. The U.S. Securities and Exchange Commission (SEC) provides a daily update of financial data, which is compiled into a ZIP file and made available at their archives[^3]. 
To integrate this updated data, we retrieve and examine the contents of the ZIP archive in read mode, comparing the newly fetched files with those stored in the local directory.

The process for managing the ZIP archive is as follows:

* If a file is not present locally, it is extracted from the archive.
* If the file already exists locally but has an outdated modification timestamp, the local version is replaced with the updated file from the archive.

For the purpose of the proof-of-concept phase, the data has not yet been stored in a database. Instead, raw JSON files are processed directly, facilitating the initial validation and testing of the update mechanism. This approach allows for an efficient integration of new data while maintaining a manageable and adaptable workflow for future database storage.

# Processing

After updating the sources they need to be further processed.
This service processes raw financial data from JSON files, focusing on a predefined set of key metrics such as revenues, net income, and assets. 
It loads the JSON data from the specified directory and filters the metrics based on user-defined criteria. The service normalizes the data by iterating through the raw facts, extracting relevant metric entries that pass a specified time frame filter. 
It parses temporal information from each data entry, mapping values to specific years and quarters. Additionally, sub-metrics are aggregated under top-level metrics according to configurable rules. The normalized output is a structured, time-indexed dataset. 
Finally, the service includes functionality to merge multiple datasets based on common temporal keys, facilitating comprehensive time series analysis.

[^1]: eXtensible Business Reporting Language
[^2]: link s.. ?
[^3]: http://www.sec.gov/Archives/edgar/daily-index/xbrl/companyfacts.zip. Companyfacts are also available as JSON for every single company