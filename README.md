# VCI
This repository holds the necessary documents for implementing the Volunteer Capacity Indicator as presented at Rock RX 2024 by Randy Aufrecht

Volunteer Capacity Indicator (VCI)
==================================

Problem
-------

Having too many badges showing a persons completion of volunteer related Eligibility/Safety tasks can be difficult to know a volunteers true eligibility and can add safety and security vulnerabilities for your church. Each church evaluates the safety and security of their volunteers differently. Hopefully you can use the framework below to process your VCI. If you will not be using the Bonus Content, the Evaluation dates will be set manually to dates when you would like to notify ministries of potential safety/security issues. The Bonus content adds a job/workflow that helps remove around 80% of the manual changes that occur during normal processing of expired requirements.

What is a VCI?
--------------

Beyond qualifications of age and skill-set and background checks, this indicator will give an opportunity for Ministries and Leaders to further indicate a more specific level of eligibility/Safety for various volunteer opportunities:

*   Black-Unauthorized to Volunteer
*   Red-Unauthorized to Volunteer at this Time
*   Orange-All Star Requires Updated Authorizations
*   Blue-Authorized All Star for Adults Only
*   Yellow-Authorized All Star Minor and Conditional
*   Green-Authorized All Star for All
*   Grey-All Star Status Under Evaluation
*   Purple-High Capacity All Star 

Things you need to accomplish this recipe:
------------------------------------------

This was written using v14.3 and Fluid Lava

**Blue Box Moon: Workflow StimPack plugin.** /Package/68  
This gives you "For Each" as a new workflow action that gives an easy way to cycle through many like items without having to create the complicated tracking attributes.

**For Bonus Content:  
Workflow Launcher by Southeast Christian Church** /Package/85  
This gives you a new Job: "Workflow Launcher (Plugin)" that allows you to use SQL to start a workflow and populate Workflow attributes