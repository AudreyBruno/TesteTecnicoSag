# Teste Técnico - SAG

## 📋 Descrição

Este projeto consiste em uma aplicação **CRUD em Delphi** desenvolvida como parte do processo seletivo para a vaga de Programador Delphi. A aplicação permite o **cadastro, consulta, edição e exclusão de clientes**, incluindo uma funcionalidade extra de busca automática de endereço via **API ViaCEP**.

---

## 🧩 Funcionalidades

- Cadastro completo de clientes com os seguintes campos:

  - Nome do Cliente
  - CPF (com máscara e validação)
  - Data de Nascimento
  - E-mail
  - Endereço Completo:

    - Logradouro
    - Número
    - Bairro
    - Cidade
    - Estado
    - CEP (com máscara e botão de busca automática)

- Consulta de endereço via API pública [ViaCEP](https://viacep.com.br/)

- Integração com banco de dados utilizando **FireDAC**

- Interface intuitiva com formulário principal para gerenciar os dados

- Uso de **arquitetura em camadas** com separação entre `View`, `Model`, e `DataModule`

---

## 🛠 Tecnologias Utilizadas

- **Delphi (Recomendado: Delphi 10.4 ou superior)**
- **FireDAC** – acesso a banco de dados
- **SQLite** – banco de dados local
- **VCL (Visual Component Library)** – interface gráfica

---

## 📁 Estrutura do Projeto

| Caminho                            | Descrição                                  |
| ---------------------------------- | ------------------------------------------ |
| `untViewRegistrationCustomers.pas` | Formulário de cadastro/edição de clientes  |
| `untViewGetCustomers.pas`          | Formulário de listagem e busca de clientes |
| `DataModule.Main`                  | Unidades de acesso a dados com FireDAC     |
| `classCustomers.pas`               | Classe representando o modelo de cliente   |
| `untCpfCnpjValidator.pas`          | Unidade auxiliar para validação de CPF     |

---

## 🧪 Como Executar o Projeto

1. **Clonar o repositório / Descompactar o arquivo ZIP**

2. **Abrir o projeto no Delphi**

   - Arquivo: `TesteTecnicoSag.dproj`

3. **Compilar e executar o projeto**

   - O banco de dados SQLite (DB.db) é criado automaticamente ao executar o projeto pela primeira vez, por meio do módulo DataModule.Main.
   - Não é necessário rodar scripts manuais — o processo é feito de forma transparente para facilitar os testes.

---

## ✅ Critérios Atendidos

- [x] Uso de FireDAC para acesso ao banco de dados
- [x] Funcionalidade CRUD completa
- [x] Validação e máscara de CPF e CEP
- [x] Consulta de CEP integrada e funcional
