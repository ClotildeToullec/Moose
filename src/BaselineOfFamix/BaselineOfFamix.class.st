"
Description
--------------------

Baseline for the Famix project
"
Class {
	#name : #BaselineOfFamix,
	#superclass : #BaselineOf,
	#instVars : [
		'repository'
	],
	#category : #BaselineOfFamix
}

{ #category : #baseline }
BaselineOfFamix >> baseline: spec [
	<baseline>
	repository := self packageRepositoryURL.

	spec
		for: #common
		do: [ "Dependencies"
			self
				deepTraverser: spec;
				fame: spec;
				kgbTestResources: spec;
				collectionExtensions: spec;
				packageBlueprintTestResources: spec;
				referenceTestResources: spec;
				neoCSV: spec;
				roelTyper: spec;
				singularizePluralize: spec.

			"Packages"
			spec
				package: 'Moose-Query' with: [ spec requires: #('Fame' 'DeepTraverser' 'CollectionExtensions') ];
				package: 'Moose-Core' with: [ spec requires: #('Fame' 'Moose-Query') ];
				package: 'Moose-Query-Extensions' with: [ spec requires: #('Moose-Query' 'BasicTraits') ];
				package: 'Famix-Groups' with: [ spec requires: #('Moose-Core' 'NeoCSV') ];
				package: 'Famix-Traits' with: [ spec requires: #('Famix-Groups' 'Moose-Core') ];
				package: 'Famix-MetamodelBuilder-Core' with: [ spec requires: #('Moose-Core' 'SingularizePluralize') ];
				package: 'Famix-MetamodelGeneration' with: [ spec requires: #('Famix-MetamodelBuilder-Core') ];
				package: 'Famix-BasicInfrastructure' with: [ spec requires: #('Famix-MetamodelGeneration') ];
				package: 'Famix-Smalltalk-Utils' with: [ spec requires: #('Moose-Core') ];
				package: 'Moose-GenericImporter' with: [ spec requires: #('BasicTraits') ];
				package: 'Moose-SmalltalkImporter' with: [ spec requires: #('Moose-GenericImporter' 'RoelTyper' 'Famix-PharoSmalltalk-Entities') ];
	
				package: 'Famix-Compatibility-Generator' with: [ spec requires: #('Basic') ];
				package: 'Famix-Compatibility-Entities' with: [ spec requires: #('BasicTraits' 'Famix-Smalltalk-Utils') ];
				package: 'Famix-Compatibility-Tests-C' with: [ spec requires: #('Famix-Compatibility-Entities') ];
				package: 'Famix-Compatibility-Tests-Core' with: [ spec requires: #('Famix-Compatibility-Entities' 'Moose-Tests-SmalltalkImporter-LAN' 'Moose-Tests-SmalltalkImporter-KGB') ];
				package: 'Famix-VerveineJ-Tests' with: [ spec requires: #('Moose-Tests-Core' 'Famix-Compatibility-Entities') ];

				package: 'Famix-PharoSmalltalk-Generator' with: [ spec requires: #('Basic') ];
				package: 'Famix-PharoSmalltalk-Entities' with: [ spec requires: #('Famix-Smalltalk-Utils' 'BasicTraits') ];
				package: 'Famix-PharoSmalltalk-Tests' with: [ spec requires: #('Famix-PharoSmalltalk-Entities' 'Moose-Tests-SmalltalkImporter-Core' 'PackageBlueprintTestResources' 'Moose-TestResources-LCOM' 'KGBTestResources') ];

				package: 'Famix-Java-Generator' with: [ spec requires: #('Basic') ];
				package: 'Famix-Java-Entities' with: [ spec requires: #('BasicTraits') ];
				package: 'Famix-Java-Tests' with: [ spec requires: #('Famix-Java-Entities' 'Famix-Java-Generator') ];

				package: 'Moose-TestResources-LAN';
				package: 'Moose-TestResources-LCOM';

				package: 'Moose-Query-Test' with: [ spec requires: #('Moose-Query' 'Famix-Java-Entities') ];
				package: 'FamixTestGenerator' with: [ spec requires: #('BasicTraits') ];
				package: 'Famix-Tests' with: [ spec requires: #('BasicTraits') ];
				package: 'Moose-Tests-Core' with: [ spec requires: #('TestModels') ];
				package: 'Famix-Groups-Tests' with: [ spec requires: #('Famix-Groups' 'Moose-Tests-Core') ];
				package: 'Moose-GenericImporters-Tests' with: [ spec requires: #('Moose-GenericImporter') ];
				
				package: 'Famix-Smalltalk-Utils-Tests' with: [ spec requires: #('Famix-Smalltalk-Utils' 'ReferenceTestResources') ];
				package: 'Moose-Tests-SmalltalkImporter-Core' with: [ spec requires: #('Moose-Tests-Core' 'Moose-SmalltalkImporter' 'ReferenceTestResources') ];
				package: 'Moose-Tests-SmalltalkImporter-LAN' with: [ spec requires: #('Moose-Tests-SmalltalkImporter-Core' 'Moose-TestResources-LAN') ];
				package: 'Moose-Tests-SmalltalkImporter-KGB' with: [ spec requires: #('KGBTestResources' 'Moose-Tests-SmalltalkImporter-Core') ];

				package: 'Famix-TestGenerators' with: [ spec requires: #('Basic') ];
				package: 'Famix-MetamodelBuilder-Tests' with: [ spec requires: #('Famix-TestGenerators') ];
				
				package: 'Famix-Test1-Entities' with: [ spec requires: #('BasicTraits') ];
				package: 'Famix-Test1-Tests' with: [ spec requires: #('Famix-Test1-Entities') ];
				package: 'Famix-Test2-Entities' with: [ spec requires: #('BasicTraits') ];
				package: 'Famix-Test2-Tests' with: [ spec requires: #('Famix-Test2-Entities') ];
				package: 'Famix-Test3-Entities' with: [ spec requires: #('BasicTraits') ];
				package: 'Famix-Test3-Tests' with: [ spec requires: #('Famix-Test3-Entities') ];
				package: 'Famix-Test4-Entities' with: [ spec requires: #('BasicTraits') ];
				package: 'Famix-Test4-Tests' with: [ spec requires: #('Famix-Test4-Entities') ];
				package: 'Famix-Test5-Entities' with: [ spec requires: #('BasicTraits') ];
				package: 'Famix-Test5-Tests' with: [ spec requires: #('Famix-Test5-Entities') ];
				package: 'Famix-TestComposedSubmetamodel1-Entities' with: [ spec requires: #('BasicTraits') ];
				package: 'Famix-TestComposedSubmetamodel2-Entities' with: [ spec requires: #('BasicTraits') ];
				package: 'Famix-TestComposedMetamodel-Entities' with: [ spec requires: #('Famix-Test2-Entities' 'Famix-TestComposedSubmetamodel1-Entities' 'Famix-TestComposedSubmetamodel2-Entities') ];
				package: 'Famix-TestComposedComposedMetamodel-Entities' with: [ spec requires: #('Famix-TestComposedMetamodel-Entities') ];
				package: 'Famix-TestComposed3Metamodel-Entities' with: [ spec requires: #('Famix-TestComposedMetamodel-Entities') ];
				package: 'Famix-TestComposedMetamodel' with: [ spec requires: #('Famix-TestComposedMetamodel-Entities') ];

				package: 'Famix-Deprecated' with: [ spec requires: #('Core' 'ModelCompatibility' 'ModelJava' 'ModelSmalltalk' 'Tests') ].

			"Groups"
			spec
				group: 'Core' with: #('Famix-Traits' 'Moose-Query-Extensions');
				group: 'Basic' with: #('Famix-BasicInfrastructure' 'Famix-MetamodelGeneration');
				group: 'TestsResources' with: #('ReferenceTestResources' 'Moose-TestResources-LAN' 'Moose-TestResources-LCOM' 'KGBTestResources' 'PackageBlueprintTestResources');
				group: 'BasicTraits' with: #('Famix-Traits');
				group: 'EntitiesCompatibility' with: #('Famix-Compatibility-Entities');
				group: 'ModelCompatibility' with: #('Famix-Compatibility-Generator' 'EntitiesCompatibility');
				group: 'EntitiesJava' with: #('Famix-Java-Entities');
				group: 'ModelJava' with: #('Famix-Java-Generator' 'EntitiesJava');
				group: 'EntitiesSmalltalk' with: #('Famix-PharoSmalltalk-Entities');
				group: 'ModelSmalltalk' with: #('Famix-PharoSmalltalk-Generator' 'EntitiesSmalltalk');
				group: 'Importers' with: #('Moose-GenericImporter' 'Moose-SmalltalkImporter');
				group: 'TestModels' with: #('Famix-Test1-Entities' 'Famix-Test2-Entities' 'Famix-Test3-Entities' 'Famix-Test4-Entities');
				group: 'Tests'
					with:
					#('Famix-Tests' 'Moose-Query-Test' 'Moose-Tests-Core' 'Famix-Smalltalk-Utils-Tests' 'Moose-Tests-SmalltalkImporter-LAN' 'Moose-Tests-SmalltalkImporter-Core' 'Moose-Tests-SmalltalkImporter-KGB' 'Famix-Java-Tests' 'Famix-Groups-Tests' 'Famix-Compatibility-Tests-C' 'Famix-VerveineJ-Tests' 'Famix-Compatibility-Tests-Core' 'Famix-PharoSmalltalk-Tests' 'Famix-TestGenerators' 'Famix-MetamodelBuilder-Tests' 'Famix-Test1-Tests' 'Famix-Test2-Tests' 'Famix-Test3-Tests' 'Famix-Test4-Tests' 'Famix-TestComposedSubmetamodel1-Entities' 'Famix-TestComposedSubmetamodel2-Entities' 'Famix-TestComposedMetamodel-Entities' 'Famix-TestComposedMetamodel' 'Famix-TestComposedComposedMetamodel-Entities' 'Famix-TestComposed3Metamodel-Entities' 'Moose-GenericImporters-Tests') ].

	spec
		for: #'pharo7.x'
		do: [ self ring2: spec.
			self parametrizedTests: spec.
			spec
				package: 'Famix-MetamodelBuilder-Core' with: [ spec requires: #('Ring2') ];
				package: 'Moose-Core' with: [ spec includes: #('Famix-Pharo7' 'ParametrizedTests') ];
				package: 'Famix-Pharo7' ]
]

{ #category : #dependencies }
BaselineOfFamix >> collectionExtensions: spec [
	spec
		baseline: 'CollectionExtensions'
		with: [ spec
				loads: 'Core';
				repository: 'github://pharo-contributions/CollectionExtensions:v1.x.x/src' ]
]

{ #category : #dependencies }
BaselineOfFamix >> deepTraverser: spec [
	spec
		baseline: 'DeepTraverser'
		with: [ spec
				loads: 'Core';
				repository: 'github://pharo-contributions/DeepTraverser:v1.x.x/src' ]
]

{ #category : #dependencies }
BaselineOfFamix >> fame: spec [
	spec baseline: 'Fame' with: [ spec repository: repository ]
]

{ #category : #dependencies }
BaselineOfFamix >> kgbTestResources: spec [
	spec baseline: 'KGBTestResources' with: [ spec repository: 'github://moosetechnology/KGBTestResources:v1.x.x/src' ]
]

{ #category : #dependencies }
BaselineOfFamix >> neoCSV: spec [
	spec
		baseline: 'NeoCSV'
		with: [ spec
				loads: 'core';
				repository: 'github://svenvc/NeoCSV/repository' ]
]

{ #category : #dependencies }
BaselineOfFamix >> packageBlueprintTestResources: spec [
	spec baseline: 'PackageBlueprintTestResources' with: [ spec repository: 'github://moosetechnology/PackageBlueprintTestResources:v1.x.x/src' ]
]

{ #category : #accessing }
BaselineOfFamix >> packageRepositoryURL [
	^ super packageRepositoryURL
		ifEmpty: [ | packageName |
			packageName := self class package name.
			'tonel://' , (IceRepository registry detect: [ :repo | repo workingCopy packageNames includes: packageName ] ifFound: [ :repo | repo location pathString , '/' , repo subdirectory ] ifNone: [ '' ]) ]
]

{ #category : #baseline }
BaselineOfFamix >> parametrizedTests: spec [
	spec
		baseline: 'ParametrizedTests'
		with: [ spec repository: 'github://tesonep/ParametrizedTests/src' ]
]

{ #category : #accessing }
BaselineOfFamix >> projectClass [
	^ MetacelloCypressBaselineProject
]

{ #category : #dependencies }
BaselineOfFamix >> referenceTestResources: spec [
	spec baseline: 'ReferenceTestResources' with: [ spec repository: 'github://moosetechnology/ReferenceTestResources:v1.x.x/src' ]
]

{ #category : #baseline }
BaselineOfFamix >> ring2: spec [
	spec
		baseline: 'Ring2'
		with: [ spec
				loads: 'runtimeSupport';
				repository: 'github://pavel-krivanek/Ring2:v1.2.0/src' ]
]

{ #category : #dependencies }
BaselineOfFamix >> roelTyper: spec [
	spec baseline: 'RoelTyper' with: [ spec repository: 'github://RMODINRIA/RoelTyper:v1.x.x/src' ]
]

{ #category : #baseline }
BaselineOfFamix >> singularizePluralize: spec [
	spec baseline: 'SingularizePluralize' with: [ spec repository: 'github://olekscode/SingularizePluralize:v1.0/src' ]
]
