*** Settings ***
Documentation        Cenários de teste do cadastro de usuários

Resource    ../resources/base.robot

Suite Setup        Log        Tudo aqui ocorre antes da Suite(antes de todos os testes)
Suite Teardown     Log        Tudo aqui ocorre depois da Suite(depois de todos os testes)    

Test Setup        Start Session
Test Teardown     Take Screenshot  

*** Test Cases ***
Deve poder cadastrar um novo usuário

    ${user}        Create Dictionary        
    ...        name=Jonas Teste        
    ...        email=jonas@teste.com        
    ...        password=jteste
  
    Remove user from database        ${user}[email]

    Go To        http://localhost:3000/signup

    #Checkpoint
    Wait For Elements State    css=h1       visible    5
    Get Text                   css=h1       equal      Faça seu cadastro

    Fill Text        id=name             ${user}[name]    
    Fill Text        id=email            ${user}[email]  
    Fill Text        id=password         ${user}[password] 
    
    Click            id=buttonSignup
    
    Wait For Elements State        css=.notice p       visible     5
    Get Text                       css=.notice p       equal       Boas vindas ao Mark85, o seu gerenciador de tarefas.


Não deve permitir o cadastro com email duplicado
    [Tags]    dup

    ${user}        Create Dictionary    
    ...        name=Teste Jonas    
    ...        email=teste@jonas.com    
    ...        password=jteste
  
    Remove user from database    ${user}[email]
    insert user from database    ${user}
   
    Go To        http://localhost:3000/signup

    #Checkpoint
    Wait For Elements State    css=h1       visible    5
    Get Text                   css=h1       equal      Faça seu cadastro
    
    Fill Text        id=name             ${user}[name]    
    Fill Text        id=email            ${user}[email]  
    Fill Text        id=password         ${user}[password]
    
    Click            id=buttonSignup
    
    Wait For Elements State        css=.notice p       visible     5
    Get Text                       css=.notice p       equal       Oops! Já existe uma conta com o e-mail informado.