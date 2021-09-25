"
Test Widget. 
I am here to set stuff and connect. 
"
Class {
	#name : #CoyaTestSpecWidget,
	#superclass : #CoyaSpecWidget,
	#instVars : [
		'#text',
		'#link => CoyaPubSubSlot topic: #link type: #String',
		'#link2 => CoyaSubscribeSlot topic: #link2 type: #String selector:#setLink2'
	],
	#category : #'Coya-Tests'
}

{ #category : #specs }
CoyaTestSpecWidget class >> defaultSpec [

	^ SpBoxLayout newTopToBottom add: #text
]

{ #category : #updating }
CoyaTestSpecWidget >> currentText [

	^ text text
]

{ #category : #updating }
CoyaTestSpecWidget >> initializePresenters [
	| a |
	super initializePresenters.
	text := self newText.
	a := link2. 
	link := ''.
	text text: link.
]

{ #category : #updating }
CoyaTestSpecWidget >> setLink1 [
	text text: link
]

{ #category : #updating }
CoyaTestSpecWidget >> setLink2 [
	text text: link2
]
