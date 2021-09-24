"
I allow to duck-type by registering constraints such as ""shouldUnderstand"" 
"
Class {
	#name : #CoyaFilter,
	#superclass : #Object,
	#instVars : [
		'rules'
	],
	#category : #Coya
}

{ #category : #accessing }
CoyaFilter class >> all [

	^ self new
]

{ #category : #accessing }
CoyaFilter class >> default [
	^ self all
]

{ #category : #accessing }
CoyaFilter class >> none [

	^ self new
		  shouldRefuseAll;
		  yourself
]

{ #category : #accessing }
CoyaFilter class >> shouldBeKindOf: aClass [

	^ self new
		  shouldBeKindOf: aClass;
		  yourself
]

{ #category : #accessing }
CoyaFilter class >> shouldComplyWithType: aTrait [

	^ self new
		  shouldComplyWithType: aTrait;
		  yourself
]

{ #category : #accessing }
CoyaFilter class >> shouldUnderstand: aSelector [

	^ self new
		  shouldUnderstand: aSelector;
		  yourself
]

{ #category : #accessing }
CoyaFilter class >> shouldUnderstandAll: aCollectionOfSelectors [

	| instance |
	instance := self new.
	aCollectionOfSelectors do: [ :a | instance shouldUnderstand: a ].
	^ instance
]

{ #category : #accessing }
CoyaFilter class >> shouldUse: aTrait [

	^ self new
		  shouldUse: aTrait;
		  yourself
]

{ #category : #asserting }
CoyaFilter >> filter: anObject [

	^ rules allSatisfy: [ :r | r value: anObject ]
]

{ #category : #asserting }
CoyaFilter >> initialize [

	super initialize.
	rules := Set new
]

{ #category : #testing }
CoyaFilter >> isTypeConstraint [

	^ true
]

{ #category : #asserting }
CoyaFilter >> shouldBeKindOf: aClass [
	rules add: [ :a | a isKindOf: aClass ]
]

{ #category : #asserting }
CoyaFilter >> shouldComplyWithType: aTrait [

	aTrait selectors do: [ :s | 
		rules add: [ :a | a respondsTo: s asSymbol ] ]
]

{ #category : #asserting }
CoyaFilter >> shouldRefuseAll [

	rules add: [ :a | false ]
]

{ #category : #asserting }
CoyaFilter >> shouldUnderstand: aString [

	rules add: [ :a | a respondsTo: aString asSymbol ]
]

{ #category : #asserting }
CoyaFilter >> shouldUse: aTrait [

	rules add: [ :a | a usesTrait: aTrait ]
]
