"
I am a silly and barely useful viewer of a a coya instance configuration 
"
Class {
	#name : #CoyaViewer,
	#superclass : #SpPresenter,
	#instVars : [
		'coya',
		'topics',
		'publishers',
		'subscribers'
	],
	#category : #'Coya-Spec'
}

{ #category : #specs }
CoyaViewer class >> defaultSpec [

	^ SpBoxLayout newLeftToRight
		  add: #topics;
		  add: (SpBoxLayout newTopToBottom
				   add: #publishers;
				   add: #subscribers;
				   yourself);
		  yourself
]

{ #category : #specs }
CoyaViewer class >> openOnApp [

	<example>
	self new
		coya: CoyaApplication instance coya ;
		openWithSpec
]

{ #category : #initialization }
CoyaViewer >> coya: aCoya [

	coya := aCoya.
	topics items: (coya topics asOrderedCollection sort: #name)
]

{ #category : #initialization }
CoyaViewer >> initializePresenters [

	super initializePresenters.
	topics := self newList.
	topics display: [ :a | a name ].
	topics whenSelectionChangedDo: [ :sel | 
		sel selectedItem ifNotNil: [ :t | 
			publishers items: t publishers asOrderedCollection.
			subscribers items: t subscribers asOrderedCollection ] ].
	publishers := self newList
		              display: [ :a | 
			              a owner displayString , '==>' , a topic name ];
		              yourself.
	subscribers := self newList
		               display: [ :a | 
			               a topic name , '==>' , a owner displayString ];
		               yourself
]
