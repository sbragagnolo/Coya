"
I am a simple publishing widget. 
When content is writen into my self is automatically transmited. 
"
Class {
	#name : #CoyaSpecPublisherExample,
	#superclass : #CoyaSpecWidget,
	#instVars : [
		'#text',
		'#value => CoyaPublishSlot topic: #example'
	],
	#category : #'Coya-Spec-Examples'
}

{ #category : #specs }
CoyaSpecPublisherExample class >> defaultSpec [

	^ SpBoxLayout newLeftToRight add: #text
]

{ #category : #specs }
CoyaSpecPublisherExample class >> openAllTopicExample [
	<example> 
	{ 
		self.
		CoyaSpecPublisherSubscriberExample.
		CoyaSpecSubscriberExample } do: [ :a | a new openWithSpec ]
]

{ #category : #specs }
CoyaSpecPublisherExample class >> title [
	^ 'Publisher only '
]

{ #category : #initialization }
CoyaSpecPublisherExample >> initializePresenters [

	super initializePresenters.
	text := self newText.
	text whenSubmitDo: [ :t | value := t ].
	value := ''.
]

{ #category : #initialization }
CoyaSpecPublisherExample >> initializeWindow: aWindow [

	super initializeWindow: aWindow.
	aWindow title: self class title
]
