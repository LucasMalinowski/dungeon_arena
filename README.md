<p align="center">
  <img src="./app/assets/images/logo.png" width="100" />
</p>
<p align="center">
	<img src="https://img.shields.io/github/license/LucasMalinowski/dungeon_arena?style=flat&color=0080ff" alt="license">
	<img src="https://img.shields.io/github/last-commit/LucasMalinowski/dungeon_arena?style=flat&logo=git&logoColor=white&color=0080ff" alt="last-commit">
	<img src="https://img.shields.io/github/languages/top/LucasMalinowski/dungeon_arena?style=flat&color=0080ff" alt="repo-top-language">
	<img src="https://img.shields.io/github/languages/count/LucasMalinowski/dungeon_arena?style=flat&color=0080ff" alt="repo-language-count">
<p>
<p align="center">
		<em>Developed with the software and tools below.</em>
</p>
<p align="center">
	<img src="https://img.shields.io/badge/JavaScript-F7DF1E.svg?style=flat&logo=JavaScript&logoColor=black" alt="JavaScript">
	<img src="https://img.shields.io/badge/HTML5-E34F26.svg?style=flat&logo=HTML5&logoColor=white" alt="HTML5">
	<img src="https://img.shields.io/badge/Ruby-CC342D.svg?style=flat&logo=Ruby&logoColor=white" alt="Ruby">
	<img src="https://img.shields.io/badge/YAML-CB171E.svg?style=flat&logo=YAML&logoColor=white" alt="YAML">
	<img src="https://img.shields.io/badge/Docker-2496ED.svg?style=flat&logo=Docker&logoColor=white" alt="Docker">
</p>
<hr>

## 🔗 Quick Links

