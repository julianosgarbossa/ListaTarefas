//
//  main.swift
//  ProjetoListaTarefas
//  Created by Juliano Sgarbossa on 27/10/25.
//

import Foundation

// variáveis para armazenar os dados
var listaTarefas: [String] = []
var tarefasConcluidas: [Bool] = []
var programaAtivo = true

// função para exibir o menu do programa
func exibirMenu() {
    print("\n---- LISTA DE TAREFAS ----")
    print("1 - Adicionar tarefa")
    print("2 - Remover tarefa")
    print("3 - Listar tarefas")
    print("4 - Editar tarefa")
    print("5 - Marcar/Desmarcar tarefa como concluída")
    print("6 - Sair")
    print("Escolha uma opção: ", terminator: "")
}

// função para adicionar uma nova tarefa
func adicionarTarefa(tarefas: [String], novaTarefa: String) -> [String] {
    var tarefasAtualizadas = tarefas
    tarefasAtualizadas.append(novaTarefa)
    return tarefasAtualizadas
}

// função para remover uma tarefa
func removerTarefa(tarefas: [String], indice: Int) -> [String]? {
    guard indice >= 0 && indice < tarefas.count else {
        return nil
    }
    var tarefasAtualizadas = tarefas
    tarefasAtualizadas.remove(at: indice)
    return tarefasAtualizadas
}

// função para listar as tarefas
func listarTarefas(tarefas: [String], concluidas: [Bool]) {
    if tarefas.isEmpty {
        print("\nNenhuma tarefa cadastrada!")
    } else {
        print("\nSuas Tarefas:")
        for (indice, tarefa) in tarefas.enumerated() {
            let status = concluidas[indice] ? "[X]" : "[ ]"
            print("\(indice + 1). \(status) \(tarefa)")
        }
    }
}

// função para editar tarefa
func editarTarefa(tarefas: [String], indice: Int, novoNomeTarefa: String) -> [String]? {
    guard indice >= 0 && indice < tarefas.count else {
        return nil
    }
    var tarefasAtualizadas = tarefas
    tarefasAtualizadas[indice] = novoNomeTarefa
    return tarefasAtualizadas
}

// função para marcar ou desmarcar tarefa como concluída
func marcarDesmarcarTarefa(concluidas: [Bool], indice: Int) -> [Bool]? {
    guard indice >= 0 && indice < concluidas.count else {
        return nil
    }
    var concluidasAtualizadas = concluidas
    concluidasAtualizadas[indice] = !concluidasAtualizadas[indice]
    return concluidasAtualizadas
}

// start do programa
while programaAtivo {
    exibirMenu()
    
    // lê a entrada do usuário
    guard let entradaUsuario = readLine(), let opcao = Int(entradaUsuario) else {
        print("Opção inválida, tente novamente!")
        continue
    }
    
    // verificar opção do usuário
    switch opcao {
        
    case 1:
        // adicionando tarefa
        print("Informe o nome da tarefa: ", terminator: "")
        if let nomeTarefa = readLine(), !nomeTarefa.isEmpty {
            listaTarefas = adicionarTarefa(tarefas: listaTarefas, novaTarefa: nomeTarefa)
            tarefasConcluidas.append(false)
            print("Tarefa adicionada com sucesso!")
        } else {
            print("O nome da tarefa informado é inválido, tente novamente!")
        }
        
    case 2:
        // removendo tarefa
        if listaTarefas.isEmpty {
            print("Não há nenhuma tarefa para remover, adicione tarefas!")
        } else {
            listarTarefas(tarefas: listaTarefas, concluidas: tarefasConcluidas)
            print("Informe o número da tarefa que você quer remover: ", terminator: "")
            if let entradaUsuario = readLine(), let numero = Int(entradaUsuario) {
                let indice = numero - 1
                if let tarefasAtualizadas = removerTarefa(tarefas: listaTarefas, indice: indice) {
                    listaTarefas = tarefasAtualizadas
                    tarefasConcluidas.remove(at: indice)
                    print("Tarefa removida com sucesso!")
                } else {
                    print("O número da tarefa informado não existe, tente novamente!")
                }
            } else {
                print("O número informado é inválido, tente novamente!")
            }
        }
        
    case 3:
        // listar tarefas
        listarTarefas(tarefas: listaTarefas, concluidas: tarefasConcluidas)
        
    case 4:
        // editar tarefa
        if listaTarefas.isEmpty {
            print("Não há nenhuma tarefa para que você possa editar, crie tarefas!")
        } else {
            listarTarefas(tarefas: listaTarefas, concluidas: tarefasConcluidas)
            print("Digite o número da tarefa que você quer editar: ", terminator: "")
            if let entrada = readLine(), let numero = Int(entrada) {
                let indice = numero - 1
                print("Digite o novo nome da tarefa: ", terminator: "")
                if let novoNomeTarefa = readLine(), !novoNomeTarefa.isEmpty {
                    if let tarefasAtualizadas = editarTarefa(tarefas: listaTarefas, indice: indice, novoNomeTarefa: novoNomeTarefa) {
                        listaTarefas = tarefasAtualizadas
                        print("Tarefa editada com sucesso!")
                    } else {
                        print("O número da tarefa que você informou não existe, tente novamente!")
                    }
                } else {
                    print("O novo nome que você informou é invádido, tente novamente!")
                }
            } else {
                print("O número informado é inválido, tente novamente!")
            }
        }
    
    case 5:
        // marcar ou desmarcar tarefa como concluída
        if listaTarefas.isEmpty {
            print("Não tem tarefas para marcar como concluída, crie uma tarefa!")
        } else {
            listarTarefas(tarefas: listaTarefas, concluidas: tarefasConcluidas)
            print("Digite o número da tarefa: ", terminator: "")
            if let entradaUsuario = readLine(), let numero = Int(entradaUsuario) {
                let indice = numero - 1
                if let tarefasConcluidasAtualizadas = marcarDesmarcarTarefa(concluidas: tarefasConcluidas, indice: indice) {
                    tarefasConcluidas = tarefasConcluidasAtualizadas
                    let status = tarefasConcluidas[indice] ? "marcada" : "desmarcada"
                    print("Tarefa \(status) com sucesso!")
                    listarTarefas(tarefas: listaTarefas, concluidas: tarefasConcluidas)
                } else {
                    print("O número da tarefa que você informou não existe, tente novamente")
                }
            } else {
                print("O número informado é inválido, tente novamente!")
            }
        }
        
    case 6:
        // sair do programa
        print("Encerrando o programa...")
        programaAtivo = false
        print("Programa encerrado!")
        
    default:
        print("Opção inválida, tente novamente!")
    }
}






