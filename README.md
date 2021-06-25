<p align="center"><a href="#" target="_blank"><img src="https://doc.livehelperchat.com/img/logo.png" width="200"></a></p>

![Version](https://img.shields.io/badge/version-1.0.0-blue.svg?cacheSeconds=2592000)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](#)

---

## Live Helper Chat

Configurei um ambiente utilizando LiveHelperChat. Atualmente esta utilizando a versão 3.68 da ferramenta.

Sugestões e criticas são muito bem vindas :blush:

⚠️ **Necessário ter o [Docker](https://docs.docker.com/engine/) e "docker-compose" instalado em seu ambiente local.** ⚠️

### Considerações

Para iniciar basta executar o comando abaixo:

```sh
$ docker-compose up -d --force-recreate --remove-orphans
```

Configuração padrão (Para alterar basta mudar no docker-compose.yml):

- Usuario: root
- Senha: lhc123
- Nome da Base: lhc

PS.: O servidor do chat esta subindo na porta 8080, então para acessa-lo basta acessar "http://127.0.0.1:8080" e efetuar as configurações da ferramenta.

## Autor

**Cristian B. Santos <cbsan.dev@gmail.com>**

Give a ⭐️ if this project helped you!
