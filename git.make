g-init:
		touch .gitignore
		git init
		git add .
		git commit -m "initial commit"

g-commit: # some clean up is needed
		git commit -m "$(filter-out $@,$(MAKECMDGOALS))"

g-log:
		git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
