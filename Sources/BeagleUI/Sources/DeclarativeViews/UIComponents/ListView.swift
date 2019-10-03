//
//  ListView.swift
//  BeagleUI
//
//  Created by Daniel Tes on 12/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

public struct ListView: Widget {
    
    public let rows: [Widget]?
    public let remoteDataSource: String?
    public let loadingState: Widget?
    public let direction: Direction
    
    init(
        rows: [Widget]? = nil,
        remoteDataSource: String? = nil,
        loadingState: Widget? = nil,
        direction: Direction = .vertical
    ) {
        self.rows = rows
        self.remoteDataSource = remoteDataSource
        self.loadingState = loadingState
        self.direction = direction
    }
    
    public init(
        @WidgetBuilder _ rowBuilder: () -> Widget
    ) {
        let singleRow = rowBuilder()
        self.init(rows: [singleRow])
    }
    
    public init(
        @WidgetArrayBuilder _ rowsBuilder: () -> [Widget]
    ) {
        let rows = rowsBuilder()
        self.init(rows: rows)
    }
    
    public func remoteDataSource(_ remoteDataSource: String) -> ListView {
        return ListView(
            rows: rows,
            remoteDataSource: remoteDataSource,
            loadingState: loadingState,
            direction: direction
        )
    }
    
    public func loadingState(_ loadingStateBuilder: () -> Widget) -> ListView {
        let loadingState = loadingStateBuilder()
        return ListView(
            rows: rows,
            remoteDataSource: remoteDataSource,
            loadingState: loadingState,
            direction: direction
        )
    }
    
    public func direction(_ direction: Direction) -> ListView {
        return ListView(
            rows: rows,
            remoteDataSource: remoteDataSource,
            loadingState: loadingState,
            direction: direction
        )
    }
    
}
extension ListView {
    public enum Direction {
        case vertical
        case horizontal
    }
}
