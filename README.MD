# WoW Farmer

## Overview
**WoW Farmer** is an add-on for World of Warcraft (Cataclysm Classic and Classic Edition) that helps players optimize their farming sessions by providing accurate profitability projections. By leveraging market prices, drop rates, and sell success rates, this add-on empowers players to make informed decisions on what materials to farm for maximum earnings.

## Features
- **Profitability Tracking**: Calculate projected earnings per hour based on Auctioneer market data and farming efficiency.
- **Session-Based Drop Rates**: Refines drop rates using a moving average based on actual farming results.
- **Customizable Settings**: Adjust undercut values and calculation parameters to match your farming style.
- **Manual Session Controls**: Start, pause, and stop farming sessions with full control to avoid interruptions when changing zones or going AFK.
- **Minimalistic UI**: A small, compact, and unobtrusive interface that adapts to the player's UI scaling.

## Installation
1. Download the repository as a ZIP file or clone it using Git:
   ```bash
   git clone <repository-url>
   ```
2. Extract the folder (if downloaded as a ZIP) and place it in your WoW `AddOns` directory:
   ```
   World of Warcraft/_classic_/Interface/AddOns/WoWFarmer/
   ```
3. Restart World of Warcraft and enable the add-on in the AddOns menu.

## Usage
1. Open the add-on interface via the mini-map icon or a configurable keybinding.
2. View a sortable table of farmable materials, their anticipated market prices, and profitability.
3. Use the **Start**, **Pause**, and **Stop** buttons to track your farming sessions.
4. Review session data to refine drop rates and optimize future farming routes.

## Customization
- **Undercut Settings**:
  - Base Undercut: Default is 5 copper.
  - Maximum Undercut Percentage: Default is 15% below market value.
  - Adjust these settings in the add-on options menu.
- **Drop Rate Calculation**:
  - Initially uses pre-populated data.
  - Transitions to a 3–5 session moving average for personalized accuracy.

## Planned Features
- Integration with Auctioneer’s pricing models to ensure reliable market data.
- Automated session pause when the player goes AFK.
- Enhanced profitability calculations using actual sale prices and sell success rates.
- Improved session tracking and dynamic UI updates.

## Development Setup
1. Clone the repository to your local machine:
   ```bash
   git clone <repository-url>
   ```
2. Copy the add-on folder to your WoW AddOns directory:
   ```
   World of Warcraft/_classic_/Interface/AddOns/WoWFarmer/
   ```
3. Test the add-on in-game and reload the UI as needed with `/reload`.

## Contributing
Contributions are welcome! Here’s how you can help:
1. Fork the repository.
2. Create a feature branch:
   ```bash
   git checkout -b feature/your-feature
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add feature: your-feature"
   ```
4. Push the branch and create a pull request.

## License
This project is licensed under the MIT License. See the `LICENSE` file for details.

## Contact
For feedback, feature requests, or questions, please open an issue on the [GitHub repository](<repository-url>).

