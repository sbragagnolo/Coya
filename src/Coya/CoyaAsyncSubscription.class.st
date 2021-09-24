"
I represent a subscription. I am a reading end of a topic. Belong to one speficic owner 
"
Class {
	#name : #CoyaAsyncSubscription,
	#superclass : #CoyaAbstractSubscription,
	#instVars : [
		'onErrorHook',
		'onReadSend'
	],
	#category : #'Coya-Topics'
}

{ #category : #'as yet unclassified' }
CoyaAsyncSubscription >> initialize [

	super initialize.
	onReadSend := [ :v |  ].
	onErrorHook := [ :error | error debug ]
]

{ #category : #accessing }
CoyaAsyncSubscription >> onErrorHook: aValuable [

	onErrorHook := aValuable
]

{ #category : #'as yet unclassified' }
CoyaAsyncSubscription >> onReadSend: aMessageSend [ 
	onReadSend := aMessageSend .

]

{ #category : #'as yet unclassified' }
CoyaAsyncSubscription >> onReadSend: aMessage to: anObject [

	^ self onReadSend: (aMessage asSendTo: anObject)
]

{ #category : #accessing }
CoyaAsyncSubscription >> receive: anObject from: aSender [

	[ onReadSend cull: anObject cull: aSender ]
		on: Error
		do: [ :e | onErrorHook cull: e cull: anObject ]
]
