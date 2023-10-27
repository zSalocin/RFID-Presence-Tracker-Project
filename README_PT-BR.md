
[![en](https://img.shields.io/badge/lang-en-green.svg)](https://github.com/zSalocin/rfid/blob/main/README.md)   [![pt-br](https://img.shields.io/badge/lang-pt--br-red.svg)](https://github.com/zSalocin/rfid/blob/main/README_PT-BR.md)

# Projeto RFID Presence Tracker

**Este projeto encontra-se em fase de desenvolvimento e testes. Utilize por sua própria conta e risco, pois ainda pode conter instabilidades ou limitações.**

## Descrição

O projeto RFID Presence Tracker é um aplicativo para Windows que integra-se a um dispositivo Arduino equipado com um leitor RFID. O objetivo do aplicativo é registrar a presença de indivíduos com base nas informações lidas pelo leitor RFID e compará-las com uma tabela de referência.

## Funcionalidades

- Leitura de dados do Arduino via comunicação serial.

- Comparação dos dados lidos com informações em uma tabela (como uma planilha Excel).

- Registro de presença de acordo com as correspondências encontradas.

- Interface de usuário amigável para interagir com o aplicativo.

## Requisitos

- Dispositivo com sistema Windows.

- Dispositivo Arduino com leitor RFID e capacidade de comunicação serial.

- Planilha de referência (Excel) contendo as informações a serem comparadas (as informações devem estar em formato de texto).

## Configuração do Ambiente

- Faça um Backup da Planilha.

- Clone o repositório do projeto.

- Carregue o código no Arduino para ativar a leitura do leitor RFID. (ainda não disponivel)

- Certifique-se de que o dispositivo Windows esteja conectado corretamente com o arduino que fara a leitura do RFID.

- Abra o aplicativo no dispositivo Windows.

- Importe a planilha de referência contendo os dados de comparação.

- Inicie a leitura do leitor RFID.

- O aplicativo comparará os dados lidos com as informações na tabela e registrará a presença.

## Licença
Este projeto é distribuído sob a licença MIT.
