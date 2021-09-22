Class {
	#name : #CoyaSyncSubscription,
	#superclass : #CoyaAbstractSubscription,
	#instVars : [
		'value'
	],
	#category : #Coya
}

{ #category : #accessing }
CoyaSyncSubscription >> receive: anObject [
	value := anObject 
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
