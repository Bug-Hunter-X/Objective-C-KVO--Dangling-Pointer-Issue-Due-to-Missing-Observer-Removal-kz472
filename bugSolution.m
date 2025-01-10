The solution involves ensuring that the observer is removed using `removeObserver:` before the observed object is deallocated or becomes unreachable.  In the `MyViewController`'s `- (void)dealloc` method (or before setting `observedObject` to nil):

```objectivec
@implementation MyViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    MyObservedObject *observedObject = [[MyObservedObject alloc] init];
    [observedObject addObserver:self forKeyPath:@"observedProperty" options:NSKeyValueObservingOptionNew context:NULL];
    // ... later ...
    [observedObject removeObserver:self forKeyPath:@"observedProperty"]; // Added this line
    observedObject = nil; 
}

- (void)dealloc {
  [super dealloc];
}
@end
```

Alternatively, using `@weakify` and `@strongify` macros from libraries like ReactiveCocoa (if applicable) can help manage strong references and prevent these kinds of issues.  Always ensure proper cleanup in `dealloc` methods, especially for objects participating in KVO relationships.