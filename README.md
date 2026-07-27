Com base na análise do código-fonte da sua biblioteca modificada, apresento a documentação completa.

Visão Geral

Esta é uma biblioteca Lua para criação de interfaces gráficas (GUI) no Roblox, projetada para ser usada em execuções de script (como com loadstring). Ela fornece uma estrutura para criar janelas com abas e vários elementos de interface, como botões, alternâncias, controles deslizantes, menus suspensos e muito mais.

Inicialização

Para começar, carregue a biblioteca e crie uma janela principal.

```lua
local UILibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/TERCEIRO-COMANDO-DA-CAPITAL/T.C.C-HUB-simples/refs/heads/main/SOURCE%20MODFIED%20(TCC).lua"))()
local window = UILibrary.CreateWindow("Título da Janela", "Subtítulo", 590, "v1.0")
```

· CreateWindow(title, subtitle, size, version):
  · title: (string) O título principal da janela.
  · subtitle: (string) O subtítulo exibido ao lado do título.
  · size: (number) A largura da janela (a altura é fixa).
  · version: (string) A versão exibida no cabeçalho.

Gerenciamento de Abas (:AddTab)

Após criar a janela, você adiciona abas a ela. Cada aba contém seus próprios elementos.

```lua
local tab = window:AddTab("Nome da Aba", "Icone")
```

· window:AddTab(name, icon):
  · name: (string) O nome da aba que aparecerá na barra lateral.
  · icon: (string) O asset ID para um ícone ou uma palavra-chave de um conjunto predefinido (ex: "Settings", "Player"). Se não for fornecido, nenhum ícone será exibido.

Elementos da Interface

Todos os elementos são adicionados a uma aba usando os métodos descritos abaixo.

1. Seção (:AddSection)

Uma seção é um cabeçalho de texto usado para organizar visualmente os elementos.

```lua
tab:AddSection("— Título da Seção")
```

2. Parágrafo (:AddParagraph)

Um parágrafo exibe um título e uma descrição em texto.

```lua
local paragraph = tab:AddParagraph("Título", "Descrição do texto aqui...")
```

· Métodos do Objeto paragraph:
  · paragraph:Update(novoTitulo, novaDescricao): Atualiza o texto do parágrafo.
  · paragraph:SetVisible(boolean): Mostra ou esconde o parágrafo.
  · paragraph:Destroy(): Remove o parágrafo.

3. Botão (:AddButton)

Um botão executar uma função de retorno (Callback) quando clicado.

```lua
tab:AddButton({
    Name = "Nome do Botão",
    Description = "Descrição do botão",
    Callback = function()
        print("Botão clicado!")
    end
})
```

4. Alternância (Toggle - :AddToggle)

Uma alternância (interruptor) que mantém um estado booleano (true/false).

```lua
local toggle = tab:AddToggle({
    Name = "Opção de Alternância",
    Description = "Liga ou desliga algo",
    Default = false, -- Estado inicial
    Callback = function(state)
        print("Alternância mudou para:", state)
    end
})
```

· Métodos do Objeto toggle:
  · toggle:SetState(boolean): Define o estado da alternância.
  · toggle:GetState(): Retorna o estado atual (true/false).
  · toggle:Toggle(): Inverte o estado atual.

5. Tecla de Atalho (Keybind - :AddKeybind)

Um botão que permite ao usuário definir uma tecla para executar uma ação.

```lua
local keybind = tab:AddKeybind({
    Name = "Atalho",
    Description = "Define uma tecla de atalho",
    Default = Enum.KeyCode.F, -- Tecla inicial (ou nil)
    Callback = function()
        print("Tecla de atalho pressionada!")
    end
})
```

· Métodos do Objeto keybind:
  · keybind:SetKey(Enum.KeyCode): Define a tecla de atalho programaticamente.
  · keybind:GetState(): Retorna o nome da tecla atualmente definida.

6. Entrada de Texto (Input - :AddInput)

Um campo para o usuário digitar texto.

