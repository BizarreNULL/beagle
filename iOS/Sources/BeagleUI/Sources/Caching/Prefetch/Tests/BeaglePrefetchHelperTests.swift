//
//  Copyright © 18/12/19 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI
import SnapshotTesting

final class BeaglePrefetchHelperTests: XCTestCase {

    struct Dependencies: DependencyNetwork, DependencyCacheManager {
        var cacheManager: CacheManagerProtocol
        let network: Network
    }
    
    func testPrefetchAndDequeue() {
        let remoteComponent = ComponentDummy()
        let cacheManager = CacheManager(maximumScreensCapacity: 30)
        let dependencies = Dependencies(cacheManager: cacheManager, network: NetworkStub(componentResult: .success(remoteComponent)))
        let sut = BeaglePreFetchHelper()
        let url = "url-test"

        sut.prefetchComponent(newPath: .init(path: url, shouldPrefetch: true), dependencies: dependencies)
        let result = dependencies.cacheManager.dequeueComponent(path: url)
        
        XCTAssertEqual(remoteComponent, result as? ComponentDummy)
    }
    
    func testPrefetchTheSameScreenTwice() {
        let remoteComponent = ComponentDummy()
        let cacheManager = CacheManager(maximumScreensCapacity: 30)
        let dependencies = Dependencies(cacheManager: cacheManager, network: NetworkStub(componentResult: .success(remoteComponent)))
        let sut = BeaglePreFetchHelper()
        let url = "url-test"

        sut.prefetchComponent(newPath: .init(path: url, shouldPrefetch: true), dependencies: dependencies)
        let result1 = dependencies.cacheManager.dequeueComponent(path: url)
        sut.prefetchComponent(newPath: .init(path: url, shouldPrefetch: true), dependencies: dependencies)
        let result2 = dependencies.cacheManager.dequeueComponent(path: url)
        
        XCTAssertEqual(remoteComponent, result1 as? ComponentDummy)
        XCTAssertEqual(remoteComponent, result2 as? ComponentDummy)
    }
    
    func testPrefetchFail() {
        let dependencies = Dependencies(
            cacheManager: CacheManager(
                maximumScreensCapacity: 30
            ),
            network: NetworkStub(
                componentResult: .failure(.networkError(
                    NSError(domain: "test", code: 1, description: "forced"))
                )
            )
        )
        let sut = BeaglePreFetchHelper()
        let url = "url-test"
        
        sut.prefetchComponent(newPath: .init(path: url, shouldPrefetch: true), dependencies: dependencies)
        let result = dependencies.cacheManager.dequeueComponent(path: url)
        
        XCTAssertNil(result)
    }

    func testNavigationIsPrefetchable() {
        let path = "path"
        let data = ["data": "value"]
        let screen = Container(children: [])

        let actions: [Navigate] = [
            .openDeepLink(.init(path: path, data: nil)),
            .openDeepLink(.init(path: path, data: data)),
            .openDeepLink(.init(path: path, component: screen)),

            .addView(.init(path: path, shouldPrefetch: true)),
            .addView(.init(path: path, shouldPrefetch: false)),
            
            .presentView(.init(path: path, shouldPrefetch: true)),
            .presentView(.init(path: path, shouldPrefetch: false)),
            
            .swapView(.init(path: path, shouldPrefetch: true)),
            .swapView(.init(path: path, shouldPrefetch: false)),
            
            .popView,
            .popToView(path),
            .finishView
        ]

        let bools = actions.map { $0.newPath }

        let result: String = zip(actions, bools).reduce("") { partial, zip in
            "\(partial)  \(zip.0)  -->  \(descriptionWithoutOptional(zip.1)) \n\n"
        }
        assertSnapshot(matching: result, as: .description)
    }

}
