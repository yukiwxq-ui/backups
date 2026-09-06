# **My CMEE Coursework Repository - Week 1**

# PART 1 UNIX/Linux Commands Notes

## 1. Navigation & Directory

### pwd
* **Description:** Print working directory.
* **Example:**

```bash
pwd
# Output: /home/user/Documents/CMEECourseWork/week1/data
```

### ls

* **Description:** List files and directories.
* **Example:**

```bash
ls *.png
```

### cd

* **Description:** Change directory.
* **Example:**

```bash
cd ../
cd ~/Documents/
```

### mkdir

* **Description:** Make new directory.
* **Example:**

```bash
mkdir new_folder
```

### tree

* **Description:** Display directory structure.
* **Example:**

```bash
tree -L 2
```

### find

* **Description:** Search files or directories.
* **Example:**

```bash
find /home/ -maxdepth 3 -name 'bin' -type d
```

## 2. File Handling

### wc

* **Description:** Count lines, words, bytes.
* **Example:**

```bash
wc -l *.fasta
```

### cat

* **Description:** Concatenate and display file content.
* **Example:**

```bash
cat file1.txt
```

### cp

* **Description:** Copy files.
* **Example:**

```bash
cp source.txt destination.txt
```

### mv

* **Description:** Move/rename files.
* **Example:**

```bash
mv old_name.txt new_name.txt
```

### rm

* **Description:** Remove files.
* **Example:**

```bash
rm file.txt
```

## 3. Permissions & Environment

### chmod

* **Description:** Change file permissions.
* **Example:**

```bash
chmod +x script.sh
```

### export

* **Description:** Set environment variable.
* **Example:**

```bash
export PATH=$PATH:$HOME/.local/bin
```

## 4. Scripting & Execution

### Shebang

* **Description:** Specify interpreter for script.
* **Example:**

```bash
#!/bin/sh
```

### Running scripts

* **Example:**

```bash
bash tiff2png.sh
```

* **Note:** If file modified, re-add using `git add` and commit to push updates.

### Non-interactive Mode

* **Description:** Run scripts without user input.
* **Example:**

```bash
apt-get install -y package_name
```

## 5. Git Operations

### Add & Commit

```bash
git add file_name
git commit -m "commit message"
```

### Push to Remote

```bash
git push origin main
```

* **Tip:** To push to parent directory repo, run git commands from that directory.
* **Updating file:** Re-add and commit; same method works for replacing existing file.

## 6. Image Conversion Example

### tiff2png.sh

```bash
#!/bin/sh
for file in *.tif; do
    echo "Converting $file ..."
    convert "$file" "${file%.tif}.png"
done
```

* **Error example:**

```text
convert-im6.q16: Cannot read TIFF header.
convert-im6.q16: no images defined
```

* **Fix:** Check TIFF file integrity or path correctness.




# **PART 2 SHELL SCRIPTING**

## **boilerplate.sh**

The script provides a template for creating new shell scripts. It shows:

1. **Structured header information**

```sh
# Author: ...
# Script: ...
# Desc: ...
# Arguments: ...
# Date: ...
```

2. `echo`: print formatted text to the terminal
3. `\n`: blank line
4. `#exit`: an optional exit command

---

## **myscript.sh**

Two ways of running a shell script:

1. `bash myscript.sh`: run directly
2. `chmod +x myscript.sh && ./myscript.sh`: make the script executable

### **$PATH environmental variable**

3. `echo $PATH`: show search paths; each directory is separated by a colon `:`
4. `find /home/ -maxdepth 3 -name 'bin' -type d`: find `bin` folders
5. `mkdir ~/.local/bin`: create local bin
6. `export PATH=$PATH:$HOME/.local/bin`: temporarily update PATH
7. `~/.bashrc` **or** `~/.zshrc`: permanently update PATH
8. `source ~/.bashrc`: reload configuration

---

## **Variables.sh**

Shows how variables and user input work in shell scripting (`sh`). Covers special variables, assigned variables, reading input, and command substitution.

1. **Prints details about how it was executed and its arguments**

