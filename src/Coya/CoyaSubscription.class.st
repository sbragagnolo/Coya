"
I represent a subscription. I am a reading end of a topic. Belong to one speficic owner 
"
Class {
	#name : #CoyaSubscription,
	#superclass : #CoyaTopicRelatedEntity,
	#instVars : [
		'typeFilter',
		'onErrorHook',
		'onReadSend'
	],
	#category : #Coya
}

{ #category : #'as yet unclassified' }
CoyaSubscription >> initialize [

	super initialize.
	typeFilter := CoyaTypeFilter default.
	onErrorHook := [ :error | error debug ]
]

{ #category : #'as yet unclassified' }
CoyaSubscription >> isSubscription [
	^ true
]

{ #category : #accessing }
CoyaSubscription >> onErrorHook: aValuable [

	onErrorHook := aValuable
]

{ #category : #'as yet unclassified' }
CoyaSubscription >> onReadSend: aMessageSend [ 
	onReadSend := aMessageSend .
	topic welcomeSubscriber: self .
]

{ #category : #'as yet unclassified' }
CoyaSubscription >> onReadSend: aMessage to: anObject [

	^ self onReadSend: (aMessage asSendTo: anObject)
]

{ #category : #accessing }
CoyaSubscription >> receive: anObject [

	[ onReadSend  cull: anObject ]
		on: Error
		do: [ :e | onErrorHook cull: e cull: anObject ]
]

{ #category : #asserting }
CoyaSubscription >> shouldReceive: aMessage from: anOwner [

	owner = anOwner ifTrue: [ ^ false ].
	^ typeFilter filter: aMessage
]

{ #category : #'accessing - structure variables' }
CoyaSubscription >> type: aClass [

	typeFilter := CoyaTypeFiltersClass new
		              filteringClass: aClass;
		              yourself
]

{ #category : #'as yet unclassified' }
CoyaSubscription >> typeConstraint: aFullBlockClosure [

	typeFilter := CoyaTypeFilterConstraint new.
	aFullBlockClosure value: typeFilter
]

{ #category : #'as yet unclassified' }
CoyaSubscription >> typeFilter [
	^ typeFilter
]
