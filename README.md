# fs_taxes

## **Description**

**fs_taxes** is a FiveM resource designed to implement a taxation system within your FiveM server. This system dynamically calculates and deducts income tax from players based on their bank balance, ensuring an immersive and realistic financial ecosystem.

## **Features**

- **Progressive Taxation:** Implements tax brackets, where higher bank balances are taxed at a higher rate.
- **Automated Deductions:** Periodically deducts tax from players' bank accounts based on configurable time intervals.
- **Configurable Tax Brackets:** Server owners can adjust tax thresholds and rates via configuration settings.
- **Notification System:** Players receive in-game notifications when taxes are deducted.
- **Logging & Debugging:** Logs tax transactions for transparency and debugging purposes.

## **Dependencies**

**Mythic Framework**

## **Installation**

1. Download the `fs_taxes` resource and place it in your server's `resources` folder.
2. Add `start fs_taxes` to your `server.cfg`.
3. Configure tax brackets and intervals in the `Config` file.
4. Restart your server and verify functionality.

## **Configuration**

Modify the `Config` file to set custom tax brackets and intervals