**Important special variables:**

* `$0`: The filename (basename) of the current script, including extension
* `$n ($1...$9)`: Position of an argument; `$1` is the first argument, `$2` the second, etc.
* `$#`: Number of arguments supplied
* `$@`: All arguments individually printed (`$1 $2 ...`)

2. `MY_VAR='some string'`: assigning and reassigning variable values
3. `read MY_VAR`: prompts the user to type a new string, stores and prints it
4. `MY_SUM=$(expr $a + $b)`: calculates and displays the sum of two entered numbers

---

## **MyExamplesScript.sh**

Illustrates basic variable assignment, variable substitution, and printing output with `echo`.

1. `VariableName=`: assign shell variable
2. `$USER`: access current user's environment variable
3. `echo "Hello $USER"`: displays variable values and text together

**Other useful `tr` commands:**

* `tr -s " "`: squeeze repeated spaces into a single one
* `tr -d " "`: delete the character in quotes
* `tr [:lower:] [:upper:]`: convert lowercase to uppercase
* `tr -d [:alpha:] | tr -s " " ","`: remove letters and replace spaces with commas

**`-e` option:** enables interpretation of escape sequences like `\t` (tab) and `\n` (newline)

---

## **tabtocsv.sh**

Substitutes all tabs with commas.

* `$1`: first argument (input file)
* `cat $1`: read content of input file
* `tr -s "\t" ","`: squeeze repeated





# Part 3: Version Control with Git - Notes

## 1. Introduction

* Version control (revision control/source control) manages and tracks changes to code and certain data automatically.
* Allows recall of specific versions, collaborative work, backups (not a full backup solution).
* Examples: Google Docs, Overleaf.

## 2. Why Version Control?

* Track changes and access previous versions.
* Roll back changes to plain text files.
* Facilitate collaboration through branching/merging.
* Backup projects (but Git is not a full backup solution).

## 3. Why Git?

* Developed by Linus Torvalds.
* Distributed version control: each developer has a complete local copy.
* Fast, secure, supports branching and merging.
* Maintains full history for collaboration.

## 4. Git Concepts

* **Repository**: Directory with project files and complete history (.git directory).
* **Workspace**: Working directory with files to edit.
* **Index/Staging area**: Holds changes to be committed.
* **Local Repository**: Database of all objects (commits, blobs, trees) with metadata.

## 5. Installing Git (Ubuntu example)

```bash
sudo apt-get install git
git config --global user.name "Your Name"
git config --global user.email "your.login@imperial.ac.uk"
git config --global init.defaultBranch main
git config --list
```

* Config files: system (/etc/gitconfig), global (~/.gitconfig), local (.git/config)
* Check origin of configs: `git config --list --show-origin`

## 6. Creating Your First Repository

```bash
cd CMEECourseWork
git init
echo "My CMEE Coursework Repository" > README.md
git add README.md
git status
git commit -m "Added README file."
```

* Stage and commit files; use `-am` to add and commit tracked files together.
* Check status with `git status`.
* Use `git add *.txt` to add all text files recursively.

## 7. Commits

* Snapshot of the repository at a point in time.
* Records: changes, metadata (author, date, message), SHA-1 hash.
* Git stores snapshots, not diffs.
* Objects: **Blobs** (files), **Trees** (directories), **Commits**, **Tags**.

## 8. Basic Git Commands

| Command           | Function                           |
| ----------------- | ---------------------------------- |
| git init          | Initialize repository              |
| git clone         | Download from remote               |
| git status        | Show status                        |
| git diff          | Show differences                   |
| git blame         | Show who changed lines             |
| git log           | Show history                       |
| git commit        | Commit changes                     |
| git branch        | List branches                      |
| git branch name   | Create branch                      |
| git checkout name | Switch branch                      |
| git fetch         | Get remote commits without merging |
| git merge         | Merge branches                     |
| git pull          | Fetch and merge                    |
| git push          | Upload changes                     |

* Typical workflow: edit -> stage (`git add`) -> commit (`git commit -m`) -> push (`git push`).
* Use `git status` and `git log` frequently.

