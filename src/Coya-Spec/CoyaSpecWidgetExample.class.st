Class {
	#name : #CoyaSpecWidgetExample,
	#superclass : #CoyaSpecWidget,
	#instVars : [
		'#value => CoyaPublishSlot topic: #bus',
		'#text'
	],
	#category : #'Coya-Spec'
}

{ #category : #specs }
CoyaSpecWidgetExample class >> defaultSpec [

	^ SpBoxLayout newTopToBottom add: #text
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
	((self coya findOrCreateTopic: #bus) subscriptionFor: self)
		onReadSend: (Message selector: #updateBus:) to: self;
		type: String
]

{ #category : #initialization }
CoyaSpecWidgetExample >> updateBus: aValue [
	text text: aValue 
]
