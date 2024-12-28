# Random Numbers

Aplicativo Flutter para geração e ordenação de números aleatórios únicos.

## Funcionalidades

- Geração de números aleatórios únicos
- Interface para reordenação manual dos números
- Verificação de ordem crescente
- Feedback visual do status da ordenação
- Reset do processo a qualquer momento

## Arquitetura

O projeto utiliza Clean Architecture pelos seguintes motivos:
- **Separação de Responsabilidades**: Facilita a manutenção e evolução do código
- **Testabilidade**: Permite testar cada camada de forma isolada
- **Independência de Framework**: O core da aplicação não depende do Flutter
- **Escalabilidade**: Facilita a adição de novas features mantendo o código organizado

### Domain
- Contém as regras de negócio
- Define contratos (interfaces) para repositórios
- Independente de frameworks e detalhes de implementação

### Data
- Implementa os contratos definidos no Domain
- Gerencia fontes de dados (API)
- Converte dados entre camadas

### Presentation
- Implementa a interface do usuário
- Gerencia estado usando Provider
- Implementa a lógica de apresentação

## Bibliotecas Utilizadas

- **Provider**:
    - Escolhido por sua simplicidade e baixa curva de aprendizado
    - Recomendado pela própria documentação do Flutter
    - Ideal para aplicações de pequeno/médio porte
    - Facilita a implementação de testes

- **Mockito**:
    - Essencial para criação de mocks nos testes
    - Integração nativa com Flutter
    - Geração automática de código reduz boilerplate

- **Random Numbers API**:
    - Desenvolvida para atender os requisitos específicos do projeto
    - Garante números únicos e não repetidos
    - Facilita a manutenção e testes da lógica de negócios

## Como Executar

1. Clone o repositório
2. Instale as dependências:
```bash
flutter pub get
```
3. Execute o projeto:
```bash
flutter run
```

## Testes

Para executar os testes:
```bash
flutter test
```

### Cobertura de Testes

- Testes unitários da API
- Testes de Widget cobrindo fluxos principais
- Testes de integração entre camadas

## Estrutura do Projeto

```
lib/
  ├── core/
  │   ├── constants/
  │   ├── errors/
  │   └── usecases/
  └── features/
      └── random_numbers/
          ├── data/
          ├── domain/
          └── presentation/
```

## Requisitos

- Flutter: Última versão estável
- Dart: 2.x ou superior
- Android Studio: Última versão