## 9. Remote Repositories

* Hosted on GitHub, GitLab, Bitbucket.
* Setup SSH for secure access.
* Link local repo to remote:

```bash
git remote add origin git@github.com:YourUsername/CMEECourseWork.git
git remote -v
git push origin main
```

* Only need internet for push/pull.

## 10. Branching

* Create experimental branch: `git branch anexperiment`
* Switch branch: `git checkout anexperiment`
* Create and switch in one step: `git checkout -b anexperiment`
* Commit changes on branch: `git commit -am "message"`
* Merge back: `git checkout main && git merge anexperiment`
* Delete branch: `git branch -d anexperiment` (or `-D` to force)
* Always branch when testing new features.

## 11. Common Branching Mistakes & Tips

* Working directly on main branch
* Not updating branches
* Not pulling latest changes
* Poor commit messages
* Mishandling merge conflicts
* Overwriting others' work
* Ignoring .gitignore
* Misusing Git commands
* Lack of communication
* Push broken code
* Confusion between local & remote branches
* Use feature branches, commit often, pull frequently, test code, communicate, follow team conventions.

## 12. README.md

* Introduces project: title, description, languages, dependencies, installation, usage, author/contact.
* Format: Markdown (.md) preferred.

## 13. Ignoring Files

* `.gitignore` prevents tracking certain files (e.g., temp, logs).

```bash
echo -e "*~\n*.tmp" > .gitignore
git add .gitignore
```

* Patterns: `target/`, `*.extension`, `!exceptions`
* To stop tracking an already tracked file: `git rm --cached <file>`

## 14. Binary & Large Files

* Git works best with plaintext.
* Binary files stored fully, large files (>100MB) problematic.
* Use `.gitignore` or alternatives like `git-lfs`.
* Back up large data separately (rsync, cloud).
* Check repo size: `du -sh .git` or `git count-objects -vH`

## 15. Pre-Commit Hooks

* Automate checks before commits (e.g., prevent large files).

```yaml
# .pre-commit-config.yaml
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v5.0.0
    hooks:
      - id: check-added-large-files
        args: ['--maxkb=500']
```

* Install: `pre-commit install`
* Ensures rules enforced on every commit.

## 16. Removing Files

* Remove file: `git rm <file>` and commit.
* Stop tracking: `git rm --cached <file>`
* Reset to previous version: `git reset --hard`
* Checkout specific commit: `git checkout <hash>`

## 17. Running Git on Different Directories

* `git -C ../SomeDir/ status`
* Pull in multiple subdirectories:

```bash
find . -mindepth 1 -maxdepth 1 -type d -print -exec git -C {} pull \;
```

* Useful for managing multiple repositories simultaneously.

---

**Tips/Mantras:**

* "Commit often, comment always."
* Branch for experiments.
* Use .gitignore wisely.
* Communicate with team.
* Backup large data separately.



# PART 4: SCIENTIFIC DOCUMENTS WITH LaTeX

## Introduction

* LaTeX: A text-based typesetting system for producing professional scientific documents.
* Alternative to WYSIWYG editors (Word, OpenOffice):

  * `.tex` file contains text + markup commands.
  * Compiled into `.pdf`.
* Advantages over Word:

  * Small, portable input files.
  * Free, cross-platform, stable.
  * Same output on any computer.
  * Professional formatting.
  * Easy embedding and annotation of images.
  * Easy typesetting of complex math.
  * Bibliography management (Mendeley, Zotero).
  * Supports automation for large documents (e.g., thesis).
* Limitations:

  * Steep learning curve.
  * Collaboration difficult if co-authors do not use LaTeX.
  * Track changes not native (can use packages).
  * Tables require careful formatting.
  * Images/floats need proper packages for precise placement.

## Installation

```bash
sudo apt-get install texlive-full texlive-fonts-recommended texlive-pictures texlive-latex-extra imagemagick
```

* Takes time (large installation).
* Editors:

  * Text editors (vim, nano)
  * Dedicated LaTeX editors (Texmaker, Gummi, TeXShop)
  * WYSIWYG frontends (Lyx, TeXmacs)
  * Overleaf (cloud-based, git-compatible)

