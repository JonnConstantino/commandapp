# commandapp

## Intruções para utilização do programa:

- Clone o repositório, para isso basta clicar em Code, SSH e copiar o link 

![](/pictures/foto1.png)


- Abra o terminal de seu computador e dê o seguinte comando: git clone e o link copiado
 
 ![](/pictures/foto2.png)
 
 
 - Outra forma para baixar o programa basta clickar em dowload zip
 
 - Baixe o flutter em seu pc:  https://docs.flutter.dev/get-started/install
 
 - Utilize o VS Code para compilar o programa para isto abra o terminal na pasta commandapp e digite : code .
 
 - Baixe a extensão do flutter, basta ir em extensões e digitar flutter
 
 ![](/pictures/foto3.png)

- Em seguida compile o programa, aguarde que irá abrir a seguinte interface

 ![](/pictures/foto4.png)

- Com isso você já pode utilizar o programa

 ## Teste do programa
 
- Abra o terminal na pasta commandapp/websocket-server-test
 
- dê o seguinte comandos: 
	
	pip3 install websockets

-será instalado o websockets, após digite :
	python3 server.py
	
 ![](/pictures/foto5.png)

-Basta agora abrir o código no VS Code e colocar pra rodar, assim que abrir a interface, a cada comando dado irá aparecer no terminal a mensagem de cada comando.

 ![](/pictures/foto6.png)

	- S90 = é o angulo passado para movimentação da câmera;
	- f= movimentar para frente;
	- d = movimentar para direita;
	- b = movimentar para trás;
	- e = movimentar para esquerda


## Integração 

- Para utilizar o programa integrado basta modificar a linha 40 do código onde será necessário informar o ip e a porta que se deseja conectar para passar os comandos

 ![](/pictures/foto7.png)
