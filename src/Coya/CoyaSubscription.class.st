Class {
	#name : #CoyaSubscription,
	#superclass : #CoyaTopicRelatedEntity,
	#instVars : [
		'onReadHook',
		'typeFilter',
		'onErrorHook'
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

{ #category : #'as yet unclassified' }
CoyaSubscription >> onReadSend: aMessageSend [ 
	onReadHook := aMessageSend 
]

{ #category : #'as yet unclassified' }
CoyaSubscription >> onReadSend: aMessage to: anObject [

	^ self onReadSend: (aMessage asSendTo: anObject)
]

{ #category : #accessing }
CoyaSubscription >> receive: anObject [

	[ onReadHook cull: anObject ]
		on: Error
		do: [ :e | onErrorHook cull: e cull: anObject ]
]

{ #category : #asserting }
CoyaSubscription >> shouldReceive: aMessage [

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
