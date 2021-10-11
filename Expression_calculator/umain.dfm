object FMain: TFMain
  Left = 219
  Top = 127
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Expression calculator'
  ClientHeight = 514
  ClientWidth = 763
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Splitter1: TSplitter
    Left = 337
    Top = 0
    Height = 514
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 337
    Height = 514
    Align = alLeft
    Caption = ' Calculate '
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 145
      Height = 16
      Caption = 'Expression for calculate:'
    end
    object L_erreur: TLabel
      Left = 16
      Top = 112
      Width = 114
      Height = 16
      Caption = 'Error in expression!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 16
      Top = 144
      Width = 41
      Height = 16
      Caption = 'Result:'
    end
    object E_Expression: TEdit
      Left = 16
      Top = 48
      Width = 305
      Height = 25
      TabOrder = 0
      Text = 'E_Expression'
    end
    object Button1: TButton
      Left = 16
      Top = 80
      Width = 305
      Height = 25
      Caption = 'Calculate'
      TabOrder = 1
      OnClick = Button1Click
    end
    object E_Resultat: TEdit
      Left = 16
      Top = 168
      Width = 305
      Height = 25
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = 'E_Resultat'
    end
  end
  object GroupBox2: TGroupBox
    Left = 340
    Top = 0
    Width = 423
    Height = 514
    Align = alClient
    Caption = ' Decription '
    TabOrder = 1
    object Memo1: TMemo
      Left = 2
      Top = 18
      Width = 419
      Height = 494
      Align = alClient
      Lines.Strings = (
        'Ce programme sans pretention, permet de calculer une expression'
        'mathematiques avec des parentheses (ex : (10*2)+5*sin(60)).'
        'Ce programme montre comment utiliser l'#39'unite expression et la '
        'procedure eval.'
        ''
        
          'Cette unite est derivee d'#39'une unite de Pascalissime (J. Colibri)' +
          '. Eval '
        
          'calcule en fonction des prioritees, utilise les parentheses, les' +
          ' '
        'fonctions scientifiques.'
        ''
        'Je l'#39'utilise dans mon programme d'#39'oscilloscope pour faire des '
        'calculs entre voies de mesures.'
        ''
        'Les fonctions connues sont :'
        #39'+'#39': addition'
        #39'-'#39': soustraction'
        #39'*'#39': multiplication'
        #39'/'#39': division'
        #39'^'#39': puissance'
        #39'SIN'#39': sinus'
        #39'COS'#39': cosinus'
        #39'TAN'#39': tangente'
        #39'LOG'#39': logarithme decimal'
        #39'ARCSIN'#39': arc sinus'
        #39'ARCCOS'#39': arc cosinus'
        #39'ARCTAN'#39': arc tangente'
        #39'LN'#39'  logarithme neperien'
        #39'EXP'#39': exponecielle'
        #39'SQRT'#39': racine carre'
        #39'E'#39': equivalent a 10^'
        #39'PI'#39': valeur de pi')
      TabOrder = 0
      WordWrap = False
    end
  end
end
