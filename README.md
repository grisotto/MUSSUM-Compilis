## Contents

- [Intro](#robcmp)
- [Instalação](#Installation)
- [Exemplos](#Exemplos)
- [Ajuda](#Ajuda)


<a name="robcmp"></a>
### robcmp
**LLVM frontend for Arduino**

Project Developed at Universidade Federal de Goiás - Regional Jataí
http://computacao.jatai.ufg.br

This code is a framework to build LLVM compiler frontend's. It uses the compiler backend in https://github.com/avr-llvm/llvm.

The purpose of the framework is to provide basic support for academics, taking the Compiler course, to build their own language an run it on Arduino boards.

The files [rob.l](/rob.l) and [rob.y](/rob.l) implements a general purpose example language, using the framework in [node.h](/node.h) file. Examples of the language are provided in [test](/test) folder.

Academics has built their own specific language, to run an arduino connect to a robot arm (1). The project file is provided in the [proj](/proj) folder, file [project.pdf](/proj/project.pdf), writen in Brazilian Portuguese.


1:
![arm robot](/proj/robotarm.jpg)

<a name="Installation"></a>
## Instalação

1 - Clone o repositório 'MUSSUM-Compilis':

2 - Instale os pacotes necessários:

**LLVM** Encontre o llvm adequado a sua distribuição:
[llvm](http://apt.llvm.org/)

3 - Instale o pacote lncurses-dev, clang e llvm-3.8

```bash
sudo apt-get install libncurses5-dev clang llvm-3.8
```
<a name="Exemplos"></a>
## Exemplos

https://grisotto.github.io/MUSSUM-Compilis/

**Vídeos de ajuda**:


[![Robcomp parte 1](http://i3.ytimg.com/vi/0sjMMcToySM/hqdefault.jpg)](https://www.youtube.com/watch?v=0sjMMcToySM&list=PLgDl66NdlckmEInm5MZruTB8ny3vGkXKH&index=1 "Robcomp parte 1")

[![Robcomp parte 2](http://i3.ytimg.com/vi/tcHpQz9_d8g/hqdefault.jpg)](https://www.youtube.com/watch?v=tcHpQz9_d8g&index=2&list=PLgDl66NdlckmEInm5MZruTB8ny3vGkXKH "Robcomp parte 2")




<a name="Ajuda"></a>
## Ajuda


[![Ajuda](http://img.youtube.com/vi/mOZxzxgxUx4/mqdefault.jpg)](https://youtu.be/mOZxzxgxUx4?t=15s "Ambulância preta")



