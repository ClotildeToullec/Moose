Extension { #name : #MooseEntity }

{ #category : #'*Moose-Finder' }
MooseEntity >> asMooseFinderItemNamed: aString in: aMooseEntity [
	| itemName |
	itemName := aString capitalized, ': ', self mooseName.
	^ MooseGroup with: self withDescription: itemName
]

{ #category : #'*Moose-Finder' }
MooseEntity >> bookmarkEntity [
	<menuItem: 'Bookmark Entity' category: 'Utilities'>
	
	| groupName |
	groupName := UIManager default 
		request: 'Enter description'
		initialAnswer: self description.
	(groupName isNil or: [ groupName size = 0 ]) ifTrue: [ ^ self ].
	self bookmarkAs: groupName		
]

{ #category : #'*Moose-Finder' }
MooseEntity >> complexPropertyPragmas [
	| navProps definedProps |
	navProps := (Pragma allNamed: #navigation: from: self class to: MooseEntity) sorted: [ :a :b | (a argumentAt: 1) < (b argumentAt: 1) ].
	definedProps := (self mooseDescription allProperties reject: [ :a | a type isPrimitive ])
		flatCollect: [ :prop | prop compiledMethod pragmas select: [ :each | each selector beginsWith: 'FMProperty:' ] ].
	^ (OrderedCollection withAll: definedProps)
		addAll: navProps;
		yourself
]

{ #category : #'*Moose-Finder' }
MooseEntity >> customNavigationItems [

	^ {  }
]

{ #category : #'*Moose-Finder' }
MooseEntity class >> formatForNavigationPresentation [
	^ 'All ', self name, ' - '
]

{ #category : #'*Moose-Finder' }
MooseEntity >> gtInspectorActionOpenInMoose [
	<gtInspectorAction>
	[self mooseDescription] on: NotFound do: [ ^ GLMGenericAction new
				action: [ self inform: 'Moose description not initialized' ];
				icon: (Smalltalk ui icons iconNamed: #error);
				title: 'Moose description not initialized' ].
	^ GLMGenericAction new
		action: [ self openInMoose ];
		icon: MooseIcons mooseIcon asGrayScaleWithAlpha;
		title: 'Open in Moose'
]

{ #category : #'*Moose-Finder' }
MooseEntity >> gtInspectorPresentationsIn: composite inContext: aGTInspector [
	| pragmas |
	[self mooseDescription] on: NotFound do: [ super gtInspectorPresentationsIn: composite inContext: aGTInspector.
		^ self ].
	pragmas := Pragma
		allNamed: #moosePresentationOrder:
		from: self mooseInterestingEntity class
		to: Object
		sortedUsing: [ :x :y | (x argumentAt: 1) < (y argumentAt: 1) ].
	pragmas
		do: [ :eachPragma | 
			(eachPragma methodSelector findTokens: $:) size = 1
				ifTrue: [ self mooseInterestingEntity
						perform: eachPragma methodSelector
						with: composite ].
			(eachPragma methodSelector findTokens: $:) size = 2
				ifTrue: [ self mooseInterestingEntity
						perform: eachPragma methodSelector
						with: composite
						with: aGTInspector ] ].
	super gtInspectorPresentationsIn: composite inContext: aGTInspector
]

{ #category : #'*Moose-Finder' }
MooseEntity >> mooseDescriptionsOfNumberProperties [
	^ self mooseDescription allProperties select: [ :each | each type = FM3Number instance ]
]

{ #category : #'*Moose-Finder' }
MooseEntity >> mooseFinderFameDescription: composite [
	<moosePresentationOrder: 400>
	self mooseDescription ifNil: [ ^ self ].
	(self mooseDescription gtInspectorRelationsIn: composite)
		title: 'Fame';
		titleIcon: MooseIcons mooseFame
]

{ #category : #'*Moose-Finder' }
MooseEntity >> mooseFinderNavigationIn: composite [
	<moosePresentationOrder: 1>
	self mooseDescription ifNil: [ ^ composite custom: GLMCompositePresentation new].
	composite custom: MooseNavigationPresentation new
]

{ #category : #'*Moose-Finder' }
MooseEntity >> mooseFinderPropertiesIn: composite [
	<moosePresentationOrder: 2>
	composite table
		noSelection;
		title: 'Properties';
		titleIcon: MooseIcons mooseProperties;
		display: [ :anObject | anObject mooseInterestingEntity mooseDescription allPrimitiveProperties ];
		sorted: [:x :y | x name < y name];
		column: 'Properties' evaluated: [:each | each name ];
		column: 'Value' evaluated: [:each :anObject | [(anObject mooseInterestingEntity mmGetProperty: each) asString] on: Error do: ['error'] ];
		when: [ :anObject | 
			(anObject mooseInterestingEntity isKindOf: MooseEntity) and: [
				anObject mooseInterestingEntity mooseDescription notNil and: [anObject mooseInterestingEntity mooseDescription allPrimitiveProperties notEmpty] ]].
]

{ #category : #'*Moose-Finder' }
MooseEntity >> mooseIcon [
	^ MooseIcons mooseMetamodelEntity
]

{ #category : #'*Moose-Finder' }
MooseEntity >> mooseSpecificSpotterProcessorsFor: aSpotterStep [
	| entity assocs pragmaValueAssociations |
	entity := self mooseInterestingEntity.
	pragmaValueAssociations := entity complexPropertyPragmas
		collect: [ :pragma | 
			pragma
				->
					([self mooseInterestingEntity perform: pragma methodSelector] ifError: [nil])
						mooseInterestingEntity ].
	assocs := (pragmaValueAssociations
		reject: [ :association | 
			association value isNil
				or: [ association value isCollection and: [ association value isEmpty ] ] ])
		sorted: [ :a :b | 
			(a key argumentAt: 1) asLowercase asString
				< (b key argumentAt: 1) asLowercase asString ].
	assocs
		do: [ :assoc | 
			aSpotterStep listProcessor
				allCandidates: [ assoc value asMooseGroup ];
				title: (assoc key argumentAt: 1);
				itemIcon: #mooseIcon;
				filter: GTFilterSubstring;
				itemName: #gtDisplayString;
				order: 1 ]
]

{ #category : #'*Moose-Finder' }
MooseEntity >> navigationItemsFromAttributes [
	| entity assocs attrs result |
	
	"returns associations in form name->object for navigation entities obtained from
	the the meta-model attributes of the item"
	
	entity := self mooseInterestingEntity.
	attrs := entity mooseDescription allProperties reject: [ :attribute | attribute type isPrimitive ].
	assocs := attrs collect: [ :anAttribute | anAttribute -> (entity perform: anAttribute compiledMethod selector) ].
	
	"filter out nils and empty collections, sort"
	result := (assocs
		reject: [ :association | 
			association value isNil
				or: [ association value isCollection and: [ association value isEmpty ] ] ])
		sorted: [ :a :b |
			a key formatForNavigationPresentation asLowercase asString
				< b key formatForNavigationPresentation asLowercase asString ].
	^ result

]

{ #category : #'*Moose-Finder' }
MooseEntity >> navigationItemsFromPragmas [
	| entity assocs pragmaValueAssociations |
	
	"returns associations in form name->object for navigation entities obtained from
	the pragma #navigation:"
	
	entity := self mooseInterestingEntity.
	pragmaValueAssociations := entity navigationPragmas
		collect: [ :pragma | 
			pragma
				->
					([self mooseInterestingEntity perform: pragma methodSelector] ifError: [nil])
						mooseInterestingEntity ].
					
	"filter out nils and empty collections, sort"
	assocs := (pragmaValueAssociations
		reject: [ :association | 
			association value isNil
				or: [ association value isCollection and: [ association value isEmpty ] ] ])
		sorted: [ :a :b | 
			(a key argumentAt: 1) asLowercase asString
				< (b key argumentAt: 1) asLowercase asString ].
	^ assocs

]

{ #category : #'*Moose-Finder' }
MooseEntity >> navigationPragmas [
	| navProps |
	navProps := (Pragma
		allNamed: #navigation:
		from: self class
		to: MooseEntity)
		sorted: [ :a :b | (a argumentAt: 1) < (b argumentAt: 1) ].
		
	^ navProps asOrderedCollection.
]

{ #category : #'*Moose-Finder' }
MooseEntity >> openInEasel [

	^ self openInGlamorousRoassalEasel
]

{ #category : #'*Moose-Finder' }
MooseEntity >> openInGlamorousEditor [
	<menuItem: 'In Glamour Editor' category: 'Browse'> 

	| symbol className prefixesToIgnore |
	prefixesToIgnore := #( 'FAMIX' 'MSE' 'Moose').
	className := self class name asString.
	prefixesToIgnore do: [:each |
		(className beginsWith: each) ifTrue: [
			className := className copyFrom: each size + 1 to: className size] ].
	symbol := className at: 1 put: className first asLowercase; yourself.
	^ (GLMEditor openOn: { symbol asSymbol -> self }) maximize
]

{ #category : #'*Moose-Finder' }
MooseEntity >> spotterProcessorsFor: aSpotterStep [
	super spotterProcessorsFor: aSpotterStep.
	[ self mooseSpecificSpotterProcessorsFor: aSpotterStep ]
		on: NotFound
		do: [ Transcript crTrace: 'The entity description is not present in its moose model metamodel' ]
]
