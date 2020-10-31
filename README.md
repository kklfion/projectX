# Necto

Welcome ! Necto is a social app for college students.

1. [Project Overview](#overview)
2. [Developers](#dev)

## <a name="overview"></a> Project status

- [x] Basic UI
- [x] Basic functinality
- [ ] Updated UI
- [ ] Refactor Networking
- [ ] Unit testing
- [ ] UI testing

## <a name="dev"></a> Installation
```
% git clone https://github.com/rbezghin/projectX.git
% cd projectX
% pod install
% pod update
```
## Usage
```
% open projectX.xcworkspace 
```
## Commiting new code to your branch 
("git add ." works correctly only if you have the most up to date .gitignore)
```
% git add .               # gets you "on branch someBranch"
% git commit -m "message" # commits new code
% git pull                # gets your local branch up to date
% git push                # gets you remote branch up to date
```
## Merging new code with master
```
% git checkout someBranch      # gets you "on branch someBranch"
% git pull origin master       # gets you up to date with origin
```

Then go to https://github.com/rbezghin/projectX/pulls to open a pull request master <- someBranch 
so that we can review it.