> - [📍 Overview](#-overview)
> - [📦 Features](#-features)
> - [📂 Repository Structure](#-repository-structure)
> - [🧩 Modules](#-modules)
> - [🚀 Getting Started](#-getting-started)
    >   - [⚙️ Installation](#️-installation)
>   - [🤖 Running dungeon_arena](#-running-dungeon_arena)
>   - [🧪 Tests](#-tests)
> - [🛠 Project Roadmap](#-project-roadmap)
> - [🤝 Contributing](#-contributing)
> - [📄 License](#-license)
> - [👏 Acknowledgments](#-acknowledgments)

---

## 📍 Overview

<code>► INSERT-TEXT-HERE</code>

---

## 📦 Features

<code>► INSERT-TEXT-HERE</code>

---

## 🧩 Core Modules

<details closed><summary>.</summary>

| File                                                                                                  | Summary                         |
| ---                                                                                                   | ---                             |
| [Gemfile](https://github.com/LucasMalinowski/dungeon_arena/blob/master/Gemfile)                       | <code>► INSERT-TEXT-HERE</code> |
| [docker-compose.yml](https://github.com/LucasMalinowski/dungeon_arena/blob/master/docker-compose.yml) | <code>► INSERT-TEXT-HERE</code> |
| [Dockerfile](https://github.com/LucasMalinowski/dungeon_arena/blob/master/Dockerfile)                 | <code>► INSERT-TEXT-HERE</code> |
| [Gemfile.lock](https://github.com/LucasMalinowski/dungeon_arena/blob/master/Gemfile.lock)             | <code>► INSERT-TEXT-HERE</code> |
| [Procfile.dev](https://github.com/LucasMalinowski/dungeon_arena/blob/master/Procfile.dev)             | <code>► INSERT-TEXT-HERE</code> |
| [Rakefile](https://github.com/LucasMalinowski/dungeon_arena/blob/master/Rakefile)                     | <code>► INSERT-TEXT-HERE</code> |
| [config.ru](https://github.com/LucasMalinowski/dungeon_arena/blob/master/config.ru)                   | <code>► INSERT-TEXT-HERE</code> |

</details>

<details closed><summary>db</summary>

| File                                                                                   | Summary                         |
| ---                                                                                    | ---                             |
| [seeds.rb](https://github.com/LucasMalinowski/dungeon_arena/blob/master/db/seeds.rb)   | <code>► INSERT-TEXT-HERE</code> |
| [schema.rb](https://github.com/LucasMalinowski/dungeon_arena/blob/master/db/schema.rb) | <code>► INSERT-TEXT-HERE</code> |

</details>

<details closed><summary>db.migrate</summary>

| File                                                                                                                                                   | Summary                         |
| ---                                                                                                                                                    | ---                             |
| [20240821200830_devise_create_users.rb](https://github.com/LucasMalinowski/dungeon_arena/blob/master/db/migrate/20240821200830_devise_create_users.rb) | <code>► INSERT-TEXT-HERE</code> |

</details>

---

## 🚀 Getting Started

***Requirements***

Ensure you have the following dependencies installed on your system:

* **Ruby**: `version 3.2.2`
* **Bundler**: `version 2.5.17`
* **Rails**: `version 7.1.3`
* **Docker**: `version > 20.10.8`
* **Docker Compose**: `version > 2.0`

### ⚙️ Installation

0. **Prerequisites**:
- Download and install [Ruby](https://www.ruby-lang.org/en/downloads/). (I use [Asdf Ruby](https://github.com/asdf-vm/asdf-ruby) to manage Ruby versions on my system.)
- Download and install [Docker](https://docs.docker.com/get-docker/).
- Download and install [Docker Compose](https://docs.docker.com/compose/install/).

1. Clone the dungeon_arena repository:

```sh
git clone https://github.com/LucasMalinowski/dungeon_arena
```

2. Change to the project directory:

```sh
cd dungeon_arena
```

3. Install the dependencies:

```sh
bundle install
```

If not already installed, install the `bundler` gem:

```sh
gem install bundler -v 2.5.17
```

4. Run Docker Compose:


### 🤖 Running dungeon_arena

Use the following command to run dungeon_arena:


```sh
docker-compose up --build
```

#### To access the Rails console:

```sh
docker-compose run web bash
```
Ps: Once inside the 'web bash' container, you can run any Rails command, such as `rails db:migrate`, `rails db:seed`, etc.
###### Then run:
```sh
rails c
```

### 🧪 Tests

To execute tests, run:

```sh
rspec
```

---

## 🛠 Project Roadmap

- [ ] `► Add avatar to User`
- [ ] `► `
- [ ] `► `

---

## 🤝 Contributing

Contributions are welcome! Here are several ways you can contribute:

- **[Submit Pull Requests](https://github.com/LucasMalinowski/dungeon_arena/blob/main/CONTRIBUTING.md)**: Review open PRs, and submit your own PRs.
- **[Join the Discussions](https://github.com/LucasMalinowski/dungeon_arena/discussions)**: Share your insights, provide feedback, or ask questions.
- **[Report Issues](https://github.com/LucasMalinowski/dungeon_arena/issues)**: Submit bugs found or log feature requests for Dungeon_arena.

<details closed>
    <summary>Contributing Guidelines</summary>

1. **Fork the Repository**: Start by forking the project repository to your GitHub account.
2. **Clone Locally**: Clone the forked repository to your local machine using a Git client.
   ```sh
   git clone https://github.com/LucasMalinowski/dungeon_arena
   ```
3. **Create a New Branch**: Always work on a new branch, giving it a descriptive name.
   ```sh
   git checkout -b new-feature-x
   ```
4. **Make Your Changes**: Develop and test your changes locally.
5. **Commit Your Changes**: Commit with a clear message describing your updates.
   ```sh
   git commit -m 'Implemented new feature x.'
   ```
6. **Push to GitHub**: Push the changes to your forked repository.
   ```sh
   git push origin new-feature-x
   ```
7. **Submit a Pull Request**: Create a PR against the original project repository. Clearly describe the changes and their motivations.

Once your PR is reviewed and approved, it will be merged into the main branch.

</details>

---

## 📄 License

This project is protected under the [SELECT-A-LICENSE](https://choosealicense.com/licenses) License. For more details, refer to the [LICENSE](https://choosealicense.com/licenses/) file.

---

## 👏 Acknowledgments

- List any resources, contributors, inspiration, etc. here.

[**Return**](#-quick-links)

---