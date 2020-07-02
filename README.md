
# Welcome Screen

## First Step

At first user need to select units that will be used for data later:

1. For weight it's **KG** (default) and **LB** (multiplied KG by 2.20462).

2. For food/energy it's **KCAL** (default) and **KJ** (multiplied KG by 4.184).

After units are confirmed user can be taken to second and last setup step.

## Second Step

Here user need to enter information (units are taken from previous step) based on which goals will be calculated:

1. Current/today's weight, which will be also used for **first entry**

2. Target/goal weight, allow us to see if weight needs to be lost or gained and how much

3. At last user is asked for weekly weight change. Hint for this input provides max recommended delta amount. And after this value is provided "Target Deficit/Surplus" value will be showed.

After that setup is complete and user will be taken to "Entry Page". But before that question about permission to send notification will be asked.

# Navigation Bar

This bar is visible from any page, and contains following buttons that will take user to corresponding pages:

- Entry

- Trends

- Progress

- Setup

# Entry Page

This page is pretty straight-forward, user selects a day and enters weight and food intake. There're some limits, like user can't enter information further than last day of current week, and some standard validation for reasonable input values.

# Trends Page

Just like "Entry Page" this one also has calendar, but whole weeks are being selected, and based on existing entries some statistics and trends will be shown:

- Food - avg. food intake for selected week

- Weight - avg. weight for selected week

- TDEE - avg. **T**otal **D**aily **E**nergy **E**xpenditure for selected week

- Weight change - and this one is obviously weekly weight change

# Progress Page

Title of the page has date of first entry

## Delta Chart

This chart takes all "Weight change" values (or deltas) per week, and show trend on how much weight user gain or lose each week

## Progress Circle

Provides 3 blocks of information:

- Percentage of completion

- Real numbers of how much weight user need to gain/lose, and how much of this is done

- Estimated number of weeks, calculated based on recommended "Target Deficit/Surplus"

# Setup Page

## Units

Here user can re-select units for weight and energy. Interface will switch to new units and all existing data will be converted.

## Reminders

In this block scheduled time for notifications can be adjusted. By default it uses 9am for weight and 9pm for food.

## Goal Settings

And last block allows user to change their goal, and re-calculate related values. So, for example if somebody tried to lose weight, it's possible to change goal here for gaining it.
