# this folder is for ansible playbook

## Plese follow following architecture

```
vars                      # for variables 
lab0_deploy.yml           # Main playbook of lab0
lab1.yml                  # Main playbook of lab1
lab2.yml                  # Main playbook of lab2
roles/
    lab0_acm_op_on_hub/               # this hierarchy represents defaults for a "role"
        tasks/            #
            main.yml      #  <-- tasks file can include smaller files if warranted
        handlers/         #
            main.yml      #  <-- handlers file
        templates/        #  <-- files for use with the template resource
            ntp.conf.j2   #  <------- templates end in .j2
        files/            #
            bar.txt       #  <-- files for use with the copy resource
            foo.sh        #  <-- script files for use with the script resource
        vars/             #
            main.yml      #  <-- variables associated with this role
        defaults/         #
            main.yml      #  <-- default lower priority variables for this role
        meta/             #
            main.yml      #  <-- role dependencies
```
