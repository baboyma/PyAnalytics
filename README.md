# PyAnalytics

![PyAnalytics](https://raw.githubusercontent.com/baboyma/PyAnalytics/main/assets/logo.png)
![GitHub Repo stars](https://img.shields.io/github/stars/baboyma/PyAnalytics?style=social)
![GitHub last commit](https://img.shields.io/github/last-commit/baboyma/PyAnalytics)
![GitHub issues](https://img.shields.io/github/issues/baboyma/PyAnalytics)
![GitHub pull requests](https://img.shields.io/github/issues-pr/baboyma/PyAnalytics)

A quick `try by fire` python based data engineering, management, analysis and visualization, testing, and sample code for my `future self` and `self-learning projects`.

# Features

- Data Engineering: ETL processes, data cleaning, and transformation.
- Data Management: Database interactions, data storage solutions.
- Data Analysis: Statistical analysis, data exploration, and insights generation.
- Data Visualization: Graphs, charts, and interactive visualizations.
- Testing: Unit tests, integration tests, and test-driven development.
- Sample Code: Examples of common data tasks and algorithms.
- Documentation: Comprehensive guides and examples for each feature.

# Configuration

This project uses `poetry` as a dependency management tool along with `environment file` for sensitive and personal information. Most, if not all, of the code is written in `Python 3.11+` with `VS Code` as the primary IDE, and `MacOS` as the development environment.

# Installation

1. Clone the repository: Make sure to replace `<projects-directory-name>` with your actual projects directory name.

```bash
    cd ~/<projects-directory-name>
    git clone git@github.com:baboyma/PyAnalytics.git
    cd PyAnalytics
    python -m venv .venv
    source .venv/bin/activate
    poetry install
    code .
```

2. Create a `.env` file in the root directory and add your sensitive information, as specified through out the project. This file is not included in the repository for security reasons.

```bash
    touch .env
```

3. Create a directory for your data files, if needed. The content of this is excluded in the repository, but you can modify it as per your requirements.

```bash
    mkdir data
```