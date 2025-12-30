# Sales Funnel Analysis using SQL & Power BI (AdventureWorks)
## Project Overview

This project demonstrates a Sales Funnel Analysis built on the AdventureWorksDW dataset using SQL and Power BI.

Unlike typical funnel analyses that rely on event-level data (e.g. page views, clicks, add-to-cart events), this project adapts the funnel concept to a transactional sales data model, which is a common scenario in many real-world organizations.

The goal is to show how an analyst can reconstruct a meaningful sales funnel even when granular event data is not available.

---

## Funnel Definition (Adapted for AdventureWorks)

Because AdventureWorks does not contain event-level tracking, the funnel is defined using business milestones:

Funnel Stage	Definition
Customer Acquisition	Customer exists in the system
First Purchase	Customer has at least one order
Repeat Purchase	Customer has more than one order
High-Value Customer	Customer exceeds a revenue threshold

This approach reflects how funnel analysis is often implemented in ERP / CRM / legacy systems.
