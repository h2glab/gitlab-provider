//
//  Page.swift
//  Gitlab
//
//  Created by Martial Maillot on 12/12/2018.
//

import Foundation

public struct Page<GitlabModel> {
    
    public let totalItemCount: Int
    public let itemCountPerPage: Int
    public let totalPageCount: Int
    public let currentPageIndex: Int
    public let nextPageIndex: Int?
    public let prevPageIndex: Int?
    
    public let content: [GitlabModel]
}
