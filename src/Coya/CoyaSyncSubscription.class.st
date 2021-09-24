"
I am a synchronous subscription that allows to set callbacks, but however i do also store the last value received. 
"
Class {
	#name : #CoyaSyncSubscription,
	#superclass : #CoyaAsyncSubscription,
	#instVars : [
		'value'
	],
	#category : #'Coya-Topics'
}

{ #category : #accessing }
CoyaSyncSubscription >> privateSetValue: aValue [
	value := aValue.
]

{ #category : #accessing }
CoyaSyncSubscription >> receive: anObject [
	value := anObject .
	super receive: anObject.
]

{ #category : #accessing }
CoyaSyncSubscription >> unsubscribe [

	super unsubscribe.
	value := nil
]

{ #category : #accessing }
CoyaSyncSubscription >> value [
	^ value
]
