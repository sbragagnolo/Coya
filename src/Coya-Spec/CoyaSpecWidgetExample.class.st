Class {
	#name : #CoyaSpecWidgetExample,
	#superclass : #CoyaSpecWidget,
	#instVars : [
		'#text',
		'#value => CoyaPubSubSlot topic: #bus'
	],
	#category : #'Coya-Spec'
}

{ #category : #specs }
CoyaSpecWidgetExample class >> defaultSpec [

	^ SpBoxLayout newTopToBottom add: #text
]

{ #category : #specs }
CoyaSpecWidgetExample class >> exmple [
	<example> 
	^ self new inspect; openWithSpec. 
]

{ #category : #initialization }
CoyaSpecWidgetExample >> initializePresenters [

	super initializePresenters.
	text := self newText.
	text whenSubmitDo: [ :t | value := t ]
]

{ #category : #initialization }
CoyaSpecWidgetExample >> initializeTopics [

	super initializeTopics.
	"self subscribe: #bus activating: #updateBus:"
]

{ #category : #initialization }
CoyaSpecWidgetExample >> updateBus [

	text text: value  
]

{ #category : #initialization }
CoyaSpecWidgetExample >> updateBus: aValue [
	self halt.
	text text: aValue 
]
