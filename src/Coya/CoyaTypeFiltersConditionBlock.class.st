Class {
	#name : #CoyaTypeFiltersConditionBlock,
	#superclass : #CoyaTypeFilter,
	#instVars : [
		'conditionBlock'
	],
	#category : #Coya
}

{ #category : #accessing }
CoyaTypeFiltersConditionBlock >> conditionBlock: aBlock [

	self assert: aBlock isClean.
	conditionBlock := aBlock
]

{ #category : #accessing }
CoyaTypeFiltersConditionBlock >> filter: aMessage [

	^ conditionBlock value: aMessage
]

{ #category : #accessing }
CoyaTypeFiltersConditionBlock >> isConditionFilter [

	^ true
]
