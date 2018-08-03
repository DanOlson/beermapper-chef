# Overview

This is a Chef repo for Beermapper and Evergreen Menus. It uses wrapper cookbooks and cookbook-as-runlist strategies.

# Repository Directories

This repository contains several directories, and each directory contains a README file that describes what it is for in greater detail, and how to use it for managing your systems with Chef.

- `site-cookbooks/` - Cookbooks you download or create.
- `data_bags/` - Store data bags and items in .json in the repository.
- `vendor-cookbooks/` - I vendor cookbooks here so that I can use the same Berksfile with either knife solo or kitchen

# Tooling

- ChefDK
- Knife solo
- Kitchen
- Berkshelf

# Running Tests

Tests are run via Kitchen

`kitchen [converge|verify|test]`

# Provision the VM

```
vagrant up
knife solo bootstrap vagrant@10.10.0.88 -i .vagrant/machines/default/virtualbox/private_key nodes/beermapper-dev.json
```

# Cooking production

```
berks vendor ./vendor-cookbooks
knife solo cook root@evergreen nodes/beermapper.json
```

