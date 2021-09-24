"
I am a simple calculator widget. I can only ask for the calculation of multiplication. 
For multiplying i delegate to the multiplication service. 
The multiplication service can be provided by the usage of CoyaSpecArithmeticalServiceWidget. 
While non service is supplied the widget will not be able to produce any result 
"
Class {
	#name : #CoyaSpecCalculatorWidget,
	#superclass : #CoyaSpecWidget,
	#instVars : [
		'label',
		'input1',
		'input2',
		'multiply',
		'inputResult'
	],
	#category : #'Coya-Spec-Examples'
}

{ #category : #specs }
CoyaSpecCalculatorWidget class >> defaultSpec [

	^ SpBoxLayout newTopToBottom
		  add: #label;
		  add: (SpBoxLayout newLeftToRight
				   add: #input1;
					add: #multiply;
				   add: #input2) height: 30;
		  add: #inputResult
]

{ #category : #specs }
CoyaSpecCalculatorWidget class >> open [

	<example>
	self new openWithSpec
]

{ #category : #initialization }
CoyaSpecCalculatorWidget >> initializePresenters [

	super initializePresenters.
	label := self newLabel label: ' Insert the numbers to multiply '.
	input1 := self newNumberInput.
	input2 := self newNumberInput.
	inputResult := self newNumberInput.
	multiply := self newButton
		            label: 'X';
		            action: [ 
			            inputResult number:
					            (self request: #arithmeticalService argument: { 
								             input1 number.
								             input2 number }) ]
]
