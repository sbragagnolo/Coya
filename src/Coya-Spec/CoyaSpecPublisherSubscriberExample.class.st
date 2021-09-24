"
I am a publisher / subscriber widget. 
I publish when <meta+s> is invoked. 
"
Class {
	#name : #CoyaSpecPublisherSubscriberExample,
	#superclass : #CoyaSpecWidget,
	#instVars : [
		'#text',
		'#value => CoyaPubSubSlot topic: #example type: #String selector:#refresh'
	],
	#category : #'Coya-Spec-Examples'
}

{ #category : #specs }
CoyaSpecPublisherSubscriberExample class >> defaultSpec [

	^ SpBoxLayout newLeftToRight add: #text
]

{ #category : #specs }
CoyaSpecPublisherSubscriberExample class >> title [

	^ 'PubSub'
]

{ #category : #updating }
CoyaSpecPublisherSubscriberExample >> initializePresenters [

	super initializePresenters.
	text := self newText.
	text whenSubmitDo: [ :t | value := t ].
	value := ''.
	text text: value. 
]

{ #category : #updating }
CoyaSpecPublisherSubscriberExample >> initializeWindow: aWindow [

	super initializeWindow: aWindow.
	aWindow title: self class title
]

{ #category : #updating }
CoyaSpecPublisherSubscriberExample >> refresh [
	 text text: value. 
]