```lua
local input = tab:AddInput({
    Name = "Entrada de Texto",
    Description = "Digite seu nome aqui",
    Default = "Valor padrão",
    Callback = function(text)
        print("Texto inserido:", text)
    end
})
```

· Métodos do Objeto input:
  · input:SetText(string): Define o texto do campo.
  · input:GetState(): Retorna o texto atual.

7. Controle Deslizante (Slider - :AddSlider)

Um controle deslizante para selecionar um valor numérico em um intervalo.

```lua
local slider = tab:AddSlider({
    Name = "Volume",
    Description = "Ajusta o volume",
    Min = 0,
    Max = 100,
    Default = 50,
    Callback = function(value)
        print("Volume ajustado para:", value)
    end
})
```

· Métodos do Objeto slider:
  · slider:SetValue(number): Define o valor do slider.
  · slider:GetValue(): Retorna o valor atual.

8. Menu Suspenso (Dropdown - :AddDropdown)

Um menu que permite ao usuário selecionar uma opção de uma lista.

```lua
local dropdown = tab:AddDropdown({
    Name = "Selecionar Skin",
    Description = "Escolha uma skin",
    Options = {"Skin1", "Skin2", "Skin3"},
    Default = "Skin1",
    Callback = function(selected)
        print("Opção selecionada:", selected)
    end
})
```

· Métodos do Objeto dropdown (Principal melhoria desta versão):
  · dropdown:SetOptions(tabelaDeOpcoes): Atualiza a lista de opções do menu. A nova lista substituirá a antiga. O primeiro item da nova lista será automaticamente selecionado.
  · dropdown:SetValue(string): Define programaticamente qual opção está selecionada.
  · dropdown:GetValue(): Retorna a opção atualmente selecionada.
  · dropdown:ToggleDropdown(boolean): Força a abertura (true) ou fechamento (false) da lista de opções.

9. Seletor de Cores (Color Picker - :AddColorPicker)

Um seletor de cores que permite ao usuário escolher uma cor.

```lua
local picker = tab:AddColorPicker({
    Name = "Cor do Tema",
    Description = "Escolha uma cor",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(color)
        print("Cor selecionada:", color)
    end
})
```

· Métodos do Objeto picker:
  · picker:SetValue(Color3): Define a cor do seletor.
  · picker:Toggle(): Abre ou fecha o seletor de cores.

Notificações

A biblioteca possui um sistema para criar notificações no canto da tela.

```lua
window:Notification({
    Name = "Título da Notificação",
    Description = "Descrição da notificação.",
    Type = "Notification", -- Ou "Warn", "Error"
    Duration = 5 -- Tempo em segundos
})
```

Gerenciamento de Janela

A janela principal possui controles para minimizar, expandir e fechar.

· Fechar: O botão "X" no canto superior direito abre uma caixa de diálogo de confirmação para destruir a interface completamente.
· Minimizar: O botão de traço (-) minimiza a janela para um pequeno ponto na tela.
· Expandir/Reduzir: O botão de quadrado (□) alterna a janela entre o tamanho padrão e um modo mais compacto.
· Arrastar: Clique e segure na parte inferior da janela (sobre a barra de arrasto) para movê-la.

Personalização de Temas

A biblioteca possui um sistema de temas. Você pode alterar o tema atual da janela.

```lua
window:SetTheme("NomeDoTema")
```

Os temas disponíveis são: Darkness, Dark, White, Black, Forsaken, Forest 2021, Germany 1941, Spooky. O tema padrão é "Cursed".

Recursos Adicionais

· Barra de Pesquisa: Localizada no cabeçalho da janela, permite pesquisar elementos dentro da aba atual.
· Informações do Usuário: O canto inferior esquerdo da janela exibe a foto e o nome do jogador. Clicar nele alterna para mostrar informações anônimas ("Roblox").
· Central de Notificações: Gerencia notificações, empilhando-as automaticamente.

Esta documentação cobre todas as funcionalidades principais da sua biblioteca, incluindo a nova capacidade de atualizar dinamicamente o menu suspenso (dropdown:SetOptions).
