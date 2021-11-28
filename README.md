# ANIME OTAKU API

>This application is the back-end of the **AnimeOtaku-Client** web app.It's a Rails API-only application provides JSON resources to the it's front-end client.
>The application uses JWT for authentication and authorization to its protected resources.
Definition of otaku
A person having an intense or obsessive interest especially in the fields of anime and manga —often used before another noun otaku culture.

<div align="center">

[![View Code](https://img.shields.io/badge/View%20-Code-green)](https://github.com/Ceejayski/Anime-otaku-API)
[![Github Issues](https://img.shields.io/badge/GitHub-Issues-orange)](https://github.com/Ceejayski/Anime-otaku-API/issues)
[![GitHub Pull Requests](https://img.shields.io/badge/GitHub-Pull%20Requests-blue)](https://github.com/Ceejayski/Anime-otaku-API/pulls)

</div>

## 📝 Contents

<p align="center">
<a href="#features">Main Features</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
<a href="#frontend">Frontend</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
<a href="#with">Built with</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
<a href="#qs">Quick Start</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
<a href="#testing">Testing</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
<a href="#author">Author</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
</p>

## Main Features<a name = "features"></a>

- A proper authentication system has been implemented using JWT. Users are able to create a new account and login/logout securely.
- Users has two main roles: Admin and Users
- Admin can create, delete and update animes
- Admin can also delete users 
- Users can see a list of different Animes.
- Users can add Animes to their favorites list
- Users can see all the Animes they have addd in the Favorites page.
- Users can remove animes from their favorites list

## Front-end<a name= "frontend"></a>

The front-end(client) of the application for both the project's repository and the [live link](https://findyourdreamanime.netlify.app) are found here.

- [GitHub Repo](https://github.com/Ceajayski/anime-otaku-client)
- [Live Demo](https://findyourdreamanime.netlify.app/)

## 🔧 Built with<a name = "with"></a>

- Rails 6.0.3.6
- 2.7.0p0

## Quick Start<a name= "qs"></a>

### Prerequisite

- Install Ruby ([installation guide](https://www.ruby-lang.org/en/documentation/installation/))
- Install Ruby on Rails ([installation guide](https://guides.rubyonrails.org/getting_started.html#creating-a-new-rails-project-installing-rails))
- Git and Github

#### Get a local copy with:<br>

```bash
git clone https://github.com/Ceejayski/Anime-otaku-API
```

### Installation

After cloning the app, enter following commands in your terminal.

```bash
bundle install
```

```bash
rails db:create
```

```bash
rails db:migrate
```

```bash
rails db:seed
```

```bash
rails server
```

### Testing <a name= "testing"></a>

To test the project

- Navigate to the directory where the project is located.
- Open terminal in this directory.
- Start testing by using `rspec` command.


## ✒️  Authors <a name = "author"></a>

### Author(s)

![Hireable](https://img.shields.io/badge/HIREABLE-YES-yellowgreen&?style=for-the-badge)

👤 **Okoli Chijioke**

- Github: [@ceejayski](https://github.com/ceejayski)

- LinkedIn: [LinkedIn](https://www.linkedin.com/in/okoli-ceejay/)
- 
## Show your support

Kindly ⭐ Star this project on GitHub — it helps!

## Acknowledgments

- My thanks goes to Microverse and all our peers and colleagues there.

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](https://github.com/Ceajayski/anime-otaku-api/issues).


## 👍 Show your support

Give a ⭐️ if you like this project!

## :clap: Acknowledgements
- [Microverse](https://www.microverse.org/)

## 📝 License

This project is [MIT](./LICENSE) licensed.