## Key Features

### Environments

* Delimited by `\begin{}` … `\end{}`.
* Common environments:

| Environment                         | Purpose                     |
| ----------------------------------- | --------------------------- |
| `center`                            | Center text or graphics     |
| `itemize`                           | Bulleted list               |
| `enumerate`                         | Numbered list               |
| `figure`                            | Display figures             |
| `table`                             | Display tables              |
| `math`, `$...$`, `\(...\)`          | Inline equations            |
| `displaymath`, `\[...\]`, `$$...$$` | Standalone equations        |
| `equation`                          | Numbered, centered equation |

* Modifiers exist for customisation (e.g., change bullets).

### Special Characters

* Characters with specific functions: `# $ % & _ ^ { } ~ \`
* Escape to print: prefix with `\`

  * Example: `\%` → `%` in document.

### Commands

* Start with `\`.
* **Without arguments**: `\maketitle`, `\LaTeX`.
* **With arguments**: `\documentclass[12pt]{article}`, `\usepackage{graphicx}`, `\date{}`.
* Multiple spaces → single space; empty line → new paragraph.

### Math Typesetting

* Inline: `$...$`
* Numbered/displayed:

```latex
\begin{equation}
  \int_0^1 (\ln (1/x))^y dx = y!
\end{equation}
```

## Document Structure

1. **Document class**:

```latex
\documentclass[12pt,letterpaper]{article}
```

2. **Packages**:

```latex
\usepackage{color, graphicx, amsmath, amssymb, fancyhdr, listings, rotating, hyperref, lineno}
```

3. **Document body**:

```latex
\begin{document}
  % Content here
\end{document}
```

## First Example Document

```latex
\documentclass[12pt]{article}
\title{A Simple Document}
\author{Your Name}
\date{}

\begin{document}
\maketitle

\begin{abstract}
  This paper analyzes a seminal equation in population biology.
\end{abstract}

\section{Introduction}
Blah Blah

\section{Materials \& Methods}
\begin{equation}
  \frac{dN}{dt} = r N (1 - \frac{N}{K})
\end{equation}
It was first proposed by Verhulst in 1838 \cite{verhulst1838notice}.

\bibliographystyle{plain}
\bibliography{FirstBiblio}
\end{document}
```

## Referencing & Bibliography

* Find citation in Google Scholar → BibTeX.
* Example `.bib` entry:

```bibtex
@article{verhulst1838notice,
  title={Notice sur la loi que la population suit dans son accroissement},
  author={Verhulst, Pierre-Fran{\c{c}}ois},
  journal={Corresp. Math. Phys.},
  volume={10},
  pages={113--126},
  year={1838}
}
```

* Save as `FirstBiblio.bib` in the same directory.

## Compiling LaTeX

```bash
pdflatex FirstExample.tex
bibtex FirstExample
pdflatex FirstExample.tex
pdflatex FirstExample.tex
```

* 1st run: generates `.aux` file (citations info).
* `bibtex`: reads `.aux`, outputs `.bbl`.
* 2nd & 3rd pdflatex: update references and produce final PDF.

## Bash Script for Compilation

```bash
#!/bin/bash
pdflatex $1.tex
bibtex $1
pdflatex $1.tex
pdflatex $1.tex
evince $1.pdf &

# Cleanup
rm *.aux *.log *.bbl *.blg
```

* Run with: `bash CompileLaTeX.sh FirstExample`
* Can modify script to accept `.tex` directly: `bash CompileLaTeX.sh FirstExample.tex`

## Additional Tips

* Split large documents with `\input{file.tex}`.
* LaTeX supports custom commands/environments.
* Bibliography managers (Mendeley, Zotero) → export `.bib`.
* Math symbols: almost all symbols supported.
* Track changes using packages if needed.

## Practical

* Test `CompileLaTeX.sh` with `FirstExample.tex`.
* Put under version control (`git`) in `week1`.
* Ensure script works on other computers.




