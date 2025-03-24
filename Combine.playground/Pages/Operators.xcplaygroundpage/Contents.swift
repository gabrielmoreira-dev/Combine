print("--------- Transformation Operators ----------")

TransformationOperators.executeMap()
TransformationOperators.executeFlatMap()
TransformationOperators.executeMerge()

print("\n\n---------- Filtering Operators -----------")

FilteringOperators.executeFilter()
FilteringOperators.executeCompactMap()
FilteringOperators.executeDebounce()

print("\n\n---------- Combining Operators -----------")

CombiningOperators.executeCombineLatest()
CombiningOperators.executeZip()
CombiningOperators.executeSwitchToLatest()

print("\n\n--------- Error Handling Operators ----------")

ErrorHandlingOperators.executeCatch()
ErrorHandlingOperators.executeReplaceError()
ErrorHandlingOperators.executeRetry()

print("\n\n----------- Custom Operator ------------")

CustomOperator.execute()
