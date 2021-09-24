"
I am a simple subscriber widget. I can only show what is happening .
"
Class {
	#name : #CoyaSpecSubscriberExample,
	#superclass : #CoyaSpecWidget,
	#instVars : [
		'#text',
		'#value => CoyaSubscribeSlot topic: #example type: #String selector:#refresh:by:'
	],
	#category : #'Coya-Spec-Examples'
}

{ #category : #specs }
CoyaSpecSubscriberExample class >> defaultSpec [

	^ SpBoxLayout newLeftToRight add: #text
]

{ #category : #specs }
CoyaSpecSubscriberExample class >> title [
	^ 'Subscriber only '
]

{ #category : #accessing }
CoyaSpecSubscriberExample >> initializePresenters [

	super initializePresenters.
	text := self newText.
	text text: value asString. 
]

{ #category : #accessing }
CoyaSpecSubscriberExample >> initializeWindow: aWindow [

	super initializeWindow: aWindow.
	aWindow title: self class title
]

{ #category : #accessing }
CoyaSpecSubscriberExample >> refresh: aVal by: aSender [
	text text: text text , String crlf , aSender asString , '> ' , value
]